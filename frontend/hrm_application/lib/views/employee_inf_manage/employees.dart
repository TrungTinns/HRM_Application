import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrm_application/components/employee/employee_card.dart';
import 'package:hrm_application/components/filter_search/employee_filter.dart';
import 'package:hrm_application/views/home/home.dart';
import 'package:hrm_application/widgets/colors.dart';
import 'package:hrm_application/widgets/widget.dart';

class EmployeeManage extends StatefulWidget {
  @override
  _EmployeeManageState createState() => _EmployeeManageState();
}

class _EmployeeManageState extends State<EmployeeManage> {
  final List<String> employeesOptions = ['Employees', 'Org chart', 'Contracts'];
  final List<String> reportingOptions = ['Contracts', 'Skills'];
  final List<String> configurationOptions = ['op1', 'op2', 'op3', 'op4', 'op5', 'op6', 'op7'];

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
        iconTheme: IconThemeData(
          color: textColor,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Employees', style: GoogleFonts.philosopher(color: secondaryColor, fontWeight: FontWeight.bold)),
            SizedBox(width: 10,),
            CustomDropdownButton(
              title: 'Employees',
              options: employeesOptions,
              onSelect: (option) {
                setActiveDropdown('Employees');
                switch (option) {
                  case 'Employees':
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                    break;
                  case 'Org chart':
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                    break;
                  case 'Contracts':
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                    break;
                }
              },
              isActive: activeDropdown == 'Employees',
              onOpen: () => setActiveDropdown('Employees'),
              onClose: () => setActiveDropdown(null),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor: MaterialStateProperty.all(snackBarColor),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
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
            CustomDropdownButton(
              title: 'Configuration',
              options: configurationOptions,
              onSelect: (option) {
                setActiveDropdown('Configuration');
                switch (option) {
                  case 'Employees':
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                    break;
                  case 'Org chart':
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                    break;
                  case 'Contracts':
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                    break;
                }
              },
              isActive: activeDropdown == 'Configuration',
              onOpen: () => setActiveDropdown('Configuration'),
              onClose: () => setActiveDropdown(null),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Center(
            child: searchBoxWithFilterTable(context, 'Search...', filterEmployee()),
          ),
        ),
        backgroundColor: snackBarColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                EmployeeCard(
                  name: 'Huỳnh Trần Minh Tiến',
                  role: 'Dev',
                  email: 'minhtien123@email.com',
                ),
                EmployeeCard(
                  name: 'ngthns',
                  email: 'trungthn03@gmail.com',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

