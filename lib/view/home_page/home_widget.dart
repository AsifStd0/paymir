import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:paymir_new_android/core/theme/app_colors.dart';

import '../../util/Constants.dart';
import '../CFC/CFCPageNew.dart';
import '../DastakPageNew.dart';
import '../HED/HEDPageNew.dart';
import '../MoreServicesPageNew.dart';
import '../Voucher/VoucherNoPageNew.dart';

/// Header widget with title and profile image
class HomeHeader extends StatelessWidget {
  final File? profileImage;
  final VoidCallback onProfileTap;

  const HomeHeader({super.key, this.profileImage, required this.onProfileTap});

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
            'Paymir',
            style: TextStyle(
              fontSize: Constants.getHomePageMainFontSize(context),
              color: const Color(0xff474747),
              fontFamily: 'Metropolis',
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Digital Payment Platform (D2P)',
            style: TextStyle(
              fontSize: Constants.getScreenWidth(context) * 0.032,
              color: const Color(0xff474747),
              fontFamily: 'Metropolis',
              fontWeight: FontWeight.w600,
            ),
          ),
          GestureDetector(
            onTap: onProfileTap,
            child: _buildProfileImage(context),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    final imageSize =
        Constants.getVerticalGapBetweenTwoTextformfields(context) * 40;
    final borderRadius =
        Constants.getVerticalGapBetweenTwoTextformfields(context) * 10;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child:
          profileImage != null
              ? Image.file(
                profileImage!,
                width: imageSize,
                height: imageSize,
                fit: BoxFit.cover,
              )
              : Image.asset(
                'assets/images/homepageicon.png',
                width: imageSize,
                height: imageSize,
              ),
    );
  }
}

/// Payment card widget
class PaymentCard extends StatelessWidget {
  final String cardHolderName;
  final String cardNumber;
  final String expiryDate;

  const PaymentCard({
    super.key,
    required this.cardHolderName,
    required this.cardNumber,
    required this.expiryDate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: Constants.getCardLeftPadding(context),
              right: Constants.getCardRightPadding(context),
              bottom: Constants.getCardBottomPadding(context),
            ),
            child: Container(
              height: Constants.getCardHeight(context),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(
                      Constants.getVerticalGapBetweenTwoTextformfields(context),
                    ),
                    spreadRadius:
                        Constants.getVerticalGapBetweenTwoTextformfields(
                          context,
                        ) *
                        2,
                    blurRadius:
                        Constants.getVerticalGapBetweenTwoTextformfields(
                          context,
                        ) *
                        20,
                    offset: const Offset(0, 2),
                  ),
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(Constants.getCardBorderRadius(context)),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    AppColors.gradientColor1(),
                    AppColors.gradientColor2(),
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(
                  Constants.getCardInsidePadding(context),
                ),
                child: Column(
                  children: [
                    _buildBalanceRow(context),
                    SizedBox(
                      height:
                          Constants.getVerticalGapBetweenTwoTextformfields(
                            context,
                          ) *
                          15,
                    ),
                    _buildCardNumber(context),
                    SizedBox(
                      height:
                          Constants.getVerticalGapBetweenTwoTextformfields(
                            context,
                          ) *
                          25.5,
                    ),
                    _buildCardFooter(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBalanceRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Balance\n',
                style: TextStyle(
                  fontSize: Constants.getCardSmallFontSize(context),
                  color: const Color(0xffD3DDE5),
                  fontFamily: 'Metropolis',
                  fontWeight: FontWeight.normal,
                ),
              ),
              TextSpan(
                text: '-------- ',
                style: TextStyle(
                  fontSize: Constants.getCardMediumFontSize(context),
                  color: Colors.white,
                  fontFamily: 'Metropolis',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height:
              Constants.getVerticalGapBetweenTwoTextformfields(context) * 81,
          width: Constants.getVerticalGapBetweenTwoTextformfields(context) * 81,
          child: SvgPicture.asset("assets/images/cardpamirlogo.svg"),
        ),
      ],
    );
  }

  Widget _buildCardNumber(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              cardNumber,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'OCRAEXTENDED',
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCardFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CARD HOLDER',
                style: TextStyle(
                  fontSize: Constants.getGeneralFontSize(context) * 0.0130,
                  color: const Color(0xffD3DDE5),
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                height:
                    Constants.getVerticalGapBetweenTwoTextformfields(context) *
                    6,
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  cardHolderName,
                  style: TextStyle(
                    color: const Color(0xffFFFFFF),
                    fontFamily: 'OCRAEXTENDED',
                    fontWeight: FontWeight.normal,
                    fontSize: Constants.getScreenWidth(context) * 0.04,
                    shadows: const [
                      Shadow(
                        offset: Offset(0.0, 1.0),
                        blurRadius: 1.0,
                        color: Color(0xff00000080),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                'EXPIRES',
                style: TextStyle(
                  fontSize: Constants.getGeneralFontSize(context) * 0.0128,
                  color: const Color(0xffD3DDE5),
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                height:
                    Constants.getVerticalGapBetweenTwoTextformfields(context) *
                    6,
              ),
              Text(
                expiryDate,
                style: TextStyle(
                  fontSize: Constants.getGeneralFontSize(context) * 0.0161,
                  color: const Color(0xffFFFFFF),
                  fontFamily: 'OCRAEXTENDED',
                  fontWeight: FontWeight.normal,
                  shadows: const [
                    Shadow(
                      offset: Offset(0.0, 1.0),
                      blurRadius: 1.0,
                      color: Color(0xff00000080),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height:
              Constants.getVerticalGapBetweenTwoTextformfields(context) * 55,
          width: Constants.getVerticalGapBetweenTwoTextformfields(context) * 55,
          child: SvgPicture.asset("assets/images/cardgovtlogo.svg"),
        ),
      ],
    );
  }
}

/// Services section title
class ServicesTitle extends StatelessWidget {
  const ServicesTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Constants.getVerticalGapBetweenTwoTextformfields(context) * 7,
        left: Constants.getHomePageMainTextLeftPadding(context) * 2.3,
        right: Constants.getVerticalGapBetweenTwoTextformfields(context),
        bottom: Constants.getVerticalGapBetweenTwoTextformfields(context) * 9,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Services',
            style: TextStyle(
              color: const Color(0xff3F3F3F),
              fontFamily: 'Metropolis',
              fontWeight: FontWeight.w700,
              fontSize: Constants.getServiceFontSize(context),
            ),
          ),
        ],
      ),
    );
  }
}

/// Service item widget
class ServiceItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final VoidCallback onTap;

