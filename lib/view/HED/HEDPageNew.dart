import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../util/Constants.dart';
import '../PaymentPageNew.dart';
import 'hed_provider.dart';
import 'hed_widget.dart';

class HEDPageNew extends StatefulWidget {
  const HEDPageNew({super.key});

  @override
  State<HEDPageNew> createState() => _HEDPageNewState();
}

class _HEDPageNewState extends State<HEDPageNew> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final provider = Provider.of<HedProvider>(context, listen: false);
    await provider.loadProfileImage();
  }

  void _handleLoadEntries(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<HedProvider>(context, listen: false);
      provider.loadEntries(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xffFAFCFF),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Consumer<HedProvider>(
                builder: (context, provider, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HedHeader(profileImage: provider.profileImage),
                      MobileNumberSection(
                        controller: provider.mobileController,
                        formKey: _formKey,
                      ),
                      LoadEntriesButton(
                        onPressed: () => _handleLoadEntries(context),
                        isLoading: provider.isLoading,
                      ),
                      SizedBox(
                        height:
                            Constants.getVerticalGapBetweenTwoTextformfields(
                              context,
                            ) *
                            15,
                      ),
                      _buildTransactionTabs(context, provider),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionTabs(BuildContext context, HedProvider provider) {
    return Padding(
      padding: EdgeInsets.only(
        top: Constants.getVerticalGapBetweenTwoTextformfields(context) * 15,
        left: Constants.getVerticalGapBetweenTwoTextformfields(context),
        right: Constants.getVerticalGapBetweenTwoTextformfields(context),
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
          width: Constants.getVerticalGapBetweenTwoTextformfields(context) * 4,
          color: const Color(0xff6045FF),
        ),
        insets: EdgeInsets.symmetric(
          horizontal:
              Constants.getVerticalGapBetweenTwoTextformfields(context) * 20,
        ),
      ),
      labelStyle: TextStyle(
        fontSize: Constants.getTabSelectedFontSize(context),
        color: const Color(0xff3F3F3F).withOpacity(1),
        fontFamily: 'Metropolis',
        fontWeight: FontWeight.w800,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: Constants.getTabUnSelectedFontSize(context),
        color: const Color(0xff3F3F3F).withOpacity(0.55),
        fontFamily: 'Metropolis',
        fontWeight: FontWeight.w400,
      ),
      tabs: [
        _buildTab(context, 'Due Payment', 0.034),
        _buildTab(context, 'My Paymir', 0.07),
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
    HedProvider provider,
  ) {
    return RefreshIndicator(
      onRefresh: () => provider.refreshData(),
      child:
          provider.pendingDues.isEmpty
              ? const Center(child: Text('No pending transactions'))
              : ListView.builder(
                itemCount: provider.pendingDues.length,
                itemBuilder: (context, index) {
                  return HedPendingTransactionItem(
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
    HedProvider provider,
  ) {
    return RefreshIndicator(
      onRefresh: () => provider.refreshData(),
      child:
          provider.doneTransactions.isEmpty
              ? const Center(child: Text('No completed transactions'))
              : ListView.builder(
                itemCount: provider.doneTransactions.length,
                itemBuilder: (context, index) {
                  return HedDoneTransactionItem(
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
