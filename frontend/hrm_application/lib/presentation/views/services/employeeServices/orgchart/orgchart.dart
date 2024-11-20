import 'package:flutter/material.dart';

import 'package:hrm_application/core/utils/theme/colors.dart';
import 'package:hrm_application/presentation/views/services/employeeServices/department/department.dart';
import 'package:hrm_application/presentation/views/services/employeeServices/Employee/Data/employees_data.dart';
import 'package:hrm_application/presentation/views/services/employeeServices/Employee/Detail/employee_detail.dart';
import 'package:hrm_application/presentation/views/services/employeeServices/Employee/Form/employee_form.dart';
import 'package:hrm_application/presentation/views/services/employeeServices/Employee/employees.dart';
import 'package:hrm_application/presentation/widgets/appbar/custom_title_appbar.dart';
import 'package:hrm_application/presentation/widgets/filterSearch/filter_search.dart';
import 'package:hrm_application/presentation/widgets/search/searchBox.dart';
import 'package:org_chart/org_chart.dart';

class OrgChartManage extends StatefulWidget {
  @override
  _OrgChartState createState() => _OrgChartState();
}

class _OrgChartState extends State<OrgChartManage> {
  String pageName = 'Org Chart';
  bool showEmployeeForm = false;
  String? activeDropdown;
  final TextEditingController nameController = TextEditingController();
  List<EmployeeData> employees = [];

  late OrgChartController<EmployeeData> orgChartController;

  @override
  void initState() {
    super.initState();
    fetchAndSetEmployees();
  }

