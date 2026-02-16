import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../util/theme/app_colors.dart';
import '../../QR_Code/QRCodePageNew.dart';
import '../../home_page/home_provider.dart';

/// QPay tab content - QR Code Scanner
class QPayTab extends StatelessWidget {
  const QPayTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'QR Code Scanner',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final provider = Provider.of<HomeProvider>(
                    context,
                    listen: false,
                  );
                  final permissionStatus = await Permission.camera.request();
                  if (permissionStatus == PermissionStatus.granted) {
                    if (context.mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => QRCodeScanner(provider.serviceCharges),
                        ),
                      );
                    }
                  }
                },
                child: const Text('Open QR Scanner'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
