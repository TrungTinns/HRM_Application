import 'package:flutter/material.dart';
import 'package:hrm_application/Component/Appbar/custom_title_appbar.dart';
import 'package:hrm_application/Component/Configuration/configuration.dart';
import 'package:hrm_application/Component/FilterSearch/filter_search.dart';
import 'package:hrm_application/Component/Search/searchBox.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Contract/contracts.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Department/department.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Department/department_inf.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Employee/employees.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/OrgChart/orgchart.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Position/Card/position_card.dart';
import 'package:hrm_application/Views/Services/RecruitmentProcessManage/JobPosition/Form/jobposition_form.dart';
import 'package:hrm_application/Views/Services/RecruitmentProcessManage/JobPosition/jobposition_inf.dart';
import 'package:hrm_application/Views/home/home.dart';
import 'package:hrm_application/widgets/colors.dart';

class PositionManage extends StatefulWidget {
  @override
  _PositionManageState createState() => _PositionManageState();
}

class _PositionManageState extends State<PositionManage> {
  TextEditingController roleController= TextEditingController();
  String pageName = 'Job Positions';
  bool showJobPositionForm = false;
  bool showAllJobPositions = true;
  String? activeDropdown;
  bool _isSidebarOpen = true;
  List<JobPositionInf> filteredJobPositions = [];
  String? selectedDepartment;

  void initState() {
    super.initState();
    filteredJobPositions = List.from(jobPositions);
  }

  void setActiveDropdown(String? dropdown) {
    setState(() {
      activeDropdown = dropdown;
    });
  }

  void toggleJobPositionForm() {
    if (showJobPositionForm) {
      if(roleController.text.isEmpty) {
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
          roleController.clear();
        });
      }
    } else {
      setState(() {
        showJobPositionForm = true;
      });
    }
  }
  
  void clearJobPositionForm() {
    setState(() {
      showJobPositionForm = false;
    });
  }

  void deleteJobPosition(String role) {
    setState(() {
      jobPositions.removeWhere((jobPosition) => jobPosition.role == role);
      filteredJobPositions.removeWhere((jobPosition) => jobPosition.role == role);
    });
  }

  void handleUpdate(JobPositionInf updatedJobPosition) {
    setState(() {
      final index =
          jobPositions.indexWhere((jp) => jp.role == updatedJobPosition.role);
      if (index != -1) {
        jobPositions[index] = updatedJobPosition;
        if (selectedDepartment == null ||
            updatedJobPosition.department == selectedDepartment) {
          final filteredIndex = filteredJobPositions
              .indexWhere((jp) => jp.role == updatedJobPosition.role);
          if (filteredIndex != -1) {
            filteredJobPositions[filteredIndex] = updatedJobPosition;
          }
        }
      }
    });
  }

  void filterJobPositions(String? department) {
    setState(() {
      if (department == null || department.isEmpty || department == 'All') {
        filteredJobPositions = List.from(jobPositions);
        selectedDepartment = null;
      } else {
        filteredJobPositions =
            jobPositions.where((emp) => emp.department == department).toList();
        selectedDepartment = department;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:
        CustomTitleAppbar(
          ctx: context,
          service: 'Employees',
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
                    toggleJobPositionForm();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, 
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
                    if (showJobPositionForm)
                      IconButton(
                        icon: const Icon(Icons.clear),
                        color: Colors.white,
                        iconSize: 24,
                        tooltip: "Discard all changes",
                        onPressed: () {
                          clearJobPositionForm();
                        },
                    ),
                  ],
                ),
              ),
              const Spacer(),
              if (!showJobPositionForm)
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
                  ],
                )
              ),
              const Spacer(),
            ],
          ),
        ),
        backgroundColor: snackBarColor,
      ),
      body: showJobPositionForm
          ? JobPositionForm()
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
                                  filterJobPositions('All');
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
                                              '${countJobPositionsInDepartment(jobPositions, department.department)}',
                                              style: const TextStyle(
                                                color: termTextColor,
                                                fontSize: 16,)
                                              ),
                                          ],
                                        ),
                                        onTap: () {
                                          filterJobPositions(
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
                int crossAxisCount;
                if (constraints.maxWidth >= 1200) {
                  // Desktop
                  crossAxisCount = 3;
                } else if (constraints.maxWidth >= 800) {
                  // Tablet
                  crossAxisCount = 2;
                } else {
                  // Mobile
                  crossAxisCount = 1;
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2.3,
                  ),
                  itemCount: filteredJobPositions.length,
                  itemBuilder: (context, index) {
                    final jobPosition = filteredJobPositions[index];
                    return PositionCard(
                      department: jobPosition.department,
                      mail: jobPosition.mail,
                      jobLocation: jobPosition.jobLocation,
                      role: jobPosition.role,
                      type: jobPosition.type,
                      target: jobPosition.target,
                      isPublished: jobPosition.isPublished,
                      recruiter: jobPosition.recruiter,
                      interviewer: jobPosition.interviewer,
                      details: jobPosition.details,
                      onDelete: () => deleteJobPosition(jobPosition.role),
                      onUpdate: handleUpdate,
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
