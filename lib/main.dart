import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'core/locator.dart';
import 'core/providers_list.dart';
import 'view/splash/Splashscreen.dart';

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

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providersList,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // home:MainPageNew(),//NewPasswordNew("17301-4338768-3"),
        home: Splashscreen(),
      ),
    );
  }
}
