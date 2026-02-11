import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:paymir_new_android/util/app_colors.dart';

import '../util/Constants.dart';
import '../util/NetworkHelperClass.dart';
import '../util/SecureStorage.dart';
import '../view/UpdatePasswordPageNew.dart';
import 'CustomerSupportPageNew.dart';
import 'EditProfilePageNew.dart';
import 'home_page/home_screen.dart';
import 'login/login_screen.dart';

class ProfilePageNew extends StatefulWidget {
  String strCNIC;
  Map<String, dynamic> cardDataJsonObject;
  ProfilePageNew(this.strCNIC, this.cardDataJsonObject);

  @override
  _ProfilePageNewState createState() =>
      _ProfilePageNewState(strCNIC, cardDataJsonObject);
}

class _ProfilePageNewState extends State<ProfilePageNew> {
  String strCNIC;
  Map<String, dynamic> cardDataJsonObject;

  _ProfilePageNewState(this.strCNIC, this.cardDataJsonObject);

  File? _image;

  final picker = ImagePicker();

  Future<void> getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile == null) {
      // User cancelled the image selection
      return;
    }

    final appDir = await getApplicationDocumentsDirectory();
    final fileName = 'avatar.png';
    final file = File('${appDir.path}/$fileName');
    await file.writeAsBytes(await pickedFile.readAsBytes());

    setState(() {
      _image = File(pickedFile.path);
    });

    while (_image == null) {
      await Future.delayed(Duration(milliseconds: 100));
      if (kDebugMode) {
        print("image is still null!");
      }
    }

    List<int> imageBytes = await _image!.readAsBytes();
    String base64Image = base64Encode(imageBytes);

    //log(base64Image);

    if (kDebugMode) {
      if (base64Image != null) {
        //    log(base64Image);
      } else {
        log("Base64Image is null");
      }
    }

    //uploadAvatarToServer(base64Image);
    //downloadAvatarFromServer();
    //uploadImage(_image!);
  }

  Future<void> uploadImage(File imageFile) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://paymir.kp.gov.pk/test/upload'),
    );
    request.fields['CNIC'] = '17301-4338768-3';
    request.files.add(
      await http.MultipartFile.fromPath('UploadedFile1', imageFile.path),
    );
    var response = await request.send();
    print(response.toString());
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Image uploaded!');
      }
    } else {
      if (kDebugMode) {
        print('Upload failed with status ${response.statusCode}');
      }
    }
  }

  String fullName = "";
  String mobileNo = "";
  String initials =
      ""; //name.split(' ').map((word) => word[0]).take(2).join().toUpperCase();

  var _isNotificationSwitched = false;
  // var _makeButtonEnabled = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = 'avatar.png';
      final file = File('${appDir.path}/$fileName');
      if (await file.exists()) {
        setState(() {
          _image = file;
        });
      }
    });

    setState(() {
      //  _makeButtonEnabled = false;

      fullName = cardDataJsonObject['fullName'].toString();
      List<String> names = fullName.split(' ');

      initials = getInitials(fullName);

      mobileNo = cardDataJsonObject['mobileNo'].toString();
    });

    fetchSecureStorageData();
    Future.delayed(const Duration(milliseconds: 2900), () {
      //loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePageNew()),
        );
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: Constants.getBackArrowLeftPadding(context),
                      top: Constants.getBackArrowTopPadding(context),
                      bottom: Constants.getBackArrowBottomPadding(context),
                    ),
                    child: IconButton(
                      icon: SvgPicture.asset("assets/images/back_arrow.svg"),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Constants.getSymmetricHorizontalPadding(context),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Settings',
                      style: TextStyle(
                        color: AppColors.primaryColor(),
                        fontFamily: 'Visby',
                        fontWeight: FontWeight.bold,
                        fontSize: Constants.getMainFontSize(context),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.08,
                  left: MediaQuery.of(context).size.width * 0.04,
                  right: MediaQuery.of(context).size.width * 0.04,
                  bottom: MediaQuery.of(context).size.width * 0.05,
                ),
                child: Container(
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width * 0.05,
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(
                          Constants.getVerticalGapBetweenTwoTextformfields(
                            context,
                          ),
                        ),
                        spreadRadius:
                            Constants.getVerticalGapBetweenTwoTextformfields(
                              context,
                            ) *
                            2,
                        blurRadius:
                            Constants.getVerticalGapBetweenTwoTextformfields(
                              context,
                            ) *
                            20,
                        offset: const Offset(
                          0,
                          2,
                        ), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(Constants.getCardBorderRadius(context)),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        AppColors.gradientColor1(),
                        AppColors.gradientColor2(),
                      ],
                    ),
                  ),
                  height: MediaQuery.of(context).size.width * 0.45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.04,
                          top: MediaQuery.of(context).size.width * 0.02,
                          bottom: MediaQuery.of(context).size.width * 0.01,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Container(
                                        height: 200,
                                        child: Column(
                                          children: [
                                            SizedBox(height: 10),
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                18.0,
                                              ),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Choose an option',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Icon(
                                                    Icons
                                                        .check_circle_outline_rounded,
                                                    color: Colors.green,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            SimpleDialogOption(
                                              onPressed: () {
                                                getImage(ImageSource.gallery);
                                                Navigator.pop(context);
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.photo_library,
                                                    color: Colors.blue,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text('Gallery'),
                                                ],
                                              ),
                                            ),
                                            SimpleDialogOption(
                                              onPressed: () {
                                                getImage(ImageSource.camera);
                                                Navigator.pop(context);
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.camera_alt,
                                                    color: Colors.blue,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text('Camera'),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: CircleAvatar(
                                radius:
                                    MediaQuery.of(context).size.width * 0.109,
                                backgroundColor: Colors.white,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: CircleAvatar(
                                        radius:
                                            MediaQuery.of(context).size.width *
                                            0.109,
                                        //backgroundColor: Colors.white,
                                        backgroundImage:
                                            _image != null
                                                ? FileImage(_image!)
                                                : null,
                                        backgroundColor:
                                            _image != null
                                                ? null
                                                : Colors.white,
                                        child:
                                            (_image == null)
                                                ? Text(
                                                  initials,
                                                  style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(
                                                          context,
                                                        ).size.width *
                                                        0.095,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                )
                                                : Text(
                                                  "",
                                                  style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(
                                                          context,
                                                        ).size.width *
                                                        0.095,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Container(
                                                height: 200,
                                                child: Column(
                                                  children: [
                                                    SizedBox(height: 10),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                            18.0,
                                                          ),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Choose an option',
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          Icon(
                                                            Icons
                                                                .check_circle_outline_rounded,
                                                            color: Colors.green,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    SimpleDialogOption(
                                                      onPressed: () {
                                                        getImage(
                                                          ImageSource.gallery,
                                                        );
                                                        Navigator.pop(context);
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.photo_library,
                                                            color: Colors.blue,
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text('Gallery'),
                                                        ],
                                                      ),
                                                    ),
                                                    SimpleDialogOption(
                                                      onPressed: () {
                                                        getImage(
                                                          ImageSource.camera,
                                                        );
                                                        Navigator.pop(context);
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.camera_alt,
                                                            color: Colors.blue,
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text('Camera'),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Align(
                                        alignment: Alignment(
                                          0.0,
                                          MediaQuery.of(context).size.width *
                                              0.0042,
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Color(0xff1E7A98),
                                              width: 2,
                                            ),
                                          ),
                                          child: CircleAvatar(
                                            radius:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.034,
                                            backgroundColor: Colors.white,
                                            child: SvgPicture.asset(
                                              'assets/images/camera.svg',
                                              height:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.038,
                                              width:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.038,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.07,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      fullName,
                                      style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                            0.045,
                                      ),
                                    ),
                                  ),

                                  Text(
                                    formatMobileNumber(mobileNo),
                                    style: TextStyle(
                                      color: Color(0xffFFFFFF),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w100,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                          0.031,
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.width *
                                        0.015,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.verified,
                                        color: Colors.white,
                                        size:
                                            MediaQuery.of(context).size.width *
                                            0.045,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                            0.02,
                                      ),
                                      Text(
                                        'Verified',
                                        style: TextStyle(
                                          color: Color(0xffFFFFFF),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.038,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.12,
                        ),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width * 0.1,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => EditProfilePageNew(
                                        strCNIC,
                                        cardDataJsonObject,
                                      ),
                                ),
                              );
                            },
                            child: Text(
                              'Edit profile',
                              style: TextStyle(
                                color: Color(0xffFFFFFF),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w100,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                                side: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.04,
                      ),
                      child: Card(
                        child: ListTile(
                          leading: Padding(
                            padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.03,
                            ),
                            child: SvgPicture.asset(
                              'assets/images/headphone.svg',
                              width: MediaQuery.of(context).size.width * 0.05,
                              height: MediaQuery.of(context).size.width * 0.05,
                            ),
                          ),
                          title: Text(
                            'Customer Support',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.035,
                              color: Color(0xff898A8F),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: MediaQuery.of(context).size.width * 0.04,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => CustomerSupportPageNew(
                                      strCNIC,
                                      cardDataJsonObject,
                                    ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04),
                    //   child: Card(
                    //     child: ListTile(
                    //       enabled: false,
                    //       leading: Padding(
                    //         padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                    //         child: SvgPicture.asset(
                    //           'assets/images/accountsettings.svg',
                    //           width: MediaQuery.of(context).size.width * 0.05,
                    //           height: MediaQuery.of(context).size.width * 0.05,
                    //         ),
                    //       ),
                    //       title: Text(
                    //         'Account Settings',
                    //         style: TextStyle(
                    //           fontSize: MediaQuery.of(context).size.width * 0.035,
                    //           color: Color(0xff898A8F),
                    //           fontFamily: 'Poppins',
                    //           fontWeight: FontWeight.normal,
                    //         ),
                    //       ),
                    //       trailing: Icon(Icons.arrow_forward_ios, size: MediaQuery.of(context).size.width * 0.04),
                    //       onTap: () {},
                    //     ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04),
                    //   child: Card(
                    //     child: ListTile(
                    //       enabled: false,
                    //       leading: Padding(
                    //         padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                    //         child: SvgPicture.asset(
                    //           'assets/images/notificationsicon.svg',
                    //           width: MediaQuery.of(context).size.width * 0.05,
                    //           height: MediaQuery.of(context).size.width * 0.05,
                    //         ),
                    //       ),
                    //       title: Text(
                    //         'Notifications',
                    //         style: TextStyle(
                    //           fontSize: MediaQuery.of(context).size.width * 0.035,
                    //           color: Color(0xff898A8F),
                    //           fontFamily: 'Poppins',
                    //           fontWeight: FontWeight.normal,
                    //         ),
                    //       ),
                    //       trailing: Padding(
                    //         padding:  EdgeInsets.only(right:0.0),
                    //         child: Switch(
                    //                                   value: _isNotificationSwitched,
                    //                                   // onChanged: (value) {
                    //                                   // setState(() {
                    //                                   // _isNotificationSwitched = value;
                    //                                   // });
                    //                                   // },
                    //           onChanged: null,
                    //                                   activeTrackColor: Colors.lightGreenAccent,
                    //                                   activeColor: Colors.green,
                    //                                   ),
                    //       ),
                    //                            onTap: () {},
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.04,
                      ),
                      child: Card(
                        child: ListTile(
                          leading: Padding(
                            padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.03,
                            ),
                            child: SvgPicture.asset(
                              'assets/images/passwordupdate.svg',
                              width: MediaQuery.of(context).size.width * 0.06,
                              height: MediaQuery.of(context).size.width * 0.06,
                            ),
                          ),
                          title: Text(
                            'Update Password',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.035,
                              color: Color(0xff898A8F),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: MediaQuery.of(context).size.width * 0.04,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => UpdatePasswordPageNew(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.04,
                      ),
                      child: Card(
                        child: ListTile(
                          leading: Padding(
                            padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.03,
                            ),
                            child: SvgPicture.asset(
                              'assets/images/logout.svg',
                              width: MediaQuery.of(context).size.width * 0.05,
                              height: MediaQuery.of(context).size.width * 0.05,
                            ),
                          ),
                          title: Text(
                            'Logout',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.035,
                              color: Color(0xffE84F4F),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: MediaQuery.of(context).size.width * 0.04,
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    'Are you sure you want to logout?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        // Your code here
                                        _secureStorage.deleteToken();
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => const LoginScreen(),
                                          ),
                                        );
                                      },
                                      child: const Text('Yes'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('No'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Map<String, dynamic> cardDataJsonObject ={};

  String strToken = "";
  final SecureStorage _secureStorage = SecureStorage();
  Future<void> fetchSecureStorageData() async {
    strToken = await _secureStorage.getToken() ?? '';
  }

  // Future<bool> loadData() async {
  //
  //   var data =  {
  //     "CNIC" : strCNIC,
  //   };
  //
  //
  //   String auth = "Bearer $strToken";
  //
  //   try {
  //     final responseBody = await NetworkHelper.getProfileDetail(data, auth);
  //
  //     cardDataJsonObject = jsonDecode(responseBody!);
  //
  //     if (kDebugMode) {
  //       print("Header: " + auth);
  //       print("data object: " +data.toString());
  //       print("CNIC used: " + strCNIC);
  //       print("Response: " + responseBody);
  //     }
  //
  //     if (cardDataJsonObject["statusCode"]=="204")
  //     {
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(10.0),
  //             ),
  //             title: const Row(
  //               children: [
  //                 Icon(
  //                   Icons.error_outline,
  //                   color: Colors.red,
  //                 ),
  //                 SizedBox(width: 10.0),
  //                 Text('Error'),
  //               ],
  //             ),
  //             content: Text(cardDataJsonObject["responseMessage"]),
  //             actions: [
  //               TextButton(
  //                 child: const Text('OK'),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //
  //     }
  //     else
  //     {
  //       {
  //         setState(() {
  //           _makeButtonEnabled = false;
  //
  //           String fullName = cardDataJsonObject['fullName'].toString();
  //           List<String> names = fullName.split(' ');
  //           String firstName = names[0];
  //           String lastName = names[names.length - 1];
  //
  //           if (names.length > 2) {
  //             firstName = names.sublist(0, names.length - 1).join(' ');
  //           }
  //
  //           // _firstNameController.text = firstName;
  //           // _lastNameController.text = lastName;
  //           // _mobileNumberController.text = cardDataJsonObject['mobileNo'].toString().replaceAll('+92', '');
  //           // _emailController.text = cardDataJsonObject['emailAddress'];
  //
  //         });
  //       }
  //     }
  //
  //     if (kDebugMode) {
  //       print("card checking: ${cardDataJsonObject['fullName']}");
  //     }
  //   }
  //   catch (e) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text("Error"),
  //           content:
  //           Text(e.toString()),
  //           actions: [
  //             TextButton(
  //               child: const Text("Close"),
  //               onPressed: () {
  //                 _secureStorage.deleteToken();
  //                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPageNew()));
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  //   return false;
  // }

  String getInitials(String name) {
    // Split the name into words
    List<String> words = name.split(' ');

    // Get the first letter of the first word
    String firstLetter = words[0][0];

    // Find the first word that doesn't start with a title
    String firstName = '';
    for (String word in words) {
      if (!word.startsWith('Dr.') &&
          !word.startsWith('Engr.') &&
          !word.startsWith('Mr.') &&
          !word.startsWith('Mrs.') &&
          !word.startsWith('Miss.')) {
        firstName = word;
        break;
      }
    }

    // Get the first two letters of each remaining word
    List<String> initials = [];
    for (String word in words) {
      if (!word.startsWith('Dr.') &&
          !word.startsWith('Engr.') &&
          !word.startsWith('Mr.') &&
          !word.startsWith('Mrs.') &&
          !word.startsWith('Miss.') &&
          word != firstName) {
        if (word.length >= 2) {
          initials.add(word[0]);
          if (word.indexOf(' ') != -1 && word.indexOf(' ') + 1 < word.length) {
            initials.add(word[word.indexOf(' ') + 1]);
          }
        } else if (word.length == 1) {
          initials.add(word);
        }
      }
    }

    // Combine the initials and return them
    return firstLetter + initials.join('');
  }

  String formatMobileNumber(String mobileNo) {
    // Remove all non-numeric characters from the string
    String digitsOnly = mobileNo.replaceAll(RegExp(r'[^0-9]'), '');

    // Add spaces between the country code and the rest of the number
    return '+${digitsOnly.substring(0, 2)} ${digitsOnly.substring(2, 6)} ${digitsOnly.substring(6)}';
  }

  Future<bool> uploadAvatarToServer(String base64String) async {
    var data = {"CNIC": strCNIC, "Base64_txt_encoder": base64String};

    if (base64String != null) {
      //debugPrint("printing base64: " + base64String);
    } else {
      debugPrint("Base64Image is null");
    }

    String auth = "Bearer $strToken";

    try {
      final responseBody = await NetworkHelper.uploadProfileImage(data, auth);

      Map<String, dynamic> decodedJsonObject = jsonDecode(responseBody!);

      if (kDebugMode) {
        print("Header: " + auth);
        print("data object: " + data.toString());
        print("CNIC used: " + strCNIC);
        print("Response: " + responseBody);
      }

      if (decodedJsonObject["statusCode"] == "200") {
        if (kDebugMode) {
          print("Succeeded uploading profile image: $responseBody");
        }
      } else {}
    } catch (e) {
      if (kDebugMode) {
        print("Error occured while uploading profile image: $e");
      }
    }
    return false;
  }

  Future<bool> downloadAvatarFromServer() async {
    var data = {"CNIC": strCNIC};

    String auth = "Bearer $strToken";

    try {
      final responseBody = await NetworkHelper.downloadProfileImage(data, auth);

      Map<String, dynamic> decodedJsonObject = jsonDecode(responseBody!);

      if (kDebugMode) {
        print("Header: " + auth);
        print("data object: " + data.toString());
        print("CNIC used: " + strCNIC);
        print("Response: " + responseBody);
      }

      if (decodedJsonObject["statusCode"] == "200") {
        if (kDebugMode) {
          print("Succeeded downloading profile image: $responseBody");
        }
      } else {}
    } catch (e) {
      if (kDebugMode) {
        print("Error occured while downloading profile image: $e");
      }
    }
    return false;
  }
}
