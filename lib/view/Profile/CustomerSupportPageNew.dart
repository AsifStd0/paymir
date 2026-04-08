import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paymir_new_android/api/NetworkApiService.dart';
import 'package:provider/provider.dart';

import '../../util/Mediaquery_Constant.dart';
import '../../util/SecureStorage.dart';
import '../../util/app_strings.dart';
import '../../util/theme/app_colors.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text.dart';
import 'Profile_Screen.dart';
import 'profile_provider.dart';
import 'profile_widget.dart';

class CustomerSupportPageNew extends StatefulWidget {
  final String strCNIC;
  final Map<String, dynamic> cardDataJsonObject;

  const CustomerSupportPageNew({
    super.key,
    required this.strCNIC,
    required this.cardDataJsonObject,
  });

  @override
  State<CustomerSupportPageNew> createState() => _CustomerSupportPageNewState();
}

class _CustomerSupportPageNewState extends State<CustomerSupportPageNew> {
  final SecureStorage _secureStorage = SecureStorage();
  String _strToken = '';

  @override
  void initState() {
    super.initState();
    _fetchSecureStorageData();
  }

  Future<void> _fetchSecureStorageData() async {
    _strToken = await _secureStorage.getToken() ?? '';
  }

  Future<void> _handleSubmit(BuildContext context) async {
    final provider = Provider.of<ProfileProvider>(context, listen: false);

    if (provider.selectedCategory == null ||
        provider.selectedCategory!.isEmpty) {
      _showErrorDialog(context, 'Please select a category.');
      return;
    }

    if (provider.descriptionController.text.isEmpty) {
      _showErrorDialog(context, 'Please enter description.');
      return;
    }

    if (!await NetworkApiService.checkInternetConnection()) {
      _showErrorDialog(context, AppStrings.checkInternetConnection);
      return;
    }

    final success = await provider.registerComplaint(
      cnic: widget.strCNIC,
      token: _strToken,
      context: context,
    );

    if (success && mounted) {
      provider.clearComplaintFields();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder:
              (context) => ProfileScreen(
                strCNIC: widget.strCNIC,
                cardDataJsonObject: widget.cardDataJsonObject,
              ),
        ),
        (Route<dynamic> route) => false,
      );
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Row(
            children: [
              Icon(Icons.error_outline, color: AppColors.error),
              const SizedBox(width: 10.0),
              const Text(AppStrings.error),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text(AppStrings.ok),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(context),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        MediaQueryConstant.getSymmetricHorizontalPadding(
                          context,
                        ),
                  ),
                  child: Consumer<ProfileProvider>(
                    builder: (context, provider, _) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText.mainTitle(
                            text: 'Customer Support',
                            context: context,
                          ),
                          SizedBox(
                            height:
                                MediaQueryConstant.getVerticalGapBetweenMainAndSmallFont(
                                  context,
                                ),
                          ),
                          CustomText.subtitle(
                            text:
                                'It only takes a minute to register your suggestion/complaint',
                            context: context,
                          ),
                          SizedBox(
                            height:
                                MediaQueryConstant.getVerticalGapBetweenSmallfontAndTextfield(
                                  context,
                                ),
                          ),
                          ComplaintCategoryDropdown(
                            selectedCategory: provider.selectedCategory,
                            onChanged: provider.setSelectedCategory,
                          ),
                          SizedBox(
                            height:
                                MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                                  context,
                                ) *
                                20,
                          ),
                          ComplaintDescriptionField(
                            controller: provider.descriptionController,
                          ),
                          SizedBox(
                            height:
                                MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                                  context,
                                ) *
                                200,
                          ),
                          CustomButton(
                            onPressed: () => _handleSubmit(context),
                            text: 'Confirm',
                            isLoading: provider.isRegisteringComplaint,
                            isEnabled: !provider.isRegisteringComplaint,
                          ),
                          SizedBox(
                            height:
                                MediaQueryConstant.getVerticalGapBetweenMainAndSmallFont(
                                  context,
                                ) *
                                30,
                          ),
                          const HelplineInfoWidget(),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: MediaQueryConstant.getBackArrowLeftPadding(context),
            top: MediaQueryConstant.getBackArrowTopPadding(context),
            bottom: MediaQueryConstant.getBackArrowBottomPadding(context),
          ),
          child: IconButton(
            icon: SvgPicture.asset("assets/images/back_arrow.svg"),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }
}
