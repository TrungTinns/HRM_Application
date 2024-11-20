import 'package:flutter/material.dart';
import 'package:hrm_application/core/utils/theme/colors.dart';

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
