import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:paymir_new_android/util/theme/app_colors.dart';

import '../../util/Mediaquery_Constant.dart';
import '../../util/MyValidation.dart';
import '../../widget/custom_button.dart';

/// HED header widget
class HedHeader extends StatelessWidget {
  final File? profileImage;

  const HedHeader({super.key, this.profileImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQueryConstant.getHomePageMainTextTopPadding(context),
        left: MediaQueryConstant.getHomePageMainTextLeftPadding(context),
        right: MediaQueryConstant.getHomePageMainTextRightPadding(context),
        bottom: MediaQueryConstant.getHomePageMainTextBottomPadding(context),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'HED',
            style: TextStyle(
              fontSize: MediaQueryConstant.getHomePageMainFontSize(context),
              color: const Color(0xff474747),
              fontFamily: 'Metropolis',
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Higher Education Department',
            style: TextStyle(
              fontSize: MediaQueryConstant.getScreenWidth(context) * 0.032,
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
        MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(context) * 40;
    final borderRadius =
        MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(context) * 10;

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
            top:
                MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                  context,
                ) *
                7,
            left:
                MediaQueryConstant.getHomePageMainTextLeftPadding(context) *
                2.3,
            right: MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
              context,
            ),
            bottom:
                MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                  context,
                ) *
                9,
          ),
          child: Text(
            'Enter your mobile number',
            style: TextStyle(
              color: const Color(0xff3F3F3F),
              fontFamily: 'Metropolis',
              fontWeight: FontWeight.w700,
              fontSize: MediaQueryConstant.getServiceFontSize(context),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: MediaQueryConstant.getTextFormFieldHeight(context),
              width: MediaQuery.of(context).size.width * 0.79,
              child: TextFormField(
                maxLength: 11,
                textAlign: TextAlign.start,
                style: const TextStyle(fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: "",
                  hintStyle: TextStyle(
                    fontSize: MediaQueryConstant.getTextformfieldHintFont(
                      context,
                    ),
                    color: AppColors.secondaryColor(),
                    fontFamily: 'Visby',
                    fontWeight: FontWeight.normal,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        MediaQueryConstant.getTextformfieldBorderRadius(
                          context,
                        ),
                      ),
                    ),
                  ),
                  counterText: '',
                  contentPadding: EdgeInsets.only(
                    top: MediaQueryConstant.getTextformfieldContentPadding(
                      context,
                    ),
                    left: MediaQueryConstant.getTextformfieldContentPadding(
                      context,
                    ),
                    bottom: MediaQueryConstant.getTextformfieldContentPadding(
                      context,
                    ),
                  ),
                ),
                controller: controller,
                keyboardType: TextInputType.number,
                validator: (value) => MyValidation.validateMobile(value),
              ),
            ),
          ],
        ),
        SizedBox(
          height:
              MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                context,
              ) *
              1,
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
        width: MediaQueryConstant.getButtonHeight(context) * 5,
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
            top:
                MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                  context,
                ) *
                10,
            left:
                MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                  context,
                ) *
                20,
            right:
                MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                  context,
                ) *
                20,
            bottom:
                MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                  context,
                ) *
                6,
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
                      MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
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
                                MediaQueryConstant.getGeneralFontSize(context) *
                                0.016,
                            color: const Color(0xff424242),
                            fontFamily: 'Metropolis',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: '\nPending',
                          style: TextStyle(
                            fontSize:
                                MediaQueryConstant.getGeneralFontSize(context) *
                                0.015,
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
                      MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
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
                                MediaQueryConstant.getGeneralFontSize(context) *
                                0.021,
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
                                MediaQueryConstant.getGeneralFontSize(context) *
                                0.015,
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
    final size =
        MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(context) * 40;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xff4B2A7A).withOpacity(1),
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: EdgeInsets.all(
          MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(context) *
              4,
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
            top:
                MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                  context,
                ) *
                10,
            left:
                MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                  context,
                ) *
                20,
            right:
                MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                  context,
                ) *
                20,
            bottom:
                MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                  context,
                ) *
                6,
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
                      MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
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
                                MediaQueryConstant.getGeneralFontSize(context) *
                                0.016,
                            color: const Color(0xff424242),
                            fontFamily: 'Metropolis',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: '\nPaid',
                          style: TextStyle(
                            fontSize:
                                MediaQueryConstant.getGeneralFontSize(context) *
                                0.015,
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
                      MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
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
                                MediaQueryConstant.getGeneralFontSize(context) *
                                0.021,
                            color: const Color(0xff45C232),
                            fontFamily: 'Metropolis',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: '\n${_formatDate(transaction['paymentDate'])}',
                          style: TextStyle(
                            fontSize:
                                MediaQueryConstant.getGeneralFontSize(context) *
                                0.015,
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
    final size =
        MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(context) * 40;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xff4B2A7A).withOpacity(1),
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: EdgeInsets.all(
          MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(context) *
              4,
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
