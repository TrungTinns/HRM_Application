import 'package:flutter/material.dart';
import 'package:hrm_application/Component/Appbar/custom_title_appbar.dart';
import 'package:hrm_application/Component/Configuration/configuration.dart';
import 'package:hrm_application/Component/FilterSearch/filter_search.dart';
import 'package:hrm_application/Component/Search/searchBox.dart';
import 'package:hrm_application/Views/Home/home.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Contract/contracts.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Department/department.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Department/department_inf.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Employee/Card/employee_card.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Employee/Form/employee_form.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Employee/employees_inf.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/OrgChart/orgchart.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Position/position.dart';
import 'package:hrm_application/Widgets/colors.dart';


class EmployeeManage extends StatefulWidget {
  final String? name;
  final String? role;
  final String? department;
  final String? mobile;
  final String? mail;
  final String? certification;

  EmployeeManage({
    this.name,
    this.role,
    this.department,
    this.mobile,
    this.mail,
    this.certification,
  });

  @override
  _EmployeeManageState createState() => _EmployeeManageState();
}

class _EmployeeManageState extends State<EmployeeManage> {
  String pageName = 'Employees';
  bool _isSidebarOpen = true;
  bool showEmployeeForm = false;
  bool showAllEmployees = true;
  String? activeDropdown;
  final TextEditingController nameController = TextEditingController();
  List<EmployeeInf> filteredEmployees = [];
  String? selectedDepartment;

  @override
  void initState() {
    super.initState();
    filteredEmployees = List.from(employees);
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

  void deleteEmployee(String name) {
    setState(() {
      employees.removeWhere((employee) => employee.name == name);
      filteredEmployees.removeWhere((employee) => employee.name == name);
    });
  }

  void handleUpdate(EmployeeInf updatedEmployee) {
    setState(() {
      final index =
          employees.indexWhere((emp) => emp.name == updatedEmployee.name);
      if (index != -1) {
        employees[index] = updatedEmployee;
        if (selectedDepartment == null ||
            updatedEmployee.department == selectedDepartment) {
          final filteredIndex = filteredEmployees
              .indexWhere((emp) => emp.name == updatedEmployee.name);
          if (filteredIndex != -1) {
            filteredEmployees[filteredIndex] = updatedEmployee;
          }
        }
      }
    });
  }

  void filterEmployees(String? department) {
    setState(() {
      if (department == null || department.isEmpty || department == 'All') {
        filteredEmployees = List.from(employees);
        selectedDepartment = null;
      } else {
        filteredEmployees =
            employees.where((emp) => emp.department == department).toList();
        selectedDepartment = department;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomTitleAppbar(
          ctx: context,
          service: pageName,
          titles: const ['Employees', 'Department'],
          options: const [
            ['Employees', 'Contracts', 'Org Chart'],
            ['Department', 'Position']
          ],
          optionNavigations: [
            [
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => EmployeeManage())),
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Contracts())),
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => OrgChartManage())),
            ],
            [ 
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Department())),
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => PositionManage())),
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
      body: widget.name != null && 
            widget.role != null && 
            widget.department != null && 
            widget.mobile != null && 
            widget.mail != null && 
            widget.certification != null
      ? EmployeeForm(
          name: widget.name,
          role: widget.role,
          department: widget.department,
          mobile: widget.mobile,
          mail: widget.mail,
          certification: widget.certification,
        )
      : showEmployeeForm
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
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(width: 20),
                                  const Icon(Icons.groups,
                                      color: secondaryColor, size: 20),
                                  const Text(' DEPARTMENT',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: textColor,
                                          fontWeight: FontWeight.bold)),
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
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                              const SizedBox(height: 20),
                              ListTile(
                                title: const Text(
                                  'All',
                                  style: TextStyle(color: textColor),
                                ),
                                onTap: () {
                                  filterEmployees('All');
                                },
                              ),
                              ...departments
                                  .map((department) => ListTile(
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
                                          filterEmployees(
                                              department.department);
                                        },
                                      ))
                                  .toList(),
                            ]
                          : [
                              const SizedBox(height: 30),
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
                                  )),
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
                        itemCount: filteredEmployees.length,
                        itemBuilder: (context, index) {
                          final employee = filteredEmployees[index];
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
