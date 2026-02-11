// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import '../repositary/LoginRepositary.dart';


// class LoginViewModel extends ChangeNotifier{
//   final loginrepositary = LoginRepositary();
//   bool boolLoading = false;
//   setLoading(bool value){
//     boolLoading = value;
//     print('loading called');
//     notifyListeners();

//   }

//   Future<void> getLogin(BuildContext context,dynamic data) async {
//     setLoading(true);
//     loginrepositary.login(data).then((value) async{

//       print('called');
//       print(value.accessToken);
//       // Create storage
//       final storage = new FlutterSecureStorage();

// // Unique key for token
//       final keyToken = 'token';

// // Write token value
//       await storage.write(key: keyToken , value: value.accessToken);
//       setLoading(false);

//       print(value.accessToken);
//      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>TabbedPage()));
//     }).onError((error, stackTrace) {
//       print(error.toString());
//     });
//   }
// }