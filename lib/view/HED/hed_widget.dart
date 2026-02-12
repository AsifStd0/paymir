import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:paymir_new_android/core/theme/app_colors.dart';

import '../../util/Constants.dart';
import '../../util/MyValidation.dart';
import '../../widget/custom/custom_button.dart';

/// HED header widget
class HedHeader extends StatelessWidget {
  final File? profileImage;

  const HedHeader({super.key, this.profileImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Constants.getHomePageMainTextTopPadding(context),
        left: Constants.getHomePageMainTextLeftPadding(context),
        right: Constants.getHomePageMainTextRightPadding(context),
        bottom: Constants.getHomePageMainTextBottomPadding(context),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'HED',
            style: TextStyle(
              fontSize: Constants.getHomePageMainFontSize(context),
              color: const Color(0xff474747),
              fontFamily: 'Metropolis',
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Higher Education Department',
            style: TextStyle(
              fontSize: Constants.getScreenWidth(context) * 0.032,
              color: const Color(0xff474747),
              fontFamily: 'Metropolis',
              fontWeight: FontWeight.w600,
            ),
          ),
          _buildProfileImage(context),
        ],
      ),
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    final imageSize =
        Constants.getVerticalGapBetweenTwoTextformfields(context) * 40;
    final borderRadius =
        Constants.getVerticalGapBetweenTwoTextformfields(context) * 10;

    return GestureDetector(
      onTap: () {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child:
            profileImage != null
                ? Image.file(
                  profileImage!,
                  width: imageSize,
                  height: imageSize,
                  fit: BoxFit.cover,
                )
                : SvgPicture.asset(
                  'assets/images/hedlogo.svg',
                  width: imageSize,
                  height: imageSize,
                ),
      ),
    );
  }
}

/// Mobile number input section
class MobileNumberSection extends StatelessWidget {
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;

  const MobileNumberSection({
    super.key,
    required this.controller,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: Constants.getVerticalGapBetweenTwoTextformfields(context) * 7,
            left: Constants.getHomePageMainTextLeftPadding(context) * 2.3,
            right: Constants.getVerticalGapBetweenTwoTextformfields(context),
            bottom:
                Constants.getVerticalGapBetweenTwoTextformfields(context) * 9,
          ),
          child: Text(
            'Enter your mobile number',
            style: TextStyle(
              color: const Color(0xff3F3F3F),
              fontFamily: 'Metropolis',
              fontWeight: FontWeight.w700,
              fontSize: Constants.getServiceFontSize(context),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: Constants.getTextFormFieldHeight(context),
              width: MediaQuery.of(context).size.width * 0.79,
              child: TextFormField(
                maxLength: 11,
                textAlign: TextAlign.start,
                style: const TextStyle(fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: "",
                  hintStyle: TextStyle(
                    fontSize: Constants.getTextformfieldHintFont(context),
                    color: AppColors.secondaryColor(),
                    fontFamily: 'Visby',
                    fontWeight: FontWeight.normal,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        Constants.getTextformfieldBorderRadius(context),
                      ),
                    ),
                  ),
                  counterText: '',
                  contentPadding: EdgeInsets.only(
                    top: Constants.getTextformfieldContentPadding(context),
                    left: Constants.getTextformfieldContentPadding(context),
                    bottom: Constants.getTextformfieldContentPadding(context),
                  ),
                ),
                controller: controller,
                keyboardType: TextInputType.number,
                validator: (value) => MyValidationClass.validateMobile(value),
              ),
            ),
          ],
        ),
        SizedBox(
          height: Constants.getVerticalGapBetweenTwoTextformfields(context) * 1,
        ),
      ],
    );
  }
}

/// Load entries button
class LoadEntriesButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const LoadEntriesButton({super.key, this.onPressed, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomButton(
        onPressed: isLoading ? null : onPressed,
        text: 'Load Entries',
        isLoading: isLoading,
        isEnabled: !isLoading,
        width: Constants.getButtonHeight(context) * 5,
      ),
    );
  }
}

/// Transaction list item for pending dues
class HedPendingTransactionItem extends StatelessWidget {
  final Map<String, dynamic> transaction;
  final VoidCallback onTap;

