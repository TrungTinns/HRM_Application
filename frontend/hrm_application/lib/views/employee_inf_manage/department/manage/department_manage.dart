import 'package:flutter/material.dart';
import 'package:hrm_application/components/appbar/custom_title_appbar.dart';
import 'package:hrm_application/components/configuration/configurtion.dart';
import 'package:hrm_application/components/filter_search/filter_search.dart';
import 'package:hrm_application/components/search/searchBox.dart';
import 'package:hrm_application/views/employee_inf_manage/contract/contracts.dart';
import 'package:hrm_application/views/employee_inf_manage/department/department.dart';
import 'package:hrm_application/views/employee_inf_manage/department/department_inf.dart';
import 'package:hrm_application/views/employee_inf_manage/employee/card/employee_card.dart';
import 'package:hrm_application/views/employee_inf_manage/employee/employees.dart';
import 'package:hrm_application/views/employee_inf_manage/employee/employees_inf.dart';
import 'package:hrm_application/views/employee_inf_manage/employee/form/employee_form.dart';
import 'package:hrm_application/views/employee_inf_manage/org%20chart/orgchart.dart';
import 'package:hrm_application/views/home/home.dart';
import 'package:hrm_application/widgets/colors.dart';

class EmployeeofDepartment extends StatefulWidget {
  final String? initialDepartment; // Nhận giá trị department

  EmployeeofDepartment({this.initialDepartment});

  @override
  _EmployeeofDepartmentState createState() => _EmployeeofDepartmentState();
}

class _EmployeeofDepartmentState extends State<EmployeeofDepartment> {
  String pageName = 'Department';
  TextEditingController departmentController = TextEditingController();
  String? activeDropdown;
  bool showDepartmentForm = false;
  bool _isSidebarOpen = true;
  bool showAllEmployees = true; 
  String? selectedDepartment; 

  @override
  void initState() {
    super.initState();
    selectedDepartment = widget.initialDepartment;
    showAllEmployees = selectedDepartment == null;
  }

  void setActiveDropdown(String? dropdown) {
    setState(() {
      activeDropdown = dropdown;
    });
  }

  void toggleDepartmentForm() {
    if (showDepartmentForm) {
      if (departmentController.text.isEmpty) {
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
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        setState(() {
          departmentController.clear();
        });
      }
    } else {
      setState(() {
        showDepartmentForm = true;
      });
    }
  }

  void clearDepartmentForm() {
    setState(() {
      showDepartmentForm = false;
    });
  }

  void deleteDepartment(String department) {
    setState(() {
      departments.removeWhere((d) => d.department == department);
    });
  }

  void deleteEmployee(String name) {
    setState(() {
      employees.removeWhere((employee) => employee.name == name);
    });
  }

  void handleUpdate(EmployeeInf updatedEmployee) {
    setState(() {
      final index = employees.indexWhere((emp) => emp.name == updatedEmployee.name);
      if (index != -1) {
        employees[index] = updatedEmployee;
      }
    });
  }

  List<EmployeeInf> get departmentEmployees {
    if (showAllEmployees) {
      return employees;
    } else if (selectedDepartment != null) {
      return employees.where((emp) => emp.department == selectedDepartment).toList();
    } else {
      return [];
    }
  }

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
          setActiveDropdown: (dropdown) {},
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
                    toggleDepartmentForm();
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
                    if (showDepartmentForm)
                      IconButton(
                        icon: const Icon(Icons.clear),
                        color: Colors.white,
                        iconSize: 24,
                        tooltip: "Discard all changes",
                        onPressed: () {
                          clearDepartmentForm();
                        },
                      ),
                  ],
                ),
              ),
              const Spacer(),
              if (!showDepartmentForm)
                searchBoxWithFilterTable(
                  context,
                  'Search...',
                  filter(
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
                  ),
                ),
              const Spacer(),
            ],
          ),
        ),
        backgroundColor: snackBarColor,
      ),
      body: showDepartmentForm
          ? EmployeeForm()
          : Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: _isSidebarOpen ? 250 : 25,
                  child: Material(
                    color: snackBarColor,
                    elevation: 4.0,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: _isSidebarOpen
                          ? <Widget>[
                              const SizedBox(height: 30,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(width: 20,),
                                  const Icon(Icons.groups, color: secondaryColor, size: 20,),
                                  const Text(
                                    ' DEPARTMENT',
                                    style: TextStyle(fontSize: 16, color: textColor, fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isSidebarOpen = !_isSidebarOpen;
                                      });
                                    },
                                    child: const Icon(
                                      Icons.keyboard_double_arrow_left,
                                      size: 20,
                                      color: Colors.white,
                                    )
                                  ),
                                  const SizedBox(width: 10,),
                                ],
                              ),
                              const SizedBox(height: 20,),
                              ListTile(
                                title: const Text(
                                  'All',
                                  style: TextStyle(color: textColor),
                                ),
                                onTap: () {
                                  setState(() {
                                    showAllEmployees = true; 
                                    selectedDepartment = null;
                                  });
                                },
                              ),
                              ...departments.map((department) => ListTile(
                                    title: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              department.department,
                                              style: const TextStyle(color: textColor, fontSize: 16)
                                            ),
                                            
                                            Text(
                                              '${countEmployeesInDepartment(employees, department.department)}',
                                              style: const TextStyle(
                                                color: termTextColor,
                                                fontSize: 16,)
                                              ),
                                          ],
                                        ),
                                    onTap: () {
                                      setState(() {
                                        showAllEmployees = false;
                                        selectedDepartment = department.department;
                                      });
                                    },
                                  )).toList(),
                            ]
                          : [
                              const SizedBox(height: 30,),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isSidebarOpen = !_isSidebarOpen;
                                  });
                                },
                                child: const Icon(
                                  Icons.keyboard_double_arrow_right,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                    ),
                  ),
                ),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount = (_isSidebarOpen) ? 3 : 4;
                      return GridView.builder(
                        padding: const EdgeInsets.all(10),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 2.4,
                        ),
                        itemCount: departmentEmployees.length,
                        itemBuilder: (context, index) {
                          final employee = departmentEmployees[index];
                          return EmployeeCard(
                            name: employee.name,
                            role: employee.role,
                            mail: employee.mail,
                            mobile: employee.mobile,
                            department: employee.department,
                            manager: employee.manager,
                            onDelete: () => deleteEmployee(employee.name),
                            isManager: employee.isManager,
                            onUpdate: handleUpdate,
                            workLocation: employee.workLocation ?? '',
                            schedule: employee.schedule ?? '',
                            salaryStructure: employee.salaryStructure ?? '',
                            contractType: employee.contractType ?? '',
                            cost: double.tryParse(employee.cost.toString()) ?? 0.0,
                            personalAddress: employee.personalAddress ?? '',
                            personalMail: employee.personalMail ?? '',
                            personalMobile: employee.personalMobile ?? '',
                            relativeName: employee.relativeName ?? '',
                            relativeMobile: employee.relativeMobile ?? '',
                            certification: employee.certification ?? '',
                            school: employee.school ?? '',
                            maritalStatus: employee.maritalStatus ?? '',
                            child: int.tryParse(employee.child.toString()) ?? 0,
                            nationality: employee.nationality ?? '',
                            idNum: employee.idNum ?? '',
                            ssNum: employee.ssNum ?? '',
                            passport: employee.passport ?? '',
                            sex: employee.sex ?? '',
                            birthDate: employee.birthDate ?? '',
                            birthPlace: employee.birthPlace ?? '',
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
