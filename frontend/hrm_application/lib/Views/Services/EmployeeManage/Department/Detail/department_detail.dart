import 'package:flutter/material.dart';
import 'package:hrm_application/Component/Appbar/custom_title_appbar.dart';
import 'package:hrm_application/Component/Configuration/configuration.dart';
import 'package:hrm_application/Views/Home/home.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Contract/contracts.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Department/Data/department_data.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Department/Form/department_form.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Department/department.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Employee/Data/employees_data.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Employee/employees.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/OrgChart/orgchart.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Position/position.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hrm_application/widgets/colors.dart';

class DepartmentDetail extends StatefulWidget {
  final String id;
  final String department;
  final String managerId;
  final String superior;

  DepartmentDetail({
    required this.id,
    required this.department,
    required this.managerId,
    required this.superior,
  });

  @override
  _DepartmentDetailState createState() => _DepartmentDetailState();
}

class _DepartmentDetailState extends State<DepartmentDetail> with SingleTickerProviderStateMixin {
  TextEditingController departmentController = TextEditingController();
  TextEditingController managerController = TextEditingController();
  TextEditingController superiorController = TextEditingController();
  List<EmployeeData> managers = [];
  List<String> managerNames = [];
  List<DepartmentData> departments = [];
  String selectedManagerId = '';
  String selectedSuperiorId = '';
  List<String> departmentNames = [];
  String pageName = 'Department';
  bool showDepartmentForm = false;
  String? activeDropdown;
  bool isChanged = false;

  void setActiveDropdown(String? dropdown) {
    setState(() {
      activeDropdown = dropdown;
    });
  }

  void _handleManagerSelection(String managerId) {
    setState(() {
      selectedManagerId = managerId;
    });
  }

  void _handleSuperiorSelection(String superior) {
    setState(() {
      selectedSuperiorId = superior;
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
    managerController.text = widget.managerId;
    superiorController.text = widget.superior;
    fetchAndSetDepartments();
    fetchAndSetManagers();
  }

  Future<void> fetchAndSetDepartments() async {
    try {
      departments = await fetchDepartments();
      setState(() {
        departmentNames = departments.map((dept) => dept.department).toList();
        departmentNames.sort((a, b) => a.compareTo(b));
      });
    } catch (e) {
      print('Error fetching departments: $e');
    }
  }

  Future<void> fetchAndSetManagers() async {
    try {
      managers = await fetchManagers();
      setState(() {
        managerNames = managers.map((mgr) => mgr.name).toList();
        managerNames.sort((a, b) => a.compareTo(b));
      });
    } catch (e) {
      print('Error fetching managers: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
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

  Future<void> _saveChanges() async {
    final url = Uri.parse('http://localhost:9001/api/v1/employee/department');

    final departmentData = {
      "id": widget.id,
      "name": departmentController.text,
      "managerId": managerController.text,
      "parentDepartmentId": superiorController.text,
    };
    try {
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(departmentData),
      );

      if (response.statusCode == 200) {
        setState(() {
          isChanged = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Department updated successfully')),
        );
      } else {
        throw Exception('Failed to update department: ${response.body}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating department: $e')),
      );
    }
  }

  Future<void> deleteDepartment(String departmentId) async {
    try {
      final url = Uri.parse('http://localhost:9001/api/v1/employee/department/$departmentId');
      final response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Delete department successfully')),
        );
      } else {
        throw Exception('Failed to delete department: ${response.body}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting department: $e')),
      );
    }
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

  Widget buildDropdownRowAPI(String label, TextEditingController controller, List<Map<String, String>> items, {Function(String)? onChanged}) {
    return Row(
      children: [
        SizedBox(
          width: 200,
          child: Text(
            label,
            style: const TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Expanded(
          child: DropdownButtonFormField<String>(
            dropdownColor: dropdownColor,
            value: controller.text.isEmpty ? null : controller.text,
            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: item['id'],
                child: Text(item['name']!, style: const TextStyle(color: textColor)),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                controller.text = value!;
                if (onChanged != null) {
                  onChanged(value);
                }
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
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => EmployeeManage())),
                            () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => EmployeeManage())),

              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => EmployeeManage())),

              // () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Contracts())),
              // () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => OrgChartManage())),
            ],
            [
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Department())),

              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => EmployeeManage())),

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
                            _saveChanges();
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
                                    deleteDepartment(widget.id);
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
                buildDropdownRowAPI(
                        'Manager',
                        managerController,
                        managers.map((mgr) => {'id': mgr.id, 'name': mgr.name}).toList(),
                        onChanged: _handleManagerSelection,
                      ),
                const SizedBox(height: 10),
                buildDropdownRowAPI(
                        'Superior',
                        superiorController,
                        departments.map((dpm) => {'id': dpm.id, 'name': dpm.department}).toList(),
                        onChanged: _handleSuperiorSelection,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
