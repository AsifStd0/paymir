import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../util/AlertDialogueClass.dart';
import '../../util/Mediaquery_Constant.dart';
import '../../util/theme/app_colors.dart';
import 'main_provider.dart';
import 'main_tabs/home_tab.dart';
import 'main_tabs/profile_tab.dart';
import 'main_tabs/qpay_tab.dart';
import 'main_tabs/voucher_tab.dart';

/// Main screen with bottom navigation bar
/// Manages navigation between Home, Voucher, QPay, and Settings tabs
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index, BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    mainProvider.changeTab(index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return (await ShowAlertDialogueClass.exitAppDialog(context));
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Consumer<MainProvider>(
          builder: (context, mainProvider, _) {
            return PageView(
              controller: _pageController,
              onPageChanged: (index) {
                mainProvider.changeTab(index);
              },
              children: const [
                HomeTab(),
                VoucherTab(),
                QPayTab(),
                ProfileTab(),
              ],
            );
          },
        ),
        bottomNavigationBar: Consumer<MainProvider>(
          builder: (context, mainProvider, _) {
            return _buildBottomNavigationBar(context, mainProvider);
          },
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(
    BuildContext context,
    MainProvider mainProvider,
  ) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.background,
      selectedItemColor: AppColors.textMedium,
      unselectedItemColor: AppColors.secondary,
      currentIndex: mainProvider.currentIndex,
      onTap: (index) => _onTabTapped(index, context),
      selectedLabelStyle: TextStyle(
        color: AppColors.textMedium,
        fontFamily: 'Metropolis',
        fontSize: MediaQueryConstant.getGeneralFontSize(context) * 0.016,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: TextStyle(
        color: AppColors.textMedium.withOpacity(0.80),
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
                color:
                    mainProvider.currentIndex == 0
                        ? AppColors.textMedium
                        : AppColors.secondary,
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
                color:
                    mainProvider.currentIndex == 1
                        ? AppColors.textMedium
                        : AppColors.secondary,
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
                color:
                    mainProvider.currentIndex == 2
                        ? AppColors.textMedium
                        : AppColors.secondary,
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
                color:
                    mainProvider.currentIndex == 3
                        ? AppColors.textMedium
                        : AppColors.secondary,
              ),
            ),
          ),
          label: 'Setting',
        ),
      ],
    );
  }
}