  const HedPendingTransactionItem({
    super.key,
    required this.transaction,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: const Color(0xffFFFFFF),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
        child: Padding(
          padding: EdgeInsets.only(
            top: Constants.getVerticalGapBetweenTwoTextformfields(context) * 10,
            left:
                Constants.getVerticalGapBetweenTwoTextformfields(context) * 20,
            right:
                Constants.getVerticalGapBetweenTwoTextformfields(context) * 20,
            bottom:
                Constants.getVerticalGapBetweenTwoTextformfields(context) * 6,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xff0000000a),
                  blurRadius: 21,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                _buildIcon(context),
                SizedBox(
                  width:
                      Constants.getVerticalGapBetweenTwoTextformfields(
                        context,
                      ) *
                      25,
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: transaction['serviceName'] ?? '',
                          style: TextStyle(
                            fontSize:
                                Constants.getGeneralFontSize(context) * 0.016,
                            color: const Color(0xff424242),
                            fontFamily: 'Metropolis',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: '\nPending',
                          style: TextStyle(
                            fontSize:
                                Constants.getGeneralFontSize(context) * 0.015,
                            color: const Color(0xff424242).withOpacity(0.8),
                            fontFamily: 'Metropolis',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width:
                      Constants.getVerticalGapBetweenTwoTextformfields(
                        context,
                      ) *
                      8,
                ),
                Expanded(
                  child: RichText(
                    textAlign: TextAlign.right,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '+Rs ${transaction['feeAmount'] ?? 0}',
                          style: TextStyle(
                            fontSize:
                                Constants.getGeneralFontSize(context) * 0.021,
                            color: const Color(0xff45C232),
                            fontFamily: 'Metropolis',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text:
                              '\n${_formatDate(transaction['entryDateTime'])}',
                          style: TextStyle(
                            fontSize:
                                Constants.getGeneralFontSize(context) * 0.015,
                            color: const Color(0xff424242).withOpacity(0.8),
                            fontFamily: 'Metropolis',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    final size = Constants.getVerticalGapBetweenTwoTextformfields(context) * 40;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xff4B2A7A).withOpacity(1),
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: EdgeInsets.all(
          Constants.getVerticalGapBetweenTwoTextformfields(context) * 4,
        ),
        child: SvgPicture.asset('assets/images/govt_logo.svg'),
      ),
    );
  }

  String _formatDate(dynamic date) {
    if (date == null) return '';
    try {
      return DateFormat('dd/MM/yyyy').format(DateTime.parse(date.toString()));
    } catch (e) {
      return '';
    }
  }
}

/// Transaction list item for done transactions
class HedDoneTransactionItem extends StatelessWidget {
  final Map<String, dynamic> transaction;
  final VoidCallback onTap;

  const HedDoneTransactionItem({
    super.key,
    required this.transaction,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: const Color(0xffFFFFFF),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
        child: Padding(
          padding: EdgeInsets.only(
            top: Constants.getVerticalGapBetweenTwoTextformfields(context) * 10,
            left:
                Constants.getVerticalGapBetweenTwoTextformfields(context) * 20,
            right:
                Constants.getVerticalGapBetweenTwoTextformfields(context) * 20,
            bottom:
                Constants.getVerticalGapBetweenTwoTextformfields(context) * 6,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xff0000000a),
                  blurRadius: 21,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                _buildIcon(context),
                SizedBox(
                  width:
                      Constants.getVerticalGapBetweenTwoTextformfields(
                        context,
                      ) *
                      25,
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: transaction['serviceName'] ?? '',
                          style: TextStyle(
                            fontSize:
                                Constants.getGeneralFontSize(context) * 0.016,
                            color: const Color(0xff424242),
                            fontFamily: 'Metropolis',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: '\nPaid',
                          style: TextStyle(
                            fontSize:
                                Constants.getGeneralFontSize(context) * 0.015,
                            color: Colors.green,
                            fontFamily: 'Metropolis',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width:
                      Constants.getVerticalGapBetweenTwoTextformfields(
                        context,
                      ) *
                      8,
                ),
                Expanded(
                  child: RichText(
                    textAlign: TextAlign.right,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '+Rs ${transaction['feeAmount'] ?? 0}',
                          style: TextStyle(
                            fontSize:
                                Constants.getGeneralFontSize(context) * 0.021,
                            color: const Color(0xff45C232),
                            fontFamily: 'Metropolis',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: '\n${_formatDate(transaction['paymentDate'])}',
                          style: TextStyle(
                            fontSize:
                                Constants.getGeneralFontSize(context) * 0.015,
                            color: const Color(0xff424242).withOpacity(0.8),
                            fontFamily: 'Metropolis',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    final size = Constants.getVerticalGapBetweenTwoTextformfields(context) * 40;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xff4B2A7A).withOpacity(1),
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: EdgeInsets.all(
          Constants.getVerticalGapBetweenTwoTextformfields(context) * 4,
        ),
        child: SvgPicture.asset('assets/images/govt_logo.svg'),
      ),
    );
  }

  String _formatDate(dynamic date) {
    if (date == null) return '';
    try {
      return DateFormat('dd/MM/yyyy').format(DateTime.parse(date.toString()));
    } catch (e) {
      return '';
    }
  }
}
