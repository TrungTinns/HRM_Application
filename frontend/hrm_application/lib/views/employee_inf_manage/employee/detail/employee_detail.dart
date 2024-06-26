import 'package:flutter/material.dart';
import 'package:hrm_application/components/appbar/custom_title_appbar.dart';
import 'package:hrm_application/components/configuration/configurtion.dart';
import 'package:hrm_application/views/employee_inf_manage/contract/contracts.dart';
import 'package:hrm_application/views/employee_inf_manage/department/department.dart';
import 'package:hrm_application/views/employee_inf_manage/employee/employees.dart';
import 'package:hrm_application/views/employee_inf_manage/employee/employees_inf.dart';
import 'package:hrm_application/views/employee_inf_manage/employee/form/employee_form.dart';
import 'package:hrm_application/views/employee_inf_manage/org%20chart/orgchart.dart';
import 'package:hrm_application/views/home/home.dart';
import 'package:hrm_application/widgets/colors.dart';

class EmployeeDetail extends StatefulWidget {
  final String name;
  final String? role;
  final String mail;
  final String mobile;
  final String department;
  final String manager;
  final VoidCallback onDelete;
  final bool isManager;
  final ValueChanged<EmployeeInf> onUpdate;
  final String workLocation;
  final String schedule;

  EmployeeDetail({
    required this.name,
    required this.role,
    required this.mail,
    required this.mobile,
    required this.department,
    required this.manager,
    required this.onDelete,
    required this.isManager,
    required this.onUpdate,
    required this.workLocation,
    required this.schedule
  });

  @override
  _EmployeeDetailState createState() => _EmployeeDetailState();
}

class _EmployeeDetailState extends State<EmployeeDetail> with SingleTickerProviderStateMixin {
  TextEditingController nameController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController managerController = TextEditingController();
  TextEditingController workLocationController = TextEditingController();
  TextEditingController scheduleController = TextEditingController();
  bool isManager = false;

  final List<String> departments = ['Administration', 'Research & Development', 'Quality', 'Human Resources', 'Sales', 'Accounting', 'Financial'];
  final List<String> roles = ['Director', 'CEO', 'Project Manager', 'Dev', 'Tester', 'Quality Assurance', 'HR', 'Content Creator', 'Accountant', 'Business Analysis', 'Designer', 'Actuary', 'Secretary', 'Sales', 'Database Administrator', 'Collaborator'];
  List<String> managers = [];
  
  String pageName = 'Employees';
  bool showEmployeeForm = false;
  String? activeDropdown;
  bool isChanged = false;

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
              content: const Text('Name field is missing.'),
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
      Navigator.push(context, MaterialPageRoute(builder: (ctx) => EmployeeManage()));
    });
  }

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    roleController.text = widget.role ?? roles.first;
    mobileController.text = widget.mobile;
    mailController.text = widget.mail;
    departmentController.text = widget.department;
    managerController.text = widget.manager;
    managers = getManagers(employees);
    tabController = TabController(length: 4, vsync: this);
    isManager = widget.isManager; 
    workLocationController.text = widget.workLocation;
    scheduleController.text = widget.schedule;
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void saveChanges() {
    final updatedEmployee = EmployeeInf(
      name: nameController.text,
      role: roleController.text,
      mail: mailController.text,
      mobile: mobileController.text,
      department: departmentController.text,
      manager: managerController.text,
      isManager: isManager,
      workLocation: workLocationController.text,
      schedule: scheduleController.text
    );
    widget.onUpdate(updatedEmployee);
    Navigator.pop(context);
  }

  Widget buildTextFieldRow(String label, TextEditingController controller) {
    return Row(
      children: [
        SizedBox(
          width: 200,
          child: Text(
            label,
            style: const TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Expanded(
          child: TextField(
            controller: controller,
            onChanged: (value) {
              setState(() {
                isChanged = true;
              });
            },
            style: const TextStyle(color: textColor),
            decoration: const InputDecoration(
              filled: true,
              fillColor: snackBarColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDropdownRow(String label, TextEditingController controller, List<String> items) {
    return Row(
      children: [
        SizedBox(
          width: 200,
          child: Text(
            label,
            style: const TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Expanded(
          child: DropdownButtonFormField<String>(
            dropdownColor: dropdownColor,
            value: controller.text,
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: const TextStyle(color: textColor)),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                controller.text = value!;
                isChanged = true;
              });
            },
            decoration: const InputDecoration(
              filled: true,
              fillColor: snackBarColor,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomTitleAppbar(
          ctx: context,
          service: pageName,
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
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (isChanged) {
                            saveChanges();
                          } else {
                            toggleEmployeeForm();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: textColor,
                          backgroundColor: primaryColor , 
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          isChanged ? 'Save' : 'New',
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
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
                    IconButton(
                      icon: const Icon(Icons.clear),
                      color: Colors.white,
                      iconSize: 24,
                      tooltip: showEmployeeForm ? "Discard all changes" : "Delete this employee",
                      onPressed: showEmployeeForm ? clearEmployeeForm : () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Do you want to delete this employee?'),
                              content: const Text(''),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    widget.onDelete();
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: snackBarColor,
      ),
      backgroundColor: snackBarColor,
      body: showEmployeeForm
          ? EmployeeForm()
      : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: nameController,
                        onChanged: (value) {
                          setState(() {
                            isChanged = true;
                          });
                        },
                        style: const TextStyle(color: textColor, fontSize: 40.0),
                        decoration: const InputDecoration(
                          hintText: "Employee's Name",
                          hintStyle: TextStyle(color: termTextColor, fontSize: 40.0),
                        ),
                      ),
                      TextField(
                        controller: roleController,
                          onChanged: (value) {
                            setState(() {
                              isChanged = true;
                            });
                          },
                        style: const TextStyle(color: textColor, fontSize: 20.0),
                        decoration: const InputDecoration(
                          hintText: "Job Position",
                          hintStyle: TextStyle(color: termTextColor, fontSize: 20.0),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                if (widget.name.isNotEmpty) 
                  Column(
                    children: [
                      const SizedBox(height: 20,),
                      IconButton(
                        icon: const Icon(Icons.insert_photo),
                        color: textColor,
                        iconSize: 120,
                        onPressed: () {},
                        tooltip: "Upload photo",
                      ),
                    ],
                  ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    
                    children: [
                      buildTextFieldRow('Mobile', mobileController),
                      const SizedBox(height: 10),
                      buildTextFieldRow('Email', mailController),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Management Authority',
                            style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const SizedBox(width: 20),
                          Switch(
                            value: isManager,
                            onChanged: (value) {
                              setState(() {
                                isManager = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    children: [
                      buildDropdownRow('Department', departmentController, departments),
                      const SizedBox(height: 10),
                      buildDropdownRow('Position', roleController, roles),
                      const SizedBox(height: 10),
                      buildDropdownRow('Manager', managerController, managers),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TabBar(
              controller: tabController,
              labelStyle: const TextStyle(color: textColor, fontSize: 16),
              tabs: const [
                Tab(text: 'Work Information'),
                Tab(text: 'Private Information'),
                Tab(text: 'Contract'),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: TabBarView(
                controller: tabController,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        buildTextFieldRow('Work Location', workLocationController),
                        const SizedBox(height: 10),
                        buildTextFieldRow('Schedule', scheduleController),
                      ],
                    ),
                  ),
                  const Center(child: Text('Content for Tab 2')),
                  const Center(child: Text('Content for Tab 3')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}