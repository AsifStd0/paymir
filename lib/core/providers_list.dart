// providers_list.dart
import 'package:paymir_new_android/providers/auth/login_provider.dart';
import 'package:provider/provider.dart';

import '../providers/auth/mobile_provider.dart';
import '../providers/auth/signup_provider.dart';
import '../view/Dastak/home_provider.dart';
import '../view/HED/hed_provider.dart';

List<ChangeNotifierProvider> providersListData = [
  ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
  ChangeNotifierProvider<SignupProvider>(create: (_) => SignupProvider()),
  ChangeNotifierProvider<MobileProvider>(create: (_) => MobileProvider()),
  ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
  ChangeNotifierProvider<HedProvider>(create: (_) => HedProvider()),
];
