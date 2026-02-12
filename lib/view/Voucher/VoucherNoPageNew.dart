import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../util/Constants.dart';
import '../PaymentPageNew.dart';
import 'Voucher_provider.dart';
import 'Voucher_widget.dart';

/// Voucher number entry screen
/// User enters voucher number to check payment details
class VoucherNoPageNew extends StatefulWidget {
  const VoucherNoPageNew({super.key});

  @override
  _VoucherNoPageNewState createState() => _VoucherNoPageNewState();
}

class _VoucherNoPageNewState extends State<VoucherNoPageNew> {
  final TextEditingController _voucherController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _voucherController.dispose();
    super.dispose();
  }

  Future<void> _handleCheckPayment() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final voucherProvider = Provider.of<VoucherProvider>(
      context,
      listen: false,
    );

    final success = await voucherProvider.loadApplicationDetails(
      dtpPaymentID: _voucherController.text,
      context: context,
    );

    if (success && mounted) {
      // Navigate to payment page with the first pending due
      if (voucherProvider.pendingDues.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => PaymentPageNew(
                  voucherProvider.pendingDues[0],
                  voucherProvider.serviceCharges,
                ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xffFAFCFF),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VoucherTitleText(text: 'Enter your voucher number'),
                  VoucherNumberField(controller: _voucherController),
                  SizedBox(
                    height: Constants.getVerticalGapBetweenTwoTextformfields(
                      context,
                    ),
                  ),
                  Consumer<VoucherProvider>(
                    builder: (context, voucherProvider, _) {
                      return VoucherCheckButton(
                        onPressed: _handleCheckPayment,
                        isLoading: voucherProvider.isLoading,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
