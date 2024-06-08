import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrm_application/components/configuration/emp_configurtion.dart';
import 'package:hrm_application/components/employee/employee_card.dart';
import 'package:hrm_application/components/filter_search/employee/contracts_filter.dart';
import 'package:hrm_application/components/filter_search/employee/employee_filter.dart';
import 'package:hrm_application/components/filter_search/employee/org_chart_filter.dart';
import 'package:hrm_application/views/employee_inf_manage/employees.dart';
import 'package:hrm_application/views/employee_inf_manage/org_chart.dart';
import 'package:hrm_application/views/home/home.dart';
import 'package:hrm_application/widgets/colors.dart';
import 'package:hrm_application/widgets/widget.dart';

class Contracts extends StatefulWidget {
  @override
  _ContractsState createState() => _ContractsState();
}

class _ContractsState extends State<Contracts> {
  String pageName = 'Contracts';
  final List<String> employeesOptions = ['Employees', 'Org chart', 'Contracts'];
  final List<String> reportingOptions = ['Contracts', 'Skills'];
  final List<String> configurationOptions = ['op1', 'op2', 'op3', 'op4', 'op5', 'op6', 'op7'];
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
            CustomDropdownButton(
              title: 'Employees',
              options: employeesOptions,
              onSelect: (option) {
                setActiveDropdown('Employees');
                switch (option) {
                  case 'Employees':
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EmployeeManage()));
                    break;
                  case 'Org chart':
                    Navigator.push(context, MaterialPageRoute(builder: (context) => OrgChart()));
                    break;
                  case 'Contracts':
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Contracts()));
                    break;
                }
              },
              isActive: activeDropdown == 'Employees',
              onOpen: () => setActiveDropdown('Employees'),
              onClose: () => setActiveDropdown(null),
            ),
            MouseRegion(
              onEnter: (_) {
                setState(() {
                  _isHovered = true;
                });
              },
              onExit: (_) {
                setState(() {
                  _isHovered = false;
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(_isHovered ? Colors.grey : snackBarColor,),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: () {
                    setActiveDropdown(null);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                  },
                  child: Text('Department', style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
            CustomDropdownButton(
              title: 'Reporting',
              options: reportingOptions,
              onSelect: (option) {
                setActiveDropdown('Reporting');
                switch (option) {
                  case 'Contracts':
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                    break;
                  case 'Skills':
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                    break;
                }
              },
              isActive: activeDropdown == 'Reporting',
              onOpen: () => setActiveDropdown('Reporting'),
              onClose: () => setActiveDropdown(null),
            ),
            empConfiguration(
              isActive: activeDropdown == 'Configuration',
              onOpen: () => setActiveDropdown('Configuration'),
              onClose: () => setActiveDropdown(null),
            ),
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
              searchBoxWithFilterTable(context, 'Search...', filterContracts()),
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
