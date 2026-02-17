import 'package:flutter/material.dart';
import 'package:paymir_new_android/api/NetworkApiService.dart';

import '../../util/AlertDialogueClass.dart';
import '../../util/SecureStorage.dart';
import '../../util/app_strings.dart';
import 'voucher_service.dart';

/// Provider for managing voucher page state and logic
class VoucherProvider extends ChangeNotifier {
  final VoucherService _voucherService = VoucherService();

  // Loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Data
  List<dynamic> _pendingDues = [];
  List<dynamic> get pendingDues => _pendingDues;

  List<dynamic> _serviceCharges = [];
  List<dynamic> get serviceCharges => _serviceCharges;

  // Error handling
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// Load application details by voucher number
  Future<bool> loadApplicationDetails({
    required String dtpPaymentID,
    required BuildContext context,
  }) async {
    try {
      _setLoading(true);
      _setError(null);

      // Check internet connection
      if (!await NetworkApiService.checkInternetConnection()) {
        _setLoading(false);
        ShowAlertDialogueClass.showAlertDialogue(
          context: context,
          title: AppStrings.noInternet,
          message: AppStrings.checkInternetConnection,
          buttonText: AppStrings.ok,
          iconData: Icons.error,
        );
        return false;
      }

      // Get token and CNIC from SharedPreferences
      final token = await SecureStorage().getToken() ?? '';
      final cnic = await SecureStorage().getCNIC() ?? '';

      if (token.isEmpty || cnic.isEmpty) {
        _setLoading(false);
        _setError('Authentication data not found');
        ShowAlertDialogueClass.showAlertDialogue(
          context: context,
          title: AppStrings.error,
          message: 'Please login again',
          buttonText: AppStrings.ok,
          iconData: Icons.error,
        );
        return false;
      }

      // Call API
      final response = await _voucherService.getPendingTransactionsByVoucher(
        dtpPaymentID: dtpPaymentID,
        cnic: cnic,
        token: token,
      );

      _setLoading(false);

      // Parse response
      _pendingDues = response['pendingDues'] ?? [];
      _serviceCharges = response['serviceProviderTaxesConfigurations'] ?? [];

      if (_pendingDues.isEmpty) {
        _showNoRecordDialog(context);
        return false;
      }

      notifyListeners();
      return true;
    } catch (e) {
      _setLoading(false);
      _setError(e.toString());

      if (e.toString().contains('No record found')) {
        _showNoRecordDialog(context);
      } else {
        _showErrorDialog(context, 'Server is down and cannot be accessed!');
      }
      return false;
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _showNoRecordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("No record found!"),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