  Future<void> fetchAndSetEmployees() async {
    try {
      List<EmployeeData> fetchedEmployees = await fetchEmployees();
      setState(() {
        employees = fetchedEmployees;
        orgChartController = OrgChartController<EmployeeData>(
          boxSize: const Size(300, 200),
          items: employees,
          idProvider: (employee) => employee.id,
          toProvider: (employee) =>
              employee.managerId == employee.id ? null : employee.managerId,
        );
      });
    } catch (e) {
      print('Error fetching employees: $e');
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomTitleAppbar(
          ctx: context,
          service: 'Employees',
          titles: const ['Employees', 'Department'],
          options: const [
            ['Employees', 'Contracts', 'Org Chart'],
            ['Department', 'Position']
          ],
          optionNavigations: [
            [
              () => Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => EmployeeManage())),
              () => Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => EmployeeManage())),
              // () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Contracts())),
              () => Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => OrgChartManage())),
            ],
            [
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Department())),
              () => Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => EmployeeManage())),
              // () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => PositionManage())),
            ],
          ],
          activeDropdowns: const ['Employees', 'Reporting'],
          setActiveDropdown: (dropdown) {
            setState(() {
              activeDropdown = dropdown;
            });
          },
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
                  child: const Text('New',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
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
                searchBoxWithFilterTable(
                    context,
                    'Search...',
                    filter(
                      titles: const ['Filter', 'Group By', 'Favorites'],
                      icons: const [
                        Icons.filter_alt,
                        Icons.groups,
                        Icons.star_rounded
                      ],
                      iconColors: const [
                        primaryColor,
                        Colors.greenAccent,
                        Colors.yellow
                      ],
                      options: const [
                        ['My Team', 'My Department', 'Newly Hired', 'Achieved'],
                        [
                          'Manager',
                          'Department',
                          'Job',
                          'Skill',
                          'Start Date',
                          'Tags'
                        ],
                        ['Save Current Search']
                      ],
                      navigators: [
                        [
                          () => Navigator.pushNamed(context, '/my_team'),
                          () => Navigator.pushNamed(context, '/my_department'),
                          () => Navigator.pushNamed(context, '/newly_hired'),
                          () => Navigator.pushNamed(context, '/achieved')
                        ],
                        [
                          () => Navigator.pushNamed(context, '/manager'),
                          () => Navigator.pushNamed(context, '/department'),
                          () => Navigator.pushNamed(context, '/job'),
                          () => Navigator.pushNamed(context, '/skill'),
                          () => Navigator.pushNamed(context, '/start_date'),
                          () => Navigator.pushNamed(context, '/tags')
                        ],
                        [() => print('Save Current Search')],
                      ],
                    )),
              const Spacer(),
            ],
          ),
        ),
        backgroundColor: snackBarColor,
      ),
      body: showEmployeeForm
          ? EmployeeForm()
          : Stack(
              children: [
                Container(
                  child: Scaffold(
                    backgroundColor: snackBarColor,
                    body: employees.isEmpty
                        ? Center(child: CircularProgressIndicator())
                        : OrgChart(
                            linePaint: Paint()
                              ..color = Colors.white
                              ..strokeWidth = 5
                              ..style = PaintingStyle.stroke,
                            controller: orgChartController,
                            curve: Curves.linear,
                            duration: 500,
                            isDraggable: true,
                            builder: (details) {
                              EmployeeData employee = details.item;
                              return GestureDetector(
                                onTap: () {
                                  details.hideNodes(!details.nodesHidden);
                                },
                                onDoubleTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EmployeeDetail(
                                        id: employee.id,
                                        name: employee.name,
                                        role: employee.role,
                                        mail: employee.mail,
                                        mobile: employee.mobile,
                                        department: employee.department,
                                        managerId: employee.managerId ?? '',
                                        isManager: employee.isManager ?? false,
                                        workLocation: employee.workLocation,
                                        schedule:
                                            employee.contract?.schedule ?? '',
                                        salaryStructure: employee
                                                .contract?.salaryStructure ??
                                            '',
                                        contractType:
                                            employee.contract?.contractType ??
                                                '',
                                        cost: employee.contract?.cost ?? 0.0,
                                        personalAddress:
                                            employee.personalAddress,
                                        personalMail: employee.personalMail,
                                        personalMobile: employee.personalMobile,
                                        relativeName:
                                            employee.relativeName ?? '',
                                        relativeMobile:
                                            employee.relativeMobile ?? '',
                                        certification:
                                            employee.certification ?? '',
                                        school: employee.school ?? '',
                                        maritalStatus:
                                            employee.maritalStatus ?? '',
                                        child: employee.child ?? 0,
                                        nationality: employee.nationality ?? '',
                                        idNum: employee.idNum ?? '',
                                        ssNum: employee.ssNum ?? '',
                                        passport: employee.passport ?? '',
                                        sex: employee.sex ?? '',
                                        birthDate:
                                            employee.birthDate?.toString() ??
                                                '',
                                        birthPlace: employee.birthPlace ?? '',
                                        idContract: employee.contract?.id ?? '',
                                      ),
                                    ),
                                  ).then((_) {
                                    fetchAndSetEmployees(); // Refresh employees list after returning
                                  });
                                },
                                child: Card(
                                  color: details.beingDragged
                                      ? Colors.blue
                                      : details.isOverlapped
                                          ? Colors.green
                                          : snackBarColor,
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0)),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundColor: primaryColor,
                                          child: Text(
                                            employee.name[0].toUpperCase(),
                                            style: const TextStyle(
                                                color: textColor, fontSize: 20),
                                          ),
                                        ),
                                        Text(
                                          employee.name,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: textColor),
                                        ),
                                        Text(
                                          employee.role,
                                          style: const TextStyle(
                                              fontSize: 18, color: textColor),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(8.0),
                                          color: authThemeColor,
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.arrow_right_outlined,
                                                color: textColor,
                                              ),
                                              Text(
                                                "Show/Hide Nodes",
                                                style:
                                                    TextStyle(color: textColor),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                )
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
          label: const Text('Change Orientation'),
          onPressed: () async {
            orgChartController.orientation = orgChartController.orientation ==
                    OrgChartOrientation.leftToRight
                ? OrgChartOrientation.topToBottom
                : OrgChartOrientation.leftToRight;
            orgChartController.calculatePosition();
            setState(() {});
          }),
    );
  }
}
