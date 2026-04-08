import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../util/AlertDialogueClass.dart';
import '../../util/Mediaquery_Constant.dart';
import '../PaymentPageNew.dart';
import '../Profile/Profile_Screen.dart';
import '../QR_Code/QRCodePageNew.dart';
import '../Voucher/VoucherNoPageNew.dart';
import 'home_provider.dart';
import 'home_widget.dart';

class HomePageNew extends StatefulWidget {
  const HomePageNew({super.key});

  @override
  State<HomePageNew> createState() => _HomePageNewState();
}

class _HomePageNewState extends State<HomePageNew> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    await provider.loadAllData();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return (await ShowAlertDialogueClass.exitAppDialog(context));
      },
      child: Consumer<HomeProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: const Color(0xffFAFCFF),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeHeader(
                      profileImage: provider.profileImage,
                      onProfileTap: () => provider.showLogoutDialog(context),
                    ),
                    PaymentCard(
                      cardHolderName: provider.cardHolderName,
                      cardNumber: provider.cardNumber,
                      expiryDate: provider.getExpiryDate(),
                    ),
                    ServicesTitle(),
                    ServicesGrid(),
                    SizedBox(
                      height:
                          MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                            context,
                          ) *
                          15,
                    ),
                    ServicesGridRow2(),
                    SizedBox(
                      height:
                          MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                            context,
                          ) *
                          15,
                    ),
                    _buildTransactionTabs(context, provider),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: _buildBottomNavigationBar(context, provider),
          );
        },
      ),
    );
  }

  Widget _buildTransactionTabs(BuildContext context, HomeProvider provider) {
    return Padding(
      padding: EdgeInsets.only(
        top:
            MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(context) *
            15,
        left: MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
          context,
        ),
        right: MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
          context,
        ),
      ),
      child: Container(
        color: const Color(0xffFAFCFF),
        child: DefaultTabController(
          length: 3,
          child: SizedBox(
            height: MediaQuery.sizeOf(context).width * 0.505,
            child: Column(
              children: [
                _buildTabBar(context),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildPendingTransactionsList(context, provider),
                      _buildDoneTransactionsList(context, provider),
                      _buildRepayTab(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return TabBar(
      indicatorColor: const Color(0xff3F3F3F),
      labelColor: const Color(0xff3F3F3F),
      labelPadding: const EdgeInsets.only(bottom: 0),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          width:
              MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                context,
              ) *
              4,
          color: const Color(0xff6045FF),
        ),
        insets: EdgeInsets.symmetric(
          horizontal:
              MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                context,
              ) *
              20,
        ),
      ),
      labelStyle: TextStyle(
        fontSize: MediaQueryConstant.getTabSelectedFontSize(context),
        color: const Color(0xff3F3F3F).withOpacity(1),
        fontFamily: 'Metropolis',
        fontWeight: FontWeight.w800,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: MediaQueryConstant.getTabUnSelectedFontSize(context),
        color: const Color(0xff3F3F3F).withOpacity(0.55),
        fontFamily: 'Metropolis',
        fontWeight: FontWeight.w400,
      ),
      tabs: [
        _buildTab(context, 'Due Payment', 0.028),
        _buildTab(context, 'My Paymir', 0.06),
        const Tab(text: 'Repay'),
      ],
    );
  }

  Widget _buildTab(BuildContext context, String text, double leftPadding) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * leftPadding,
              ),
              child: Tab(text: text),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.055),
            Container(
              height: MediaQuery.of(context).size.height * 0.025,
              width: MediaQuery.of(context).size.width * 0.004,
              color: const Color(0xff707070).withOpacity(0.70),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPendingTransactionsList(
    BuildContext context,
    HomeProvider provider,
  ) {
    return RefreshIndicator(
      onRefresh: () => provider.refreshData(),
      child:
          provider.pendingDues.isEmpty
              ? const Center(child: Text('No pending transactions'))
              : ListView.builder(
                itemCount: provider.pendingDues.length,
                itemBuilder: (context, index) {
                  return PendingTransactionItem(
                    transaction: provider.pendingDues[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => PaymentPageNew(
                                provider.pendingDues[index],
                                provider.serviceCharges,
                              ),
                        ),
                      );
                    },
                  );
                },
              ),
    );
  }

  Widget _buildDoneTransactionsList(
    BuildContext context,
    HomeProvider provider,
  ) {
    return RefreshIndicator(
      onRefresh: () => provider.refreshData(),
      child:
          provider.doneTransactions.isEmpty
              ? const Center(child: Text('No completed transactions'))
              : ListView.builder(
                itemCount: provider.doneTransactions.length,
                itemBuilder: (context, index) {
                  return DoneTransactionItem(
                    transaction: provider.doneTransactions[index],
                    onTap:
                        () => provider.showTransactionDetailsDialog(
                          context,
                          provider.doneTransactions[index],
                        ),
                  );
                },
              ),
    );
  }

  Widget _buildRepayTab(BuildContext context) {
    return const Center(
      child: Text('Oftenly used transactions will be displayed here'),
    );
  }

  Widget _buildBottomNavigationBar(
    BuildContext context,
    HomeProvider provider,
  ) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xffFAFCFF),
      selectedItemColor: const Color(0xff424242),
      selectedLabelStyle: TextStyle(
        color: const Color(0xff424242),
        fontFamily: 'Metropolis',
        fontSize: MediaQueryConstant.getGeneralFontSize(context) * 0.016,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: TextStyle(
        color: const Color(0xff424242).withOpacity(0.80),
        fontFamily: 'Metropolis',
        fontSize: MediaQueryConstant.getGeneralFontSize(context) * 0.014,
        fontWeight: FontWeight.w500,
      ),
      items: [
        BottomNavigationBarItem(
          icon: SizedBox(
            width: MediaQuery.of(context).size.width * 0.07,
            height: MediaQuery.of(context).size.width * 0.07,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 2.0),
              child: SvgPicture.asset(
                'assets/images/homeicon.svg',
                color: Colors.grey,
              ),
            ),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: SizedBox(
            width: MediaQuery.of(context).size.width * 0.055,
            height: MediaQuery.of(context).size.width * 0.055,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: SvgPicture.asset(
                'assets/images/paymentbottomlogo.svg',
                color: Colors.grey,
              ),
            ),
          ),
          label: 'Voucher no',
        ),
        BottomNavigationBarItem(
          icon: SizedBox(
            width: MediaQuery.of(context).size.width * 0.055,
            height: MediaQuery.of(context).size.width * 0.055,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: SvgPicture.asset(
                'assets/images/qrcodeicon.svg',
                color: Colors.grey,
              ),
            ),
          ),
          label: 'Qpay',
        ),
        BottomNavigationBarItem(
          icon: SizedBox(
            width: MediaQuery.of(context).size.width * 0.055,
            height: MediaQuery.of(context).size.width * 0.055,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: SvgPicture.asset(
                'assets/images/settingsicon.svg',
                color: Colors.grey,
              ),
            ),
          ),
          label: 'Setting',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: (int index) async {
        switch (index) {
          case 0:
            _onItemTapped(0);
            break;
          case 1:
            _onItemTapped(1);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => VoucherNoPageNew()),
            );
            break;
          case 2:
            _onItemTapped(2);
            final permissionStatus = await Permission.camera.request();
            if (permissionStatus == PermissionStatus.granted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => QRCodeScanner(provider.serviceCharges),
                ),
              );
            }
            break;
          case 3:
            _onItemTapped(3);
            final cnic = await provider.getCNIC();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (_) => ProfileScreen(
                      strCNIC: cnic,
                      cardDataJsonObject: provider.profileData,
                    ),
              ),
            );
            break;
        }
      },
    );
  }
}
