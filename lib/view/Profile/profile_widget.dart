import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../util/Mediaquery_Constant.dart';
import '../../util/app_strings.dart';
import '../../util/theme/app_colors.dart';

/// Profile header card widget
class ProfileHeaderCard extends StatelessWidget {
  final String fullName;
  final String mobileNo;
  final String initials;
  final File? profileImage;
  final VoidCallback onImageTap;
  final VoidCallback onEditProfileTap;

  const ProfileHeaderCard({
    super.key,
    required this.fullName,
    required this.mobileNo,
    required this.initials,
    this.profileImage,
    required this.onImageTap,
    required this.onEditProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.width * 0.08,
        left: MediaQuery.of(context).size.width * 0.04,
        right: MediaQuery.of(context).size.width * 0.04,
        bottom: MediaQuery.of(context).size.width * 0.05,
      ),
      child: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(
                MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                  context,
                ),
              ),
              spreadRadius:
                  MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                    context,
                  ) *
                  2,
              blurRadius:
                  MediaQueryConstant.getVerticalGapBetweenTwoTextformfields(
                    context,
                  ) *
                  20,
              offset: const Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(MediaQueryConstant.getCardBorderRadius(context)),
          ),
          gradient: AppColors.primaryGradient,
        ),
        height: MediaQuery.of(context).size.width * 0.45,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.04,
                top: MediaQuery.of(context).size.width * 0.02,
                bottom: MediaQuery.of(context).size.width * 0.01,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildProfileAvatar(context),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.07),
                  Expanded(child: _buildUserInfo(context)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.12,
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
                width: MediaQuery.of(context).size.width * 0.3,
                child: ElevatedButton(
                  onPressed: onEditProfileTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  child: Text(
                    AppStrings.editProfile,
                    style: TextStyle(
                      color: AppColors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w100,
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileAvatar(BuildContext context) {
    final radius = MediaQuery.of(context).size.width * 0.109;
    return InkWell(
      onTap: onImageTap,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: AppColors.white,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                radius: radius,
                backgroundImage:
                    profileImage != null ? FileImage(profileImage!) : null,
                backgroundColor: profileImage != null ? null : AppColors.white,
                child:
                    profileImage == null
                        ? Text(
                          initials,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.095,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w900,
                          ),
                        )
                        : null,
              ),
            ),
            _buildCameraIcon(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraIcon(BuildContext context) {
    return GestureDetector(
      onTap: onImageTap,
      child: Align(
        alignment: Alignment(0.0, MediaQuery.of(context).size.width * 0.0042),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xff1E7A98), width: 2),
          ),
          child: CircleAvatar(
            radius: MediaQuery.of(context).size.width * 0.034,
            backgroundColor: AppColors.white,
            child: SvgPicture.asset(
              'assets/images/camera.svg',
              height: MediaQuery.of(context).size.width * 0.038,
              width: MediaQuery.of(context).size.width * 0.038,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            fullName,
            style: TextStyle(
              color: AppColors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: MediaQuery.of(context).size.width * 0.045,
            ),
          ),
        ),
        Text(
          formatMobileNumber(mobileNo),
          style: TextStyle(
            color: AppColors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w100,
            fontSize: MediaQuery.of(context).size.width * 0.031,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.015),
        Row(
          children: [
            Icon(
              Icons.verified,
              color: AppColors.white,
              size: MediaQuery.of(context).size.width * 0.045,
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            Text(
              'Verified',
              style: TextStyle(
                color: AppColors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: MediaQuery.of(context).size.width * 0.038,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String formatMobileNumber(String mobileNo) {
    if (mobileNo.isEmpty) return '';
    final digitsOnly = mobileNo.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly.isEmpty) return mobileNo;
    if (digitsOnly.length < 6) {
      return digitsOnly.length >= 2 ? '+$digitsOnly' : digitsOnly;
    }
    if (digitsOnly.length >= 12) {
      return '+${digitsOnly.substring(0, 2)} ${digitsOnly.substring(2, 6)} ${digitsOnly.substring(6)}';
    } else if (digitsOnly.length >= 6) {
      return '+${digitsOnly.substring(0, 2)} ${digitsOnly.substring(2, 6)} ${digitsOnly.substring(6)}';
    }
    return '+$digitsOnly';
  }
}

/// Image picker dialog widget
class ImagePickerDialog extends StatelessWidget {
  final VoidCallback onGalleryTap;
  final VoidCallback onCameraTap;

  const ImagePickerDialog({
    super.key,
    required this.onGalleryTap,
    required this.onCameraTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: 200,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  const Text(
                    'Choose an option',
                    style: TextStyle(fontSize: 18),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.check_circle_outline_rounded,
                    color: AppColors.success,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SimpleDialogOption(
              onPressed: onGalleryTap,
              child: Row(
                children: [
                  Icon(Icons.photo_library, color: AppColors.info),
                  const SizedBox(width: 10),
                  const Text('Gallery'),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: onCameraTap,
              child: Row(
                children: [
                  Icon(Icons.camera_alt, color: AppColors.info),
                  const SizedBox(width: 10),
                  const Text('Camera'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Profile menu item widget
class ProfileMenuItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final Color? titleColor;
  final VoidCallback onTap;

  const ProfileMenuItem({
    super.key,
    required this.iconPath,
    required this.title,
    this.titleColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
      ),
      child: Card(
        child: ListTile(
          leading: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
            child: SvgPicture.asset(
              iconPath,
              width: MediaQuery.of(context).size.width * 0.05,
              height: MediaQuery.of(context).size.width * 0.05,
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.035,
              color: titleColor ?? const Color(0xff898A8F),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.normal,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: MediaQuery.of(context).size.width * 0.04,
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}

/// Password field widget
class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final VoidCallback onToggleVisibility;
  final String? Function(String?)? validator;

  const PasswordField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.onToggleVisibility,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQueryConstant.getTextFormFieldHeight(context),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              obscureText ? Icons.visibility_off : Icons.visibility,
              color: AppColors.secondary,
            ),
            onPressed: onToggleVisibility,
          ),
          hintStyle: TextStyle(
            fontSize: MediaQueryConstant.getTextformfieldHintFont(context),
            color: AppColors.secondary,
            fontFamily: 'Visby',
            fontWeight: FontWeight.normal,
          ),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                MediaQueryConstant.getTextformfieldBorderRadius(context),
              ),
            ),
          ),
          counterText: '',
          contentPadding: EdgeInsets.only(
            top: MediaQueryConstant.getTextformfieldContentPadding(context),
            left: MediaQueryConstant.getTextformfieldContentPadding(context),
            bottom: MediaQueryConstant.getTextformfieldContentPadding(context),
          ),
        ),
      ),
    );
  }
}

/// Complaint category dropdown widget
class ComplaintCategoryDropdown extends StatelessWidget {
  final String? selectedCategory;
  final ValueChanged<String?> onChanged;

  const ComplaintCategoryDropdown({
    super.key,
    this.selectedCategory,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedCategory,
      onChanged: onChanged,
      items: const [
        DropdownMenuItem(value: 'suggestions', child: Text('Suggestions')),
        DropdownMenuItem(value: 'complaints', child: Text('Complaints')),
        DropdownMenuItem(value: 'issues', child: Text('Issues')),
        DropdownMenuItem(
          value: 'servicerelated',
          child: Text('Service Related'),
        ),
      ],
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
        ),
        hintStyle: TextStyle(
          fontSize: MediaQueryConstant.getTextformfieldHintFont(context),
          color: AppColors.primary,
          fontFamily: 'Visby',
          fontWeight: FontWeight.bold,
        ),
        hintText: 'Select Category',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              MediaQueryConstant.getTextformfieldBorderRadius(context),
            ),
          ),
          borderSide: const BorderSide(color: AppColors.tertiary),
        ),
        counterText: '',
      ),
    );
  }
}

/// Complaint description field widget
class ComplaintDescriptionField extends StatelessWidget {
  final TextEditingController controller;

  const ComplaintDescriptionField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderMedium),
        borderRadius: BorderRadius.all(
          Radius.circular(
            MediaQueryConstant.getTextformfieldBorderRadius(context),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width * 0.03,
              left: MediaQuery.of(context).size.width * 0.03,
            ),
            child: Text(
              'Description',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: MediaQueryConstant.getTextformfieldHintFont(context),
                color: AppColors.primary,
                fontFamily: 'Visby',
              ),
            ),
          ),
          TextFormField(
            controller: controller,
            maxLength: 200,
            maxLines: null,
            decoration: InputDecoration(
              border: InputBorder.none,
              counterText: '',
              contentPadding: EdgeInsets.only(
                left: MediaQueryConstant.getTextformfieldContentPadding(
                  context,
                ),
                bottom: MediaQueryConstant.getTextformfieldContentPadding(
                  context,
                ),
              ),
              hintText: 'Add your details here',
              hintStyle: TextStyle(
                fontSize: MediaQueryConstant.getTextformfieldHintFont(context),
                color: AppColors.secondary,
                fontFamily: 'Visby',
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Helpline info widget
class HelplineInfoWidget extends StatelessWidget {
  const HelplineInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.16,
      color: const Color(0xff6E78F70A).withOpacity(0.15),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/images/bigmic.svg'),
          SizedBox(width: MediaQuery.of(context).size.width * 0.04),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width * 0.038,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Helpline Number',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    color: AppColors.gradient1,
                  ),
                ),
                Text(
                  '091 589 1516',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                    color: AppColors.purpleAccent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Edit profile name field widget
class EditProfileNameField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final bool isFirstName;

  const EditProfileNameField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.isFirstName = true,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: MediaQueryConstant.getTextFormFieldHeight(context),
        child: TextFormField(
          controller: controller,
          textAlignVertical: isFirstName ? TextAlignVertical.center : null,
          textAlign: TextAlign.start,
          maxLength: 15,
          validator: validator,
          decoration: InputDecoration(
            hintStyle: TextStyle(
              fontSize: MediaQueryConstant.getTextformfieldHintFont(context),
              color: AppColors.secondary,
              fontFamily: 'Visby',
              fontWeight: FontWeight.normal,
            ),
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  MediaQueryConstant.getTextformfieldBorderRadius(context),
                ),
              ),
            ),
            counterText: '',
            contentPadding: EdgeInsets.only(
              top: MediaQueryConstant.getTextformfieldContentPadding(context),
              left: MediaQueryConstant.getTextformfieldContentPadding(context),
              bottom: MediaQueryConstant.getTextformfieldContentPadding(
                context,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Edit profile text field widget
class EditProfileTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? maxLength;

  const EditProfileTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.keyboardType,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQueryConstant.getTextFormFieldHeight(context),
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.start,
        validator: validator,
        keyboardType: keyboardType,
        maxLength: maxLength,
        decoration: InputDecoration(
          hintStyle: TextStyle(
            fontSize: MediaQueryConstant.getTextformfieldHintFont(context),
            color: AppColors.secondary,
            fontFamily: 'Visby',
            fontWeight: FontWeight.normal,
          ),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                MediaQueryConstant.getTextformfieldBorderRadius(context),
              ),
            ),
          ),
          counterText: '',
          contentPadding: EdgeInsets.only(
            top: MediaQueryConstant.getTextformfieldContentPadding(context),
            left: MediaQueryConstant.getTextformfieldContentPadding(context),
            bottom: MediaQueryConstant.getTextformfieldContentPadding(context),
          ),
        ),
      ),
    );
  }
}
