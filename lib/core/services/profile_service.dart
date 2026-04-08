import 'dart:convert';

import '../../util/app_url.dart';
import '../../view/Profile/profile_model.dart';
import 'base_service.dart';

/// Service for profile-related API calls
class ProfileService extends BaseService {
  ProfileService(super.apiClient);

  // ============================================
  // PROFILE IMAGE OPERATIONS
  // ============================================

  /// Upload profile image
  Future<ProfileImageUploadResponse> uploadProfileImage({
    required String cnic,
    required String base64Image,
  }) async {
    try {
      final data =
          ProfileImageUploadRequest(
            cnic: cnic,
            base64Image: base64Image,
          ).toJson();

      final response = await apiClient.request(
        method: 'POST',
        endpoint: ApiEndpoints.uploadProfileImg,
        data: data,
      );

      if (response != null) {
        final responseData =
            response is Map<String, dynamic>
                ? response
                : jsonDecode(response.toString());
        return ProfileImageUploadResponse.fromJson(responseData);
      }
      throw Exception('Failed to upload profile image: No response');
    } catch (e) {
      throw Exception('Failed to upload profile image: ${e.toString()}');
    }
  }

  /// Download profile image
  Future<Map<String, dynamic>> downloadProfileImage({
    required String cnic,
  }) async {
    try {
      final data = {'CNIC': cnic};

      final response = await apiClient.request(
        method: 'POST',
        endpoint: ApiEndpoints.downloadProfileImg,
        data: data,
      );

      if (response != null) {
        return response is Map<String, dynamic>
            ? response
            : jsonDecode(response.toString());
      }
      throw Exception('Failed to download profile image: No response');
    } catch (e) {
      throw Exception('Failed to download profile image: ${e.toString()}');
    }
  }

  // ============================================
  // PASSWORD OPERATIONS
  // ============================================

  /// Get old password
  Future<OldPasswordResponse> getOldPassword({required String cnic}) async {
    try {
      final data = {'CNIC': cnic};

      final response = await apiClient.request(
        method: 'POST',
        endpoint: ApiEndpoints.getOldPassword,
        data: data,
        isFormData: true,
      );

      if (response != null) {
        final responseData =
            response is Map<String, dynamic>
                ? response
                : jsonDecode(response.toString());
        return OldPasswordResponse.fromJson(responseData);
      }
      throw Exception('Failed to get old password: No response');
    } catch (e) {
      throw Exception('Failed to get old password: ${e.toString()}');
    }
  }

  /// Update password
  Future<PasswordUpdateResponse> updatePassword({
    required String cnic,
    required String newPassword,
  }) async {
    try {
      final data = {'CNIC': cnic, 'Password': newPassword};

      final response = await apiClient.request(
        method: 'POST',
        endpoint: ApiEndpoints.updateOldPassword,
        data: data,
        isFormData: true,
      );

      if (response != null) {
        final responseData =
            response is Map<String, dynamic>
                ? response
                : jsonDecode(response.toString());
        return PasswordUpdateResponse.fromJson(responseData);
      }
      throw Exception('Failed to update password: No response');
    } catch (e) {
      throw Exception('Failed to update password: ${e.toString()}');
    }
  }

  // ============================================
  // COMPLAINT OPERATIONS
  // ============================================

  /// Register complaint
  Future<ComplaintResponse> registerComplaint({
    required String cnic,
    required String category,
    required String description,
  }) async {
    try {
      final data =
          ComplaintRequest(
            cnic: cnic,
            category: category,
            description: description,
          ).toJson();

      final response = await apiClient.request(
        method: 'POST',
        endpoint: ApiEndpoints.registerComplaint,
        data: data,
        isFormData: true,
      );

      if (response != null) {
        final responseData =
            response is Map<String, dynamic>
                ? response
                : jsonDecode(response.toString());
        return ComplaintResponse.fromJson(responseData);
      }
      throw Exception('Failed to register complaint: No response');
    } catch (e) {
      throw Exception('Failed to register complaint: ${e.toString()}');
    }
  }

  // ============================================
  // PROFILE EDIT OPERATIONS
  // ============================================

  /// Edit profile (when mobile and email unchanged)
  Future<EditProfileResponse> editProfile({
    required String cnic,
    required String fullName,
    required String emailAddress,
    required String mobileNo,
  }) async {
    try {
      final data =
          EditProfileRequest(
            cnic: cnic,
            fullName: fullName,
            emailAddress: emailAddress,
            mobileNo: mobileNo,
          ).toJson();

      final response = await apiClient.request(
        method: 'POST',
        endpoint: ApiEndpoints.attemptForEditProfile,
        data: data,
      );

      if (response != null) {
        final responseData =
            response is Map<String, dynamic>
                ? response
                : jsonDecode(response.toString());
        return EditProfileResponse.fromJson(responseData);
      }
      throw Exception('Failed to edit profile: No response');
    } catch (e) {
      throw Exception('Failed to edit profile: ${e.toString()}');
    }
  }

  /// Send OTP for edit profile (when mobile or email changed)
  Future<SendOTPEditProfileResponse> sendOTPEditProfile({
    required String emailAddress,
    required String mobileNo,
  }) async {
    try {
      final data =
          SendOTPEditProfileRequest(
            emailAddress: emailAddress,
            mobileNo: mobileNo,
          ).toJson();

      final response = await apiClient.request(
        method: 'POST',
        endpoint: ApiEndpoints.sendOTPEditProfile,
        data: data,
      );

      if (response != null) {
        final responseData =
            response is Map<String, dynamic>
                ? response
                : jsonDecode(response.toString());
        return SendOTPEditProfileResponse.fromJson(responseData);
      }
      throw Exception('Failed to send OTP: No response');
    } catch (e) {
      throw Exception('Failed to send OTP: ${e.toString()}');
    }
  }

  // ============================================
  // PROFILE DATA OPERATIONS
  // ============================================

  /// Get profile details
  Future<Map<String, dynamic>?> getProfileDetail({required String cnic}) async {
    try {
      final data = {'CNIC': cnic};

      final response = await apiClient.request(
        method: 'POST',
        endpoint: ApiEndpoints.requestForEditProfile,
        data: data,
      );

      return response is Map<String, dynamic> ? response : null;
    } catch (e) {
      return null;
    }
  }

  /// Get card details
  Future<Map<String, dynamic>?> getCardDetail({required String cnic}) async {
    try {
      final data = {'CNIC': cnic};

      final response = await apiClient.request(
        method: 'POST',
        endpoint: ApiEndpoints.getCardDetail,
        data: data,
      );

      return response is Map<String, dynamic> ? response : null;
    } catch (e) {
      return null;
    }
  }
}
