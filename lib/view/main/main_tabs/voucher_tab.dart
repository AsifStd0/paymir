import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../Voucher/VoucherNoPageNew.dart';

/// Voucher tab content
class VoucherTab extends StatelessWidget {
  const VoucherTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: const VoucherNoPageNew(),
    );
  }
}