  const ServiceItem({
    super.key,
    required this.iconPath,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context).width * 0.2;
    final height = MediaQuery.sizeOf(context).width * 0.22;

    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: size,
            height: height,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: const Color(0xffF4F6F9),
              borderRadius: BorderRadius.circular(
                MediaQuery.sizeOf(context).width * 0.03,
              ),
              border: Border.all(color: const Color(0xffEBEBEB)),
            ),
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.015),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(
                      Constants.getVerticalGapBetweenTwoTextformfields(
                            context,
                          ) *
                          10,
                    ),
                    child: SvgPicture.asset(
                      iconPath,
                      height: Constants.getSmallFontSize(context) * 2,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top:
                          Constants.getVerticalGapBetweenTwoTextformfields(
                            context,
                          ) *
                          2,
                    ),
                    child: Text(
                      title,
                      style: TextStyle(
                        color: const Color(0xff3F3F3F),
                        fontFamily: 'Metropolis',
                        fontSize: Constants.getSmallFontSize(context),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Services grid widget
class ServicesGrid extends StatelessWidget {
  const ServicesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ServiceItem(
          iconPath: 'assets/images/dastaklogo.svg',
          title: 'Dastak',
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DastakPageNew()),
              ),
        ),
        ServiceItem(
          iconPath: 'assets/images/sidblogo.svg',
          title: 'SIDB',
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => VoucherNoPageNew()),
              ),
        ),
        ServiceItem(
          iconPath: 'assets/images/cfclogo.svg',
          title: 'CFC',
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CFCPageNew()),
              ),
        ),
        ServiceItem(
          iconPath: 'assets/images/hedlogo.svg',
          title: 'HED',
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => HEDPageNew()),
              ),
        ),
      ],
    );
  }
}

/// Second row services grid
class ServicesGridRow2 extends StatelessWidget {
  const ServicesGridRow2({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ServiceItem(
          iconPath: 'assets/images/sportslogo.svg',
          title: 'Sports',
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => VoucherNoPageNew()),
              ),
        ),
        ServiceItem(
          iconPath: 'assets/images/pgmilogo.svg',
          title: 'PGMI',
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => VoucherNoPageNew()),
              ),
        ),
        ServiceItem(
          iconPath: 'assets/images/assamilogo.svg',
          title: 'Assami',
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => VoucherNoPageNew()),
              ),
        ),
        ServiceItem(
          iconPath: 'assets/images/threedotslogo.svg',
          title: 'More',
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MoreServicesPageNew()),
              ),
        ),
      ],
    );
  }
}

/// Transaction list item for pending dues
class PendingTransactionItem extends StatelessWidget {
  final Map<String, dynamic> transaction;
  final VoidCallback onTap;

  const PendingTransactionItem({
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
class DoneTransactionItem extends StatelessWidget {
  final Map<String, dynamic> transaction;
  final VoidCallback onTap;

  const DoneTransactionItem({
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
