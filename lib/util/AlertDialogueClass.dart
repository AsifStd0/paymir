import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../view/mobile_page_view/MobileVerificationPageNew.dart';

class ShowAlertDialogueClass {
  static Future<void> showAlertDialogue({
    required BuildContext context,
    required String title,
    required String message,
    required String buttonText,
    required IconData iconData,
  }) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Row(
            children: [
              Text(title),
              const Spacer(),
              Icon(iconData, color: Colors.orange),
            ],
          ),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text(buttonText),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> showAlertDialogSendtoVerificationPage({
    required BuildContext context,
    required String title,
    required String message,
    required String buttonText,
    required Map<String, dynamic> values,
    required iconData,
  }) async {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MobileVerificationPageNew(values: values),
          ),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: Row(
        children: [
          Text(title),
          const Spacer(),
          if (iconData != null) Icon(iconData, color: Colors.green),
        ],
      ),
      content: Text(message),
      actions: [okButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Future<bool> exitAppDialog(BuildContext context) async {
    final result = await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Row(
              children: [
                Text('Are you sure?'),
                Spacer(),
                Icon(Icons.help_outline_rounded, color: Colors.orange),
              ],
            ),
            content: const Text('You want to exit the App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
    );
    if (result == true) {
      SystemNavigator.pop();
    }
    return result ?? false;
  }

  static Future<void> showAlertDialogMobileVerificationPage({
    required BuildContext context,
    required String title,
    required String message,
    required String buttonText,
    required Map<String, dynamic> values,
    required iconData,
  }) async {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MobileVerificationPageNew(values: values),
          ),
        );
      },
    );

    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: Row(
        children: [
          Text(title),
          const Spacer(),
          if (iconData != null) Icon(iconData, color: Colors.green),
        ],
      ),
      content: Text(message),
      actions: [okButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Future<void> showAlertDialogCodeVerificationPage({
    required BuildContext context,
    required String title,
    required String message,
    required String buttonText,
    required Map<String, dynamic> values,
    required iconData,
  }) async {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MobileVerificationPageNew(values: values),
          ),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [okButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
