import 'package:flutter/material.dart';
import 'package:hrm_application/components/appbar/custom_title_appbar.dart';
import 'package:hrm_application/components/configuration/configurtion.dart';
import 'package:hrm_application/views/employee_inf_manage/contract/contracts.dart';
import 'package:hrm_application/views/employee_inf_manage/department/department.dart';
import 'package:hrm_application/views/employee_inf_manage/employee/employees.dart';
import 'package:hrm_application/views/employee_inf_manage/org%20chart/orgchart.dart';
import 'package:hrm_application/views/home/home.dart';
import 'package:hrm_application/widgets/colors.dart';

class DepartmentDetail extends StatefulWidget {final String department;
  final String manager;
  final String superior;
  final VoidCallback onDelete;

  DepartmentDetail({
    required this.department,
    required this.manager,
    required this.superior,
    required this.onDelete,
  });

  @override
  _DepartmentDetailState createState() => _DepartmentDetailState();
}

class _DepartmentDetailState extends State<DepartmentDetail> with SingleTickerProviderStateMixin {
  TextEditingController departmentController = TextEditingController();
  TextEditingController managerController = TextEditingController();
  TextEditingController superiorController = TextEditingController();
  final List<String> superiors = ['Administration', 'Research & Development', 'Quality', 'Human Resources', 'Sales', 'Accounting', 'Financial'];

  String pageName = 'Department';
  bool showDepartmentForm = false;
  String? activeDropdown;
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
  
    @override
  void initState() {
    super.initState();
    departmentController.text = widget.department;
    managerController.text = widget.manager;
    superiorController.text = widget.superior;
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
            readOnly: true,
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
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: const TextStyle(color: textColor)),
              );
            }).toList(),
            onChanged: (value) {
              controller.text = value!;
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
                    IconButton(
                      icon: const Icon(Icons.clear),
                      color: Colors.white,
                      iconSize: 24,
                      tooltip: "Delete this Department",
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Do you want to delete this Department?'),
                              content: const Text(''),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    widget.onDelete();
                                    Navigator.pop(context); 
                                    Navigator.pop(context); 
                                  },
                                  child: const Text('OK'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel'),
                                ),
                              ],
                            );
                          },
                        );
                      },
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
      body:  SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: departmentController,
              style: const TextStyle(color: textColor, fontSize: 30.0),
              decoration: const InputDecoration(
                hintText: "Name of Department",
                hintStyle: TextStyle(color: termTextColor, fontSize: 30.0), 
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                buildTextFieldRow('Manage', managerController),
                const SizedBox(height: 10),
                buildTextFieldRow('Superior Department', superiorController),
                const SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
