import 'dart:convert';
import 'dart:io';

import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../api/api_client.dart';
import '../../core/locator.dart';
import '../../core/services/profile_service.dart';
import '../../util/AlertDialogueClass.dart';
import '../../util/Shared_pref.dart';
import '../../util/app_strings.dart';
import '../../view/login/login_screen.dart';

/// Provider for managing profile screen state
class ProfileProvider extends ChangeNotifier {
  final ProfileService _profileService = locator<ProfileService>();
  final ImagePicker _imagePicker = ImagePicker();

  // Loading states
  bool _isLoading = false;
  bool _isUploadingImage = false;
  bool _isUpdatingPassword = false;
  bool _isRegisteringComplaint = false;

  // Profile data
  String _fullName = '';
  String _mobileNo = '';
  String _initials = '';
  File? _profileImage;
  Map<String, dynamic> _profileData = {};

  // Password update
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _oldPasswordVisible = false;
  bool _newPasswordVisible = false;
  bool _confirmPasswordVisible = false;

  // Customer support
  final TextEditingController descriptionController = TextEditingController();
  String? _selectedCategory;

  // Edit profile
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  late final MaskedTextController mobileNumberController;
  final TextEditingController emailController = TextEditingController();
  bool _isEditingProfile = false;
  bool _isSendingOTP = false;
  Map<String, dynamic> _originalProfileData = {};

  ProfileProvider() {
    mobileNumberController = MaskedTextController(mask: '0000000000');
  }

  // Getters
  bool get isLoading => _isLoading;
  bool get isUploadingImage => _isUploadingImage;
  bool get isUpdatingPassword => _isUpdatingPassword;
  bool get isRegisteringComplaint => _isRegisteringComplaint;
  bool get isEditingProfile => _isEditingProfile;
  bool get isSendingOTP => _isSendingOTP;

  String get fullName => _fullName;
  String get mobileNo => _mobileNo;
  String get initials => _initials;
  File? get profileImage => _profileImage;
  Map<String, dynamic> get profileData => _profileData;

  bool get oldPasswordVisible => _oldPasswordVisible;
  bool get newPasswordVisible => _newPasswordVisible;
  bool get confirmPasswordVisible => _confirmPasswordVisible;

  String? get selectedCategory => _selectedCategory;

  /// Initialize profile data
  void initializeProfileData(Map<String, dynamic> cardData) {
    _fullName = cardData['fullName']?.toString() ?? '';
    _mobileNo = cardData['mobileNo']?.toString() ?? '';
    _initials = _getInitials(_fullName);
    _profileData = cardData;
    // Defer notifyListeners to avoid calling during build
    Future.microtask(() => notifyListeners());
  }

