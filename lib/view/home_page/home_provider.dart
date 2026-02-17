import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:paymir_new_android/util/SecureStorage.dart';

import '../../util/AlertDialogueClass.dart';
import '../login/login_screen.dart';
import 'home_services.dart';

/// Provider for managing home screen state
class HomeProvider extends ChangeNotifier {
  final HomeService _homeService = HomeService();

  // Loading states
  bool _isLoadingCard = false;
  bool _isLoadingPending = false;
  bool _isLoadingDone = false;
  bool _isLoadingProfile = false;

  // Data
  Map<String, dynamic> _cardData = {};
  List<dynamic> _pendingDues = [];
  List<dynamic> _doneTransactions = [];
  Map<String, dynamic> _profileData = {};
  List<dynamic> _serviceCharges = [];

  // User data
  String _cardHolderName = "Name";
  String _cardNumber = "****  ****  ****  ****";
  File? _profileImage;

  // Getters
  bool get isLoadingCard => _isLoadingCard;
  bool get isLoadingPending => _isLoadingPending;
  bool get isLoadingDone => _isLoadingDone;
  bool get isLoadingProfile => _isLoadingProfile;
  bool get isLoading =>
      _isLoadingCard ||
      _isLoadingPending ||
      _isLoadingDone ||
      _isLoadingProfile;

  Map<String, dynamic> get cardData => _cardData;
  List<dynamic> get pendingDues => _pendingDues;
  List<dynamic> get doneTransactions => _doneTransactions;
  Map<String, dynamic> get profileData => _profileData;
  List<dynamic> get serviceCharges => _serviceCharges;

  String get cardHolderName => _cardHolderName;
  String get cardNumber => _cardNumber;
  File? get profileImage => _profileImage;

  /// Get formatted expiry date (5 years from now)
  String getExpiryDate() {
    return DateFormat('MM/yyyy')
        .format(
          DateTime(
            DateTime.now().year + 5,
            DateTime.now().month,
            DateTime.now().day,
          ),
        )
        .toString()
        .replaceRange(
          0,
          2,
          DateFormat('MM')
              .format(
                DateTime(
                  DateTime.now().year + 5,
                  DateTime.now().month,
                  DateTime.now().day,
                ),
              )
              .toString(),
        );
  }

  /// Get CNIC from storage
  Future<String> getCNIC() async {
    return await SecureStorage().getCNIC() ?? '';
  }

  /// Load all home data
  Future<void> loadAllData() async {
    final token = await SecureStorage().getToken() ?? '';
    final cnic = await SecureStorage().getCNIC() ?? '';

    if (token.isEmpty || cnic.isEmpty) {
      return;
    }

    await Future.wait([
      loadCardDetails(cnic: cnic, token: token),
      loadPendingTransactions(cnic: cnic, token: token),
      loadDoneTransactions(cnic: cnic, token: token),
      loadProfileDetails(cnic: cnic, token: token),
      loadProfileImage(),
    ]);
  }

  /// Load card details
  Future<void> loadCardDetails({
    required String cnic,
    required String token,
  }) async {
    try {
      _isLoadingCard = true;
      notifyListeners();

      final response = await _homeService.getCardDetail(
        cnic: cnic,
        token: token,
      );
      _cardData = response;

      if (response.toString().contains("true")) {
        _cardHolderName = response['fullName']?.toString() ?? "Name";
        final ePaymentNo = response['ePaymentNo']?.toString() ?? "";
        _cardNumber = RegExp(
          r'\d{1,4}',
        ).allMatches(ePaymentNo).map((match) => match.group(0)).join('  ');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading card details: $e');
      }
    } finally {
      _isLoadingCard = false;
      notifyListeners();
    }
  }

  /// Load pending transactions
  Future<void> loadPendingTransactions({
    required String cnic,
    required String token,
  }) async {
    try {
      _isLoadingPending = true;
      notifyListeners();

      final response = await _homeService.getPendingTransactions(
        cnic: cnic,
        token: token,
      );
      final jsonString = response.toString();

      if (jsonString.contains("404")) {
        _pendingDues = [];
      } else {
        _pendingDues = response['pendingDues'] ?? [];
        _serviceCharges = response['serviceProviderTaxesConfigurations'] ?? [];
      }
    } catch (e) {
      _pendingDues = [];
      if (kDebugMode) {
        print('Error loading pending transactions: $e');
      }
    } finally {
      _isLoadingPending = false;
      notifyListeners();
    }
  }

