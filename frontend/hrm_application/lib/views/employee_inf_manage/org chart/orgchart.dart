import 'package:flutter/material.dart';
import 'package:hrm_application/components/appbar/custom_title_appbar.dart';
import 'package:hrm_application/components/configuration/configurtion.dart';
import 'package:hrm_application/components/filter_search/filter_search.dart';
import 'package:hrm_application/components/search/searchBox.dart';
import 'package:hrm_application/views/employee_inf_manage/contract/contracts.dart';
import 'package:hrm_application/views/employee_inf_manage/department/department.dart';
import 'package:hrm_application/views/employee_inf_manage/employee/employees.dart';
import 'package:hrm_application/views/employee_inf_manage/employee/employees_inf.dart';
import 'package:hrm_application/views/employee_inf_manage/employee/form/employee_form.dart';
import 'package:hrm_application/views/home/home.dart';
import 'package:hrm_application/widgets/colors.dart';
import 'package:org_chart/org_chart.dart';

class OrgChartManage extends StatefulWidget {
  @override
  _OrgChartState createState() => _OrgChartState();
}

class _OrgChartState extends State<OrgChartManage> {  
  String pageName = 'Org Chart';
  bool showEmployeeForm = false;
  // bool showEmployeeDetail = false; //Show EmployeeDetail
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
              title: const Text('Incomplete Form'),
              content: const Text('Information is missing.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        setState(() {
          nameController.clear();
        });
      }
    } else {
      setState(() {
        showEmployeeForm = true;
      });
    }
  }

  void clearEmployeeForm() {
    setState(() {
      showEmployeeForm = false;
    });
  }

  void deleteEmployee(String name) {
    setState(() {
      employees.removeWhere((employee) => employee.name == name );
    });
  }

  final OrgChartController<Map> orgChartController = OrgChartController<Map>(
    boxSize: const Size(200, 150),
    items: [
      {"title": 'CEO', "id": '1', "to": null},
      {
        "title": 'HR Manager: John',
        "id": '2',
        "to": '1',
      },
      {
        "title": 'HR Officer: Jane',
        "id": '3',
        "to": '2',
      },
      {
        "title": 'Project Manager: Zuher',
        "id": '4',
        "to": '1',
      },
    ],
    idProvider: (data) => data["id"],
    toProvider: (data) => data["to"],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomTitleAppbar(
          ctx: context,
          service: 'Employees',
          titles: const ['Employees', 'Reporting'],
          options: const [
            ['Employees', 'Department', 'Contracts', 'Org Chart'],
            ['Contracts', 'Skills']
          ],
          optionNavigations: [
            [
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => EmployeeManage())),
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Department())),
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Contracts())),
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => OrgChartManage())),
            ],
            [
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
            ],
          ],
          activeDropdowns: const ['Employees', 'Reporting'],
          setActiveDropdown: (dropdown) {
            setState(() {
              activeDropdown = dropdown;
            });
          },
          config: configuration(
            isActive: activeDropdown == 'Configuration',
            onOpen: () => setActiveDropdown('Configuration'),
            onClose: () => setActiveDropdown(null),
            titles: const ['Setting', 'Employee', 'Recruitment'],
            options: const [
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
          preferredSize: const Size.fromHeight(50),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    toggleEmployeeForm();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: textColor,
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text('New', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      pageName,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    IconButton(
                      icon: const Icon(Icons.upload),
                      color: Colors.white,
                      onPressed: () {},
                      tooltip: "Import records",
                    ),
                    if (showEmployeeForm)
                      IconButton(
                        icon: const Icon(Icons.clear),
                        color: Colors.white,
                        iconSize: 24,
                        tooltip: "Discard all changes",
                        onPressed: () {
                          clearEmployeeForm();
                        },
                    ),
                  ],
                ),
              ),
              const Spacer(),
              if (!showEmployeeForm)
                searchBoxWithFilterTable(context, 'Search...', filter(
                  titles: const ['Filter', 'Group By', 'Favorites'],
                  icons: const [Icons.filter_alt, Icons.groups, Icons.star_rounded],
                  iconColors: const [primaryColor, Colors.greenAccent, Colors.yellow],
                  options: const [
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
                  ],)
                ),
              const Spacer(),
            ],
          ),
        ),
        backgroundColor: snackBarColor,
      ),
      body: showEmployeeForm
      // &!showEmployeeDetail
          ? EmployeeForm()
          : Stack(
              children: [
                Container(
                  child: Scaffold(
                    backgroundColor: snackBarColor,
                    body: Stack(
                      children: [
                        Center(
                          child: OrgChart(
                            linePaint: Paint()
                              ..color = Colors.white
                              ..strokeWidth = 5
                              ..style = PaintingStyle.stroke,
                            controller: orgChartController,
                            curve: Curves.linear, 
                            duration: 500, 
                            isDraggable: true, 
                            builder: (details) {
                                      return Card(
                                        color: details.beingDragged
                                            ? Colors.blue
                                            : details.isOverlapped
                                                ? Colors.green
                                                : snackBarColor,
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children:[
                                              const SizedBox(height: 5,),
                                              CircleAvatar(
                                                radius: 20,
                                                backgroundColor: primaryColor,
                                                child: Text(
                                                  details.item["title"].isNotEmpty ? details.item["title"][0].toUpperCase() : '',
                                                  style: const TextStyle(color: Colors.white, fontSize: 20),
                                                ),
                                              ),
                                              Text(details.item["title"], style: const TextStyle(color: textColor),),
                                              const SizedBox(height: 10,),
                                              GestureDetector(
                                                onTap: () {
                                                  details.hideNodes(!details.nodesHidden);
                                                },
                                                child: Container(  
                                                  padding: const EdgeInsets.all(8.0),
                                                  color: authThemeColor,
                                                  child: const Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        Icons.arrow_right_outlined,
                                                        color: textColor,
                                                      ),
                                                      Text(
                                                        "Show/Hide Nodes",
                                                        style: TextStyle(color: textColor),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  optionsBuilder: (item) {
                                      return [
                                        const PopupMenuItem(value: 'promote', child: Text('Promote')),
                                        const PopupMenuItem(
                                            value: 'vacate', child: Text('Vacate Position')),
                                        const PopupMenuItem(value: 'Remove', child: Text('Remove')),
                                      ];
                                    },
                                    onOptionSelect: (item, value) {
                                      if (value == 'Remove') {
                                        orgChartController.removeItem(item["id"]);
                                        setState(() {});
                                      }
                                    },
                                    
                          ),
                        ),
                      ],
                    ),
                    floatingActionButton: FloatingActionButton.extended(
                        label: const Text('Change Orientation'),
                        onPressed: () async {
                          orgChartController.orientation =
                              orgChartController.orientation ==
                                      OrgChartOrientation.leftToRight
                                  ? OrgChartOrientation.topToBottom
                                  : OrgChartOrientation.leftToRight;
                          orgChartController.calculatePosition();
                          setState(() {});
                        }),
                  ),
                ),
              ],
            )
    );
  }
}
