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
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0), 
              ),
            ),
            child: Center(child: Icon(icon, size: 50)), 
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: textColor), 
        ),
      ],
    ),
  );
}

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

Widget seachIcon(BuildContext context, String hintText){
  return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
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

