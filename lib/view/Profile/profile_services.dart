// import 'dart:convert';

// import '../../util/NetworkHelperClass.dart';
// import 'profile_model.dart';

// /// Service for profile-related API calls
// class ProfileService {
//   /// Upload profile image
//   Future<ProfileImageUploadResponse> uploadProfileImage({
//     required String cnic,
//     required String base64Image,
//     required String token,
//   }) async {
//     final data =
//         ProfileImageUploadRequest(
//           cnic: cnic,
//           base64Image: base64Image,
//         ).toJson();

//     final auth = 'Bearer $token';
//     final responseBody = await NetworkHelper.uploadProfileImage(data, auth);

//     if (responseBody != null) {
//       return ProfileImageUploadResponse.fromJson(jsonDecode(responseBody));
//     }
//     throw Exception('Failed to upload profile image');
//   }

//   /// Download profile image
//   Future<Map<String, dynamic>> downloadProfileImage({
//     required String cnic,
//     required String token,
//   }) async {
//     final data = {'CNIC': cnic};
//     final auth = 'Bearer $token';
//     final responseBody = await NetworkHelper.downloadProfileImage(data, auth);

//     if (responseBody != null) {
//       return jsonDecode(responseBody);
//     }
//     throw Exception('Failed to download profile image');
//   }

//   /// Get old password
//   Future<OldPasswordResponse> getOldPassword({
//     required String cnic,
//     required String token,
//   }) async {
//     final data = {'CNIC': cnic};
//     final auth = 'Bearer $token';
//     final responseBody = await NetworkHelper.getOldPassword(data, auth);

//     if (responseBody != null) {
//       return OldPasswordResponse.fromJson(jsonDecode(responseBody));
//     }
//     throw Exception('Failed to get old password');
//   }

//   /// Update password
//   Future<PasswordUpdateResponse> updatePassword({
//     required String cnic,
//     required String newPassword,
//     required String token,
//   }) async {
//     final data = {'CNIC': cnic, 'Password': newPassword};
//     final auth = 'Bearer $token';
//     final responseBody = await NetworkHelper.updateOldPassword(data, auth);

//     if (responseBody != null) {
//       return PasswordUpdateResponse.fromJson(jsonDecode(responseBody));
//     }
//     throw Exception('Failed to update password');
//   }

//   /// Register complaint
//   Future<ComplaintResponse> registerComplaint({
//     required String cnic,
//     required String category,
//     required String description,
//     required String token,
//   }) async {
//     final data =
//         ComplaintRequest(
//           cnic: cnic,
//           category: category,
//           description: description,
//         ).toJson();

//     final auth = 'Bearer $token';
//     final responseBody = await NetworkHelper.registerComplaint(data, auth);

//     if (responseBody != null) {
//       final decoded = jsonDecode(responseBody);
//       return ComplaintResponse.fromJson(decoded);
//     }
//     throw Exception('Failed to register complaint');
//   }

//   /// Edit profile (when mobile and email unchanged)
//   Future<EditProfileResponse> editProfile({
//     required String cnic,
//     required String fullName,
//     required String emailAddress,
//     required String mobileNo,
//     required String token,
//   }) async {
//     final data =
//         EditProfileRequest(
//           cnic: cnic,
//           fullName: fullName,
//           emailAddress: emailAddress,
//           mobileNo: mobileNo,
//         ).toJson();

//     final auth = 'Bearer $token';
//     final responseBody = await NetworkHelper.editProfile(data, auth);

//     if (responseBody != null) {
//       return EditProfileResponse.fromJson(jsonDecode(responseBody));
//     }
//     throw Exception('Failed to edit profile');
//   }

//   /// Send OTP for edit profile (when mobile or email changed)
//   Future<SendOTPEditProfileResponse> sendOTPEditProfile({
//     required String emailAddress,
//     required String mobileNo,
//     required String token,
//   }) async {
//     final data =
//         SendOTPEditProfileRequest(
//           emailAddress: emailAddress,
//           mobileNo: mobileNo,
//         ).toJson();

//     final auth = 'Bearer $token';
//     final responseBody = await NetworkHelper.sendOTPEditProfile(data, auth);

//     if (responseBody != null) {
//       return SendOTPEditProfileResponse.fromJson(jsonDecode(responseBody));
//     }
//     throw Exception('Failed to send OTP');
//   }
// }
