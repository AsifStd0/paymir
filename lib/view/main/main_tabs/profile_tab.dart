import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../util/theme/app_colors.dart';
import '../../Profile/Profile_Screen.dart';
import '../../home_page/home_provider.dart';

/// Profile/Settings tab content
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getCNIC(context),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            backgroundColor: AppColors.background,
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Consumer<HomeProvider>(
          builder: (context, provider, _) {
            return ProfileScreen(
              strCNIC: snapshot.data!,
              cardDataJsonObject: provider.profileData,
            );
          },
        );
      },
    );
  }

  Future<String> _getCNIC(BuildContext context) async {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    return await provider.getCNIC();
  }
}
