import 'package:flutter/material.dart';

import 'CFCVoucherNoPageNew.dart';


class CFCPageNew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CFC Services',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  // List of texts
  final List<String> texts = [
    'Birth Certificate',
    'Death Certificate',
    'Marriage Certificate',
    'Divorce Certificate',
    'Water Connection and Billing',
    'Building Plan Approval',
    'E-Property Transfer',
    'Request for Correction of Land Record (Jamma Bandi)',
    'Request for obtaining attested copies from DK Room',
    'Request for the Land Record and Boundary Identification (Had Barari)',
  ];

  // List of light colors
  final List<Color> lightColors = [
    Colors.blue[50]!,
    Colors.red[50]!,
    Colors.green[50]!,
    Colors.orange[50]!,
    Colors.purple[50]!,
    Colors.amber[50]!,
    Colors.teal[50]!,
    Colors.cyan[50]!,
    Colors.pink[50]!,
    Colors.indigo[50]!,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CFC Services'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0), // Adjust vertical padding
        child: ListView.builder(
          itemCount: texts.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left:5, right: 5, bottom: 6.0),
              child: GestureDetector(
                onTap: () {
                  print(texts[index]);
                  // Navigate to next page
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => NextPage()));
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>CFCVoucherNoPageNew()));

                },
                child: ClickableCard(
                  icon: Icons.add_business_rounded,
                  text: texts[index],
                  color: lightColors[index % lightColors.length],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ClickableCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const ClickableCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4.0,
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 50,
              color: Colors.black87,
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 30,
              color: Colors.black87,
            ),
          ],
        ),
      ),
    );
  }
}
