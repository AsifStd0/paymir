import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../../util/AlertDialogueClass.dart';
import '../../util/NetworkHelperClass.dart';
import '../../util/SecureStorage.dart';
import '../../view/login/login_screen.dart';
import 'hed_services.dart';

/// Provider for managing HED page state
class HedProvider extends ChangeNotifier {
  final HedService _hedService = HedService();
  final SecureStorage _secureStorage = SecureStorage();

  // Loading states
  bool _isLoading = false;
  bool _isLoadingPending = false;
  bool _isLoadingDone = false;

  // Data
  List<dynamic> _pendingDues = [];
  List<dynamic> _doneTransactions = [];
  List<dynamic> _serviceCharges = [];
  Map<String, dynamic> _cardData = {};
  File? _profileImage;

  // Mobile number controller
  final TextEditingController mobileController = TextEditingController();

  // Getters
  bool get isLoading => _isLoading;
  bool get isLoadingPending => _isLoadingPending;
  bool get isLoadingDone => _isLoadingDone;
  List<dynamic> get pendingDues => _pendingDues;
  List<dynamic> get doneTransactions => _doneTransactions;
  List<dynamic> get serviceCharges => _serviceCharges;
  Map<String, dynamic> get cardData => _cardData;
  File? get profileImage => _profileImage;

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

  /// Load pending transactions by mobile number
  Future<void> loadPendingTransactions({
    required String mobileNo,
    required String token,
  }) async {
    try {
      _isLoadingPending = true;
      _isLoading = true;
      notifyListeners();

      final response = await _hedService.getPendingTransactionsByMobile(
        mobileNo: mobileNo,
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
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Load done transactions by mobile number
  Future<void> loadDoneTransactions({
    required String mobileNo,
    required String token,
  }) async {
    try {
      _isLoadingDone = true;
      _isLoading = true;
      notifyListeners();

      final response = await _hedService.getDoneTransactionsByMobile(
        mobileNo: mobileNo,
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
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Load card details
  Future<void> loadCardDetails({
    required String cnic,
    required String token,
  }) async {
    try {
      final response = await _hedService.getCardDetail(
        cnic: cnic,
        token: token,
      );
      _cardData = response;
    } catch (e) {
      if (kDebugMode) {
        print('Error loading card details: $e');
      }
    }
  }

  /// Load entries (both pending and done transactions)
  Future<void> loadEntries(BuildContext context) async {
    final token = await _secureStorage.getToken() ?? '';
    final mobileNo = mobileController.text.trim();

    if (token.isEmpty || mobileNo.isEmpty) {
      return;
    }

    if (!await NetworkHelper.checkInternetConnection()) {
      ShowAlertDialogueClass.showAlertDialogue(
        context: context,
        title: "No Internet",
        message: "Check your internet connection!",
        buttonText: "OK",
        iconData: Icons.error,
      );
      return;
    }

    await Future.wait([
      loadPendingTransactions(mobileNo: mobileNo, token: token),
      loadDoneTransactions(mobileNo: mobileNo, token: token),
    ]);
  }

  /// Refresh data
  Future<void> refreshData() async {
    final token = await _secureStorage.getToken() ?? '';
    final mobileNo = mobileController.text.trim();

    if (token.isEmpty || mobileNo.isEmpty) {
      return;
    }

    await Future.wait([
      loadPendingTransactions(mobileNo: mobileNo, token: token),
      loadDoneTransactions(mobileNo: mobileNo, token: token),
    ]);
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

  /// Handle session expired
  void handleSessionExpired(BuildContext context) {
    _secureStorage.deleteToken();
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

  @override
  void dispose() {
    mobileController.dispose();
    super.dispose();
  }
}
