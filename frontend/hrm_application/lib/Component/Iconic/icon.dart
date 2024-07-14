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
            color: const Color.fromARGB(255, 107, 188, 255),
          ),
        ),
      ],
    ),
  );
}

AppBar customAppBar(BuildContext context) {
  return AppBar(
    title: appIcon(context),
    backgroundColor: Colors.transparent,
    iconTheme: const IconThemeData(color: Colors.black87),
    centerTitle: true,
    elevation: 0.0,
  );
}