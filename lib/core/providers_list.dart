// providers_list.dart
import 'package:paymir_new_android/providers/auth/login_provider.dart';
import 'package:paymir_new_android/view/Voucher/Voucher_provider.dart';
import 'package:provider/provider.dart';

import '../providers/auth/signup_provider.dart';
import '../view/HED/hed_provider.dart';
import '../view/Profile/profile_provider.dart';
import '../view/home_page/home_provider.dart';
import '../view/main/main_provider.dart';

List<ChangeNotifierProvider> providersListData = [
  ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
  ChangeNotifierProvider<SignupProvider>(create: (_) => SignupProvider()),
  ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
  ChangeNotifierProvider<HedProvider>(create: (_) => HedProvider()),
  ChangeNotifierProvider<ProfileProvider>(create: (_) => ProfileProvider()),
  ChangeNotifierProvider<MainProvider>(create: (_) => MainProvider()),
  ChangeNotifierProvider<VoucherProvider>(create: (_) => VoucherProvider()),
];