  /// Load done transactions
  Future<void> loadDoneTransactions({
    required String cnic,
    required String token,
  }) async {
    try {
      _isLoadingDone = true;
      notifyListeners();

      final response = await _homeService.getDoneTransactions(
        cnic: cnic,
        token: token,
      );
      _doneTransactions = response['receivedData'] ?? [];
    } catch (e) {
      _doneTransactions = [];
      if (kDebugMode) {
        print('Error loading done transactions: $e');
      }
    } finally {
      _isLoadingDone = false;
      notifyListeners();
    }
  }

  /// Load profile details
  Future<void> loadProfileDetails({
    required String cnic,
    required String token,
  }) async {
    try {
      _isLoadingProfile = true;
      notifyListeners();

      final response = await _homeService.getProfileDetail(
        cnic: cnic,
        token: token,
      );
      _profileData = response;
    } catch (e) {
      if (kDebugMode) {
        print('Error loading profile details: $e');
      }
    } finally {
      _isLoadingProfile = false;
      notifyListeners();
    }
  }

  /// Set profile image
  void setProfileImage(File? image) {
    _profileImage = image;
    notifyListeners();
  }

  /// Load profile image from local storage
  Future<void> loadProfileImage() async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      const fileName = 'avatar.png';
      final file = File('${appDir.path}/$fileName');
      if (await file.exists()) {
        setProfileImage(file);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading profile image: $e');
      }
    }
  }

  /// Format transaction details for display
  String formatTransactionDetails(Map<String, dynamic> transaction) {
    String formatDate(String date) {
      try {
        DateTime dateTime = DateTime.parse(date);
        return DateFormat('dd MMMM yyyy hh:mm a').format(dateTime);
      } catch (e) {
        return date;
      }
    }

    String output = '';
    transaction.forEach((key, value) {
      String displayKey = key;
      String displayValue = value.toString();

      switch (key) {
        case 'dptPaymentID':
          displayKey = 'Payment Id';
          break;
        case 'serviceName':
          displayKey = 'Service Name';
          break;
        case 'cnic':
          displayKey = 'CNIC';
          break;
        case 'feeAmount':
          displayKey = 'Fee amount';
          break;
        case 'paymentDate':
          displayKey = 'Payment date';
          displayValue = formatDate(value.toString());
          break;
        case 'serviceTypeName':
          displayKey = 'Service Type Name';
          break;
        case 'departmentName':
          displayKey = 'Department name';
          break;
        case 'ePayExpireDate':
          displayKey = 'Expiry date';
          displayValue = formatDate(value.toString());
          break;
        case 'serviceKey':
          displayKey = 'Service Key';
          break;
        case 'serviceProviderName':
          displayKey = 'Service provider name';
          break;
        case 'paymentMode':
          displayKey = 'Payment Mode';
          break;
        case 'usedMobileAccount':
          displayKey = 'Mobile account used';
          break;
        case 'serviceFee':
        case 'serviceCharges':
          displayKey = 'Service fee';
          break;
        case 'totalAmountPaidByCitizen':
          displayKey = 'Total amount paid';
          break;
      }
      output += '$displayKey:\n$displayValue\n\n';
    });

    return output;
  }

  /// Show transaction details dialog
  void showTransactionDetailsDialog(
    BuildContext context,
    Map<String, dynamic> transaction,
  ) {
    final output = formatTransactionDetails(transaction);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Done Transaction'),
          content: SingleChildScrollView(child: Text(output)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  /// Handle logout
  Future<void> handleLogout(BuildContext context) async {
    try {
      await SecureStorage().deleteToken();
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
        );
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error deleting token: $error");
      }
      if (context.mounted) {
        showErrorDialog(
          context,
          'Error',
          'Failed to logout. Please try again.',
        );
      }
    }
  }

  /// Show logout confirmation dialog
  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => handleLogout(context),
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  /// Refresh all data
  Future<void> refreshData() async {
    await loadAllData();
  }

  /// Handle session expired
  void handleSessionExpired(BuildContext context, {String? message}) {
    SecureStorage().deleteToken();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }

  /// Show error dialog
  void showErrorDialog(BuildContext context, String title, String message) {
    ShowAlertDialogueClass.showAlertDialogue(
      context: context,
      title: title,
      message: message,
      buttonText: 'Close',
      iconData: Icons.error,
    );
  }
}
