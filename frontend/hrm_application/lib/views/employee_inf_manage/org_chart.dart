import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrm_application/components/filter_search/filter_search.dart';
import 'package:hrm_application/components/search/searchBox.dart';
import 'package:hrm_application/views/employee_inf_manage/contracts.dart';
import 'package:hrm_application/views/employee_inf_manage/employees.dart';
import 'package:hrm_application/views/home/home.dart';
import 'package:hrm_application/widgets/colors.dart';

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
              searchBoxWithFilterTable(context, 'Search...', filter(
                  titles: ['Filter', 'Group By', 'Favorites'],
                  icons: [Icons.filter_alt, Icons.groups, Icons.star_rounded],
                  iconColors: [primaryColor, Colors.greenAccent, Colors.yellow],
                  options: [
                    ['My Team', 'My Department', 'Newly Hired', 'Achieved'],
                    ['Manager', 'Department', 'Job', 'Skill', 'Start Date', 'Tags'],
                    ['Save Current Search']
                  ],
                  navigators: [
                    [
                      () => Navigator.pushNamed(context, '/my_team'), 
                      () => Navigator.pushNamed(context, '/my_department'), 
                      () => Navigator.pushNamed(context, '/newly_hired'), 
                      () => Navigator.pushNamed(context, '/achieved')],
                    [
                      () => Navigator.pushNamed(context, '/manager'), 
                      () => Navigator.pushNamed(context, '/department'), 
                      () => Navigator.pushNamed(context, '/job'), 
                      () => Navigator.pushNamed(context, '/skill'), 
                      () => Navigator.pushNamed(context, '/start_date'), 
                      () => Navigator.pushNamed(context, '/tags')],
                    [() => print('Save Current Search')],
                  ],
                )),
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
