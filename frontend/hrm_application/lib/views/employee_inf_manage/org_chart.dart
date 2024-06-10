import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrm_application/components/employee/appbar/custom_title_appbar.dart';
import 'package:hrm_application/components/employee/configuration/emp_configurtion.dart';
import 'package:hrm_application/components/employee/filter_search/org_chart_filter.dart';
import 'package:hrm_application/views/employee_inf_manage/contracts.dart';
import 'package:hrm_application/views/employee_inf_manage/employees.dart';
import 'package:hrm_application/views/home/home.dart';
import 'package:hrm_application/widgets/colors.dart';
import 'package:hrm_application/widgets/widget.dart';

class OrgChart extends StatefulWidget {
  @override
  _OrgChartState createState() => _OrgChartState();
}

class _OrgChartState extends State<OrgChart> {
  String pageName = 'Org chart';
  bool _isHovered = false;
  bool _isSidebarOpen = true;

  String? activeDropdown;

  void setActiveDropdown(String? dropdown) {
    setState(() {
      activeDropdown = dropdown;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: textColor,
              iconSize: 25,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
              },
            ),
            Text('Employees', style: GoogleFonts.philosopher(fontSize: 25,color: secondaryColor, fontWeight: FontWeight.bold,)),
            SizedBox(width: 10,),
            Spacer(),
            IconButton(
              icon: Icon(Icons.wechat),
              color: textColor,
              iconSize: 30,
              onPressed: () {
              
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              color: textColor,
              iconSize: 30,
              onPressed: () {
              
              },
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    
                  },
                  child: Text('New', style: TextStyle(color: Colors.white, fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, 
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5), 
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      pageName,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Spacer(),
              searchBoxWithFilterTable(context, 'Search...', filterOrgChart()),
              Spacer(),
            ],
          ),
        ),
        backgroundColor: snackBarColor,
      ),
      body: Row(
      ),
    );
  }
}
