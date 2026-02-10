import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../viewmodel/LoginViewModel.dart';
import 'view/splash/Splashscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => LoginViewModel())],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // home:MainPageNew(),//NewPasswordNew("17301-4338768-3"),
        home: Splashscreen(),
      ),
    );
  }
}
