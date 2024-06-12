import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrm_application/components/appbar/custom_title_appbar.dart';
import 'package:hrm_application/components/configuration/configurtion.dart';
import 'package:hrm_application/components/employee/detail/employee_card.dart';
import 'package:hrm_application/components/filter_search/filter_search.dart';
import 'package:hrm_application/components/search/searchBox.dart';
import 'package:hrm_application/views/create/employees/employee_form.dart';
import 'package:hrm_application/views/employee_inf_manage/contracts.dart';
import 'package:hrm_application/views/employee_inf_manage/org_chart.dart';
import 'package:hrm_application/views/home/home.dart';
import 'package:hrm_application/widgets/colors.dart';

class EmployeeManage extends StatefulWidget {
  @override
  _EmployeeManageState createState() => _EmployeeManageState();
}

class _EmployeeManageState extends State<EmployeeManage> {
  String pageName = 'Employees';
  bool _isHovered = false;
  bool _isSidebarOpen = true;
  bool showEmployeeForm = false;
  String? activeDropdown;
  final TextEditingController nameController = TextEditingController();

  void setActiveDropdown(String? dropdown) {
    setState(() {
      activeDropdown = dropdown;
    });
  }

  void toggleEmployeeForm() {
    if (showEmployeeForm) {

      if (nameController.text.isEmpty) {

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Incomplete Form'),
              content: Text('Please fill out the name field before proceeding.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {

        setState(() {
          showEmployeeForm = false;
          nameController.clear();
        });
      }
    } else {
      setState(() {
        showEmployeeForm = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomTitleAppbar(
          ctx: context,
          service: pageName,
          titles: ['Employees', 'Reporting'],
          options: [
            ['Employees', 'Department', 'Org chart', 'Contracts'],
            ['Contracts', 'Skills']
          ],
          optionNavigations: [
            [
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => EmployeeManage())),
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => OrgChart())),
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Contracts())),
            ],
            [
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
            ],
          ],
          activeDropdowns: ['Employees', 'Reporting'],
          setActiveDropdown: (dropdown) {
            setState(() {
              activeDropdown = dropdown;
            });
          },
          config: configuration(
            isActive: activeDropdown == 'Configuration',
            onOpen: () => setActiveDropdown('Configuration'),
            onClose: () => setActiveDropdown(null),
            titles: ['Setting', 'Employee', 'Recruitment'],
            options: [
              ['Setting', 'Activity Plan'],
              ['Departments', 'Work Locations', 'Working Schedules', 'Departure Reasons', 'Skill Types'],
              ['Job Positions', 'Employment Types']
            ],
            navigators: [
              [
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
              ],
              [
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
              ],
              [
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
              ],
            ],
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    toggleEmployeeForm();
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
                    IconButton(
                      icon: Icon(Icons.upload),
                      color: Colors.white,
                      onPressed: () {},
                      tooltip: "Import records",
                    ),
                  ],
                ),
              ),
              Spacer(),
              if (!showEmployeeForm)
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
                )
              ),
              if (showEmployeeForm)
                IconButton(
                  icon: Icon(Icons.person),
                  color: Colors.white,
                  iconSize: 30,
                  onPressed: () {
                    // Perform an action
                  },
                ),
              Spacer(),
            ],
          ),
        ),
        backgroundColor: snackBarColor,
      ),
      body: showEmployeeForm
          ? EmployeeForm()
          : Row(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: _isSidebarOpen ? 250 : 25,
                  child: Material(
                    color: snackBarColor,
                    elevation: 4.0,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: _isSidebarOpen? <Widget>[
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 20,),
                          Icon(Icons.groups, color: secondaryColor, size: 20,),
                          Text(' DEPARTMENT', style: TextStyle(fontSize: 16, color: textColor, fontWeight: FontWeight.bold),),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isSidebarOpen = !_isSidebarOpen;
                              });
                            },
                            child: Container(
                              child: Icon(
                                Icons.keyboard_double_arrow_left ,
                                size: 20,
                                color: Colors.white,
                              ),
                            )
                          ),
                          SizedBox(width: 10,),
                        ]
                        
                      ),
                        ListTile(
                          title: Text(
                            'All',
                            style: TextStyle(color: textColor),),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: Text(
                            'Department',
                            style: TextStyle(color: textColor),),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ]
                    : [SizedBox(height: 30,),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isSidebarOpen = !_isSidebarOpen;
                          });
                        },
                        child: Container(
                          child: Icon(
                            Icons.keyboard_double_arrow_right,
                            size: 20,
                            color: Colors.white,
                          ),
                        )
                      ),
                    ],
              ),
            ),
          ),
          
          Expanded(
            child:               
              GridView.builder(
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, 
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 10, 
                itemBuilder: (context, index) {
                  return EmployeeCard(
                    name: 'Employee ${index + 1}',
                    role: 'Role ${index + 1}',
                    email: 'email${index + 1}@example.com',
                  );
                },
              ),
          ),
        ],
      ),
    );
  }
}
