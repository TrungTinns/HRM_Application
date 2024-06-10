import 'package:flutter/material.dart' hide VoidCallback;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:hrm_application/widgets/colors.dart';
import 'package:google_fonts/google_fonts.dart';

Widget appIcon(BuildContext context) {
  return RichText(
    text: TextSpan(
      children: <TextSpan>[
        TextSpan(
          text: 'HRM ',
          style: GoogleFonts.rockSalt(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: secondaryColor,
          ),
        ),
        TextSpan(
          text: 'app',
          style: GoogleFonts.dancingScript(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 107, 188, 255),
          ),
        ),
      ],
    ),
  );
}

Widget searchBoxWithFilterTable(BuildContext context, String hintText, Widget filter) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Stack(
      children: [
        Container(
          height: 40.0,
          width: 500.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: termTextColor),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  style: TextStyle(color: textColor, fontSize: 16.0),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(color: termTextColor),
                    prefixIcon: Icon(Icons.search, color: textColor),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          child: Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: termTextColor,
            ),
            child: filter,
          ),
        ),
      ],
    ),
  );
}

Widget searchBox(BuildContext context, String hintText) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 40.0,
      width: 500.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: termTextColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14.0),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

AppBar customAppBar(BuildContext context) {
  return AppBar(
    title: appIcon(context),
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black87),
    centerTitle: true,
    elevation: 0.0,
  );
}

Widget customButton(BuildContext context, {IconData? icon, required Widget navigateTo, required String text}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => navigateTo),
      );
    },
    child: Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
            color: textColor,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: textColor,
            ),
          ),
        ],
      ),
    ),
  );
}


