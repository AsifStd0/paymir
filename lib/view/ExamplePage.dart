// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart'; // for Clipboard

// class ExamplePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'PSID Display',
//       theme: ThemeData(
//         primaryColor: Colors.deepPurple, // Change primary color
//         hintColor: Colors.deepOrange, // Change accent color
//         scaffoldBackgroundColor: Colors.grey[200], // Change background color
//       ),
//       home: PSIDPage(),
//     );
//   }
// }

// class PSIDPage extends StatelessWidget {
//   final List<Map<String, dynamic>> responseData = [
//     {
//       "psid": "10121000101901241",
//       "status": "Paid",
//       "amount": 5.00
//     },
//     {
//       "psid": "10121000101901242",
//       "status": "Unpaid",
//       "amount": 10.00
//     }
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('PSIDs'),
//       ),
//       body: ListView.builder(
//         shrinkWrap: true,
//         physics: NeverScrollableScrollPhysics(),
//         itemCount: responseData.length + 1,
//         itemBuilder: (BuildContext context, int index) {
//           if (index < responseData.length) {
//             return PSIDCard(
//               psidData: responseData[index],
//             );
//           } else {
//             return Container(
//               padding: EdgeInsets.all(10),
//               child: Text(
//                 'Note: Amount can be paid through OneBill',
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.normal,
//                 ),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// class PSIDCard extends StatelessWidget {
//   final Map<String, dynamic> psidData;

//   PSIDCard({required this.psidData});

//   @override
//   Widget build(BuildContext context) {
//     Color statusColor = psidData['status'] == 'Paid' ? Colors.green : Colors.red;

//     return Card(
//       margin: EdgeInsets.all(10),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0), // Rounded edges
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(15), // Added padding
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'PSID: ${psidData['psid']}',
//                   style: TextStyle(
//                     color: Theme.of(context).primaryColor,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//                 Text(
//                   'Status: ',
//                   style: TextStyle(
//                     color: Theme.of(context).hintColor,
//                     fontSize: 14,
//                   ),
//                 ),
//                 Text(
//                   psidData['status'],
//                   style: TextStyle(color: statusColor, fontSize: 14), // Change status text color
//                 ),
//                 Text(
//                   'Amount: PKR ${psidData['amount']}',
//                   style: TextStyle(
//                     color: Colors.blue, // Change amount color
//                     fontSize: 14,
//                   ),
//                 ),
//               ],
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 _copyPSIDToClipboard(context, psidData['psid']);
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Theme.of(context).hintColor, // Button color
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20.0), // Rounded edges
//                 ),
//               ),
//               child: Text('Copy PSID'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _copyPSIDToClipboard(BuildContext context, String psid) {
//     Clipboard.setData(ClipboardData(text: psid));
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('PSID copied to clipboard')),
//     );
//   }
// }
