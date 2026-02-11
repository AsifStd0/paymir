// ignore_for_file: no_logic_in_create_state, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../util/AlertDialogueClass.dart';
import '../util/Constants.dart';
import 'OneLinkPaymentPageNew.dart';
import 'easypaisa/EasyPaisaPaymentPageNew.dart';
import 'jazzcash/JazzCashPaymentPageNew.dart';

class SearchPageNew extends StatefulWidget {
  final Map<String, dynamic> values;
  final List<dynamic> serviceCharges;

  const SearchPageNew(this.values, this.serviceCharges, {super.key});

  @override
  _SearchPageNewState createState() =>
      _SearchPageNewState(values, serviceCharges);
}

class _SearchPageNewState extends State<SearchPageNew> {
  Map<String, dynamic> values;
  List<dynamic> serviceCharges;

  _SearchPageNewState(this.values, this.serviceCharges);

  final List<String> items = ["JazzCash", "EasyPaisa", "Raast", "1Link"];
  final List<String> logos = [
    'assets/images/jazzcashlogo.png',
    'assets/images/easypaisalogo.png',
    'assets/images/raastlogo.png',
    'assets/images/onelinklogo.jfif',
  ];
  List<String> filteredItems = [];
  List<String> filteredLogos = [];

  @override
  void initState() {
    super.initState();
    filteredItems = items;
    filteredLogos = logos;
  }

  void filterList(String query) {
    setState(() {
      filteredItems =
          items
              .where(
                (element) =>
                    element.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
      filteredLogos =
          logos
              .where(
                (element) => items[logos.indexOf(element)]
                    .toLowerCase()
                    .contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
            ),
            child: Column(
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
                        onPressed:
                            () => {
                              Navigator.pop(context),
                            }, //Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 0.0,
                    bottom: 8.0,
                    left: 8.0,
                    right: 8.0,
                  ),

                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      onChanged: (value) => filterList(value),
                      decoration: InputDecoration(
                        hintText: 'Search payment options',
                        hintStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          color: const Color(0xff929BA1),
                          fontFamily: 'Metropolis',
                          fontWeight: FontWeight.w500,
                        ),
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * 0.02,
                          ),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.01,
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * 0.05,
                          ),
                        ),
                        child: ListTile(
                          leading: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: Image.asset(filteredLogos[index]),
                          ),
                          title: Text(
                            filteredItems[index],
                            style: const TextStyle(
                              fontFamily: 'Metropolis',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded),
                          onTap: () {
                            if (index == 0) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => JazzCashPaymentPageNew(
                                        values,
                                        serviceCharges,
                                      ),
                                ),
                              );
                            } else if (index == 1) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => EasyPaisaPaymentPageNew(
                                        values,
                                        serviceCharges,
                                      ),
                                ),
                              );
                            } else if (index == 2) {
                              ShowAlertDialogueClass.showAlertDialogue(
                                context: context,
                                title: "Coming soon!",
                                message:
                                    "InshaAllah, will be implemented soon!",
                                buttonText: "Okay!",
                                iconData: Icons.error,
                              );
                            } else if (index == 3) {
                              // ShowAlertDialogueClass.showAlertDialogue(context: context, title: "Coming soon!", message:"InshaAllah, will be implemented soon!", buttonText: "Okay!", iconData: Icons.error);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => OneLinkPaymentPageNew(
                                        values,
                                        serviceCharges,
                                      ),
                                ),
                              );
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
