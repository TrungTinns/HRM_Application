import 'package:flutter/material.dart';
import 'package:hrm_application/Component/Appbar/custom_title_appbar.dart';
import 'package:hrm_application/Component/Configuration/configuration.dart';
import 'package:hrm_application/Views/Home/home.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Contract/contracts.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Department/Form/department_form.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Department/department.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Department/department_inf.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Employee/employees.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Employee/employees_inf.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/OrgChart/orgchart.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Position/position.dart';

import 'package:hrm_application/widgets/colors.dart';

class DepartmentDetail extends StatefulWidget {final String department;
  final String manager;
  final String superior;
  final VoidCallback onDelete;
  final ValueChanged<DepartmentInf> onUpdate;

  DepartmentDetail({
    required this.department,
    required this.manager,
    required this.superior,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  _DepartmentDetailState createState() => _DepartmentDetailState();
}

class _DepartmentDetailState extends State<DepartmentDetail> with SingleTickerProviderStateMixin {
  TextEditingController departmentController = TextEditingController();
  TextEditingController managerController = TextEditingController();
  TextEditingController superiorController = TextEditingController();

  String pageName = 'Department';
  bool showDepartmentForm = false;
  String? activeDropdown;
  bool isChanged = false;

  void setActiveDropdown(String? dropdown) {
    setState(() {
      activeDropdown = dropdown;
    });
  }
  
  void toggleDepartmentForm() {
    if (showDepartmentForm) {
      if(departmentController.text.isEmpty) {
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
      departmentController.clear();
      managerController.clear();
      superiorController.clear();
      Navigator.push(context, MaterialPageRoute(builder: (ctx) => Department()));
    });
  }
  
    @override
  void initState() {
    super.initState();
    departmentController.text = widget.department;
    managerController.text = widget.manager;
    superiorController.text = widget.superior;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void saveChanges() {
    final updatedDepartment = DepartmentInf(
      department: departmentController.text,
      manager: managerController.text,
      superior: superiorController.text,
    );

    widget.onUpdate(updatedDepartment);
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
          titles: const ['Employees', 'Department'],
          options: const [
            ['Employees', 'Contracts', 'Org Chart'],
            ['Department', 'Position']
          ],
          optionNavigations: [
            [
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => EmployeeManage())),
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Contracts())),
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => OrgChartManage())),
            ],
            [ 
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Department())),              
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => PositionManage())),
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
          child:  Row(
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
                            toggleDepartmentForm();
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
                      tooltip: showDepartmentForm ? "Discard all changes" : "Delete this department",
                      onPressed: showDepartmentForm ? clearDepartmentForm : () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Do you want to delete this department?'),
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
      body: showDepartmentForm
      ? DepartmentForm()
      : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: departmentController,
              onChanged: (value) {
                          setState(() {
                            isChanged = true;
                          });
                        },
              style: const TextStyle(color: textColor, fontSize: 30.0),
              decoration: const InputDecoration(
                hintText: "Name of Department",
                hintStyle: TextStyle(color: termTextColor, fontSize: 30.0), 
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                buildDropdownRow('Manage', managerController, employees.map((employee) => employee.name).toList()),
                const SizedBox(height: 10),
                buildDropdownRow('Superior Department', superiorController, getDepartments()),
                const SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
