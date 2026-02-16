import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paymir_new_android/view/home_page/home_screen.dart';
import 'package:provider/provider.dart';

import '../../util/Mediaquery_Constant.dart';
import '../../util/app_strings.dart';
import '../../widget/custom_text.dart';
import 'CustomerSupportPageNew.dart';
import 'EditProfilePageNew.dart';
import 'UpdatePasswordPageNew.dart';
import 'profile_provider.dart';
import 'profile_widget.dart';

class ProfileScreen extends StatefulWidget {
  final String strCNIC;
  final Map<String, dynamic> cardDataJsonObject;

  const ProfileScreen({
    super.key,
    required this.strCNIC,
    required this.cardDataJsonObject,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Defer initialization until after the build phase is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeProvider();
    });
  }

  Future<void> _initializeProvider() async {
    final provider = Provider.of<ProfileProvider>(context, listen: false);
    provider.initializeProfileData(widget.cardDataJsonObject);
    await provider.loadProfileImage();
  }

  void _showImagePickerDialog(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ImagePickerDialog(
          onGalleryTap: () {
            provider.pickImage(ImageSource.gallery);
            Navigator.pop(context);
          },
          onCameraTap: () {
            provider.pickImage(ImageSource.camera);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                final provider = Provider.of<ProfileProvider>(
                  context,
                  listen: false,
                );
                provider.handleLogout(context);
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('No'),
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePageNew()),
        );
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Consumer<ProfileProvider>(
            builder: (context, provider, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  ProfileHeaderCard(
                    fullName: provider.fullName,
                    mobileNo: provider.mobileNo,
                    initials: provider.initials,
                    profileImage: provider.profileImage,
                    onImageTap: () => _showImagePickerDialog(context),
                    onEditProfileTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => EditProfilePageNew(
                                widget.strCNIC,
                                widget.cardDataJsonObject,
                              ),
                        ),
                      );
                    },
                  ),
                  Expanded(child: _buildMenuList(context, provider)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQueryConstant.getBackArrowTopPadding(context),
        bottom: MediaQueryConstant.getBackArrowBottomPadding(context),
      ),
      child: Center(
        child: CustomText.mainTitle(
          text: AppStrings.profile,
          context: context,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildMenuList(BuildContext context, ProfileProvider provider) {
    return ListView(
      children: [
        ProfileMenuItem(
          iconPath: 'assets/images/headphone.svg',
          title: 'Customer Support',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (_) => CustomerSupportPageNew(
                      strCNIC: widget.strCNIC,
                      cardDataJsonObject: widget.cardDataJsonObject,
                    ),
              ),
            );
          },
        ),
        ProfileMenuItem(
          iconPath: 'assets/images/passwordupdate.svg',
          title: AppStrings.updateProfile,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const UpdatePasswordPageNew()),
            );
          },
        ),
        ProfileMenuItem(
          iconPath: 'assets/images/logout.svg',
          title: AppStrings.signOut,
          titleColor: const Color(0xffE84F4F),
          onTap: () => _showLogoutDialog(context),
        ),
      ],
    );
  }
}
