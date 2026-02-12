import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../util/Constants.dart';
import '../../PaymentPageNew.dart';
import '../../home_page/home_provider.dart';
import '../../home_page/home_widget.dart';

/// Home tab content - displays home screen content without bottom navigation
class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    await provider.loadAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          backgroundColor: AppColors.background,
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
                        Constants.getVerticalGapBetweenTwoTextformfields(
                          context,
                        ) *
                        15,
                  ),
                  ServicesGridRow2(),
                  SizedBox(
                    height:
                        Constants.getVerticalGapBetweenTwoTextformfields(
                          context,
                        ) *
                        15,
                  ),
                  _buildTransactionTabs(context, provider),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTransactionTabs(BuildContext context, HomeProvider provider) {
    return Padding(
      padding: EdgeInsets.only(
        top: Constants.getVerticalGapBetweenTwoTextformfields(context) * 15,
        left: Constants.getVerticalGapBetweenTwoTextformfields(context),
        right: Constants.getVerticalGapBetweenTwoTextformfields(context),
      ),
      child: Container(
        color: AppColors.background,
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
      indicatorColor: AppColors.textMedium,
      labelColor: AppColors.textMedium,
      labelPadding: const EdgeInsets.only(bottom: 0),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          width: Constants.getVerticalGapBetweenTwoTextformfields(context) * 4,
          color: AppColors.purpleAccent,
        ),
        insets: EdgeInsets.symmetric(
          horizontal:
              Constants.getVerticalGapBetweenTwoTextformfields(context) * 20,
        ),
      ),
      labelStyle: TextStyle(
        fontSize: Constants.getTabSelectedFontSize(context),
        color: AppColors.textMedium.withOpacity(1),
        fontFamily: 'Metropolis',
        fontWeight: FontWeight.w800,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: Constants.getTabUnSelectedFontSize(context),
        color: AppColors.textMedium.withOpacity(0.55),
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
              color: AppColors.divider.withOpacity(0.70),
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
}
