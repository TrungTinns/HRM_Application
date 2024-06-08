import 'package:flutter/material.dart';
import 'package:hrm_application/widgets/colors.dart';
import 'package:google_fonts/google_fonts.dart';

Widget serviceButton(BuildContext context, IconData icon, String label, Widget page) {
  return SizedBox(
    width: 100.0, 
    height: 100.0, 
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
              );
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: secondaryColor, 
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0), 
              ),
            ),
            child: Center(child: Icon(icon, size: 50)), 
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: textColor), 
        ),
      ],
    ),
  );
}