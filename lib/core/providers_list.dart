import 'package:provider/provider.dart';

import '../view/login/login_provider.dart';
import '../view/signup/signup_provider.dart';
import '../viewmodel/LoginViewModel.dart';

final providersList = [
  ChangeNotifierProvider(create: (_) => LoginViewModel()),
  ChangeNotifierProvider(create: (_) => SignupProvider()),
  ChangeNotifierProvider(create: (_) => LoginProvider()),
];