  /// Load profile image from local storage
  Future<void> loadProfileImage() async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      const fileName = 'avatar.png';
      final file = File('${appDir.path}/$fileName');
      if (await file.exists()) {
        _profileImage = file;
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading profile image: $e');
      }
    }
  }

  /// Pick image from gallery or camera
  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await _imagePicker.pickImage(source: source);
      if (pickedFile == null) return;

      final appDir = await getApplicationDocumentsDirectory();
      const fileName = 'avatar.png';
      final file = File('${appDir.path}/$fileName');
      await file.writeAsBytes(await pickedFile.readAsBytes());

      _profileImage = File(pickedFile.path);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error picking image: $e');
      }
    }
  }

  /// Upload profile image to server
  Future<bool> uploadProfileImage({
    required String cnic,
    required String token,
  }) async {
    if (_profileImage == null) return false;

    try {
      _isUploadingImage = true;
      notifyListeners();

      final imageBytes = await _profileImage!.readAsBytes();
      final base64Image = base64Encode(imageBytes);

      final response = await _profileService.uploadProfileImage(
        cnic: cnic,
        base64Image: base64Image,
        // token: token,
      );

      return response.isSuccess;
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading profile image: $e');
      }
      return false;
    } finally {
      _isUploadingImage = false;
      notifyListeners();
    }
  }

  /// Toggle password visibility
  void toggleOldPasswordVisibility() {
    _oldPasswordVisible = !_oldPasswordVisible;
    notifyListeners();
  }

  void toggleNewPasswordVisibility() {
    _newPasswordVisible = !_newPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _confirmPasswordVisible = !_confirmPasswordVisible;
    notifyListeners();
  }

  /// Update password
  Future<bool> updatePassword({
    required String cnic,
    required String token,
    required BuildContext context,
  }) async {
    try {
      _isUpdatingPassword = true;
      notifyListeners();

      // Get old password from server
      final oldPasswordResponse = await _profileService.getOldPassword(
        cnic: cnic,
        // token: token,
      );

      if (oldPasswordResponse.oldPassword != oldPasswordController.text) {
        ShowAlertDialogueClass.showAlertDialogue(
          context: context,
          title: AppStrings.error,
          message: 'Incorrect old password.',
          buttonText: AppStrings.ok,
          iconData: Icons.error,
        );
        return false;
      }

      // Update password
      final response = await _profileService.updatePassword(
        cnic: cnic,
        newPassword: newPasswordController.text,
      );

      if (response.isSuccess) {
        return true;
      } else {
        ShowAlertDialogueClass.showAlertDialogue(
          context: context,
          title: AppStrings.error,
          message: response.responseMessage,
          buttonText: AppStrings.ok,
          iconData: Icons.error,
        );
        return false;
      }
    } catch (e) {
      ShowAlertDialogueClass.showAlertDialogue(
        context: context,
        title: AppStrings.error,
        message: e.toString(),
        buttonText: AppStrings.ok,
        iconData: Icons.error,
      );
      return false;
    } finally {
      _isUpdatingPassword = false;
      notifyListeners();
    }
  }

  /// Set selected category for complaint
  void setSelectedCategory(String? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  /// Register complaint
  Future<bool> registerComplaint({
    required String cnic,
    required String token,
    required BuildContext context,
  }) async {
    if (_selectedCategory == null || _selectedCategory!.isEmpty) {
      ShowAlertDialogueClass.showAlertDialogue(
        context: context,
        title: AppStrings.error,
        message: 'Please select a category.',
        buttonText: AppStrings.ok,
        iconData: Icons.error,
      );
      return false;
    }

    if (descriptionController.text.isEmpty) {
      ShowAlertDialogueClass.showAlertDialogue(
        context: context,
        title: AppStrings.error,
        message: 'Please enter description.',
        buttonText: AppStrings.ok,
        iconData: Icons.error,
      );
      return false;
    }

    try {
      _isRegisteringComplaint = true;
      notifyListeners();

      // Set token in ApiClient before making request
      locator<ApiClient>().setAuthToken(token);

      final response = await _profileService.registerComplaint(
        cnic: cnic,
        category: _selectedCategory!,
        description: descriptionController.text,
      );

      if (response.isSuccess) {
        ShowAlertDialogueClass.showAlertDialogue(
          context: context,
          title: AppStrings.success,
          message: response.responseMessage,
          buttonText: AppStrings.ok,
          iconData: Icons.check_circle,
        );
        return true;
      } else {
        ShowAlertDialogueClass.showAlertDialogue(
          context: context,
          title: AppStrings.error,
          message: response.responseMessage,
          buttonText: AppStrings.ok,
          iconData: Icons.error,
        );
        return false;
      }
    } catch (e) {
      ShowAlertDialogueClass.showAlertDialogue(
        context: context,
        title: AppStrings.error,
        message: 'Server is down and cannot be accessed!',
        buttonText: AppStrings.close,
        iconData: Icons.error,
      );
      return false;
    } finally {
      _isRegisteringComplaint = false;
      notifyListeners();
    }
  }

  /// Format mobile number
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

  /// Get initials from name
  String _getInitials(String name) {
    if (name.isEmpty || name.trim().isEmpty) return '';

    final words = name.split(' ').where((word) => word.isNotEmpty).toList();
    if (words.isEmpty) return '';

    final firstLetter = words[0].isNotEmpty ? words[0][0].toUpperCase() : '';

    String firstName = '';
    for (final word in words) {
      if (!word.startsWith('Dr.') &&
          !word.startsWith('Engr.') &&
          !word.startsWith('Mr.') &&
          !word.startsWith('Mrs.') &&
          !word.startsWith('Miss.')) {
        firstName = word;
        break;
      }
    }

    final initials = <String>[];
    for (final word in words) {
      if (word.isEmpty) continue;
      if (!word.startsWith('Dr.') &&
          !word.startsWith('Engr.') &&
          !word.startsWith('Mr.') &&
          !word.startsWith('Mrs.') &&
          !word.startsWith('Miss.') &&
          word != firstName) {
        if (word.length >= 2) {
          initials.add(word[0].toUpperCase());
        } else if (word.length == 1) {
          initials.add(word.toUpperCase());
        }
      }
    }

    if (firstLetter.isEmpty && initials.isEmpty) return '';
    return firstLetter + initials.join('');
  }

  /// Handle logout
  Future<void> handleLogout(BuildContext context) async {
    await SharedPrefService.deleteToken();
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (Route<dynamic> route) => false,
      );
    }
  }

  /// Clear password fields
  void clearPasswordFields() {
    oldPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }

  /// Clear complaint fields
  void clearComplaintFields() {
    descriptionController.clear();
    _selectedCategory = null;
    notifyListeners();
  }

  /// Initialize edit profile data
  void initializeEditProfileData(Map<String, dynamic> cardData) {
    _originalProfileData = Map<String, dynamic>.from(cardData);

    final fullName = cardData['fullName']?.toString() ?? '';
    final names = fullName.split(' ').where((n) => n.isNotEmpty).toList();

    String firstName = names.isNotEmpty ? names[0] : '';
    String lastName = names.length > 1 ? names[names.length - 1] : '';

    if (names.length > 2) {
      firstName = names.sublist(0, names.length - 1).join(' ');
    }

    firstNameController.text = firstName;
    lastNameController.text = lastName;
    mobileNumberController.text = (cardData['mobileNo']?.toString() ?? '')
        .replaceAll('+92', '');
    emailController.text = cardData['emailAddress']?.toString() ?? '';

    Future.microtask(() => notifyListeners());
  }

  /// Check if profile data has changed
  bool hasProfileChanged() {
    final originalFullName = _originalProfileData['fullName']?.toString() ?? '';
    final originalMobile = (_originalProfileData['mobileNo']?.toString() ?? '')
        .replaceAll('+92', '');
    final originalEmail =
        _originalProfileData['emailAddress']?.toString() ?? '';

    final newFullName =
        '${firstNameController.text} ${lastNameController.text}';
    final newMobile = mobileNumberController.text;
    final newEmail = emailController.text;

    return newFullName.trim() != originalFullName.trim() ||
        newMobile != originalMobile ||
        newEmail != originalEmail;
  }

  /// Check if only name changed (mobile and email unchanged)
  bool onlyNameChanged() {
    final originalMobile = (_originalProfileData['mobileNo']?.toString() ?? '')
        .replaceAll('+92', '');
    final originalEmail =
        _originalProfileData['emailAddress']?.toString() ?? '';

    return mobileNumberController.text == originalMobile &&
        emailController.text == originalEmail;
  }

  /// Update profile (when only name changed)
  Future<bool> updateProfile({
    required String cnic,
    required String token,
    required BuildContext context,
  }) async {
    try {
      _isEditingProfile = true;
      notifyListeners();

      final response = await _profileService.editProfile(
        cnic: cnic,
        fullName: '${firstNameController.text} ${lastNameController.text}',
        emailAddress: emailController.text,
        mobileNo: '+92${mobileNumberController.text}',
        // token: token,
      );

      if (response.isSuccess) {
        return true;
      } else {
        ShowAlertDialogueClass.showAlertDialogue(
          context: context,
          title: AppStrings.error,
          message: response.responseMessage,
          buttonText: AppStrings.ok,
          iconData: Icons.error,
        );
        return false;
      }
    } catch (e) {
      ShowAlertDialogueClass.showAlertDialogue(
        context: context,
        title: AppStrings.error,
        message: e.toString(),
        buttonText: AppStrings.ok,
        iconData: Icons.error,
      );
      return false;
    } finally {
      _isEditingProfile = false;
      notifyListeners();
    }
  }

  /// Send OTP for edit profile (when mobile or email changed)
  Future<Map<String, dynamic>?> sendOTPForEditProfile({
    required String cnic,
    required String token,
    required BuildContext context,
  }) async {
    try {
      _isSendingOTP = true;
      notifyListeners();

      // Set token in ApiClient before making request
      locator<ApiClient>().setAuthToken(token);

      final response = await _profileService.sendOTPEditProfile(
        emailAddress: emailController.text,
        mobileNo: mobileNumberController.text,
      );

      if (response.isSuccess) {
        return {
          'fullName': '${firstNameController.text} ${lastNameController.text}',
          'mobileNo': mobileNumberController.text,
          'emailAddress': emailController.text,
          'otp': response.otp ?? '',
          'cnic': cnic,
        };
      } else {
        ShowAlertDialogueClass.showAlertDialogue(
          context: context,
          title: AppStrings.error,
          message: response.responseMessage,
          buttonText: AppStrings.ok,
          iconData: Icons.error,
        );
        return null;
      }
    } catch (e) {
      ShowAlertDialogueClass.showAlertDialogue(
        context: context,
        title: AppStrings.error,
        message: e.toString(),
        buttonText: AppStrings.ok,
        iconData: Icons.error,
      );
      return null;
    } finally {
      _isSendingOTP = false;
      notifyListeners();
    }
  }

  /// Clear edit profile fields
  void clearEditProfileFields() {
    firstNameController.clear();
    lastNameController.clear();
    mobileNumberController.clear();
    emailController.clear();
    _originalProfileData = {};
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    descriptionController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    mobileNumberController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
