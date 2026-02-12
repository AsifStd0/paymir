import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paymir_new_android/core/locator.dart';
import 'package:paymir_new_android/core/providers_list.dart';
import 'package:paymir_new_android/core/theme/app_theme.dart';
import 'package:paymir_new_android/view/splash/Splashscreen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize GetIt locator (SharedPreferences will initialize lazily)
  // We catch errors here to prevent app crash if platform channel isn't ready

  try {
    await setupLocator();
  } catch (e) {
    // Log error but continue - SharedPreferences will initialize when needed
    debugPrint('Locator setup error (non-critical): $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providersListData,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.getThemeData(),
        home: Splashscreen(),
      ),
    );
  }
}
