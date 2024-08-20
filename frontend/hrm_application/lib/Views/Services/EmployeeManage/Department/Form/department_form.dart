import 'package:flutter/material.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Department/Data/department_data.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Employee/Data/employees_data.dart';
import 'package:hrm_application/views/services/EmployeeManage/department/department.dart';
import 'package:hrm_application/widgets/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DepartmentForm extends StatefulWidget {
  @override
  _DepartmentFormState createState() => _DepartmentFormState();
}

class _DepartmentFormState extends State<DepartmentForm> with SingleTickerProviderStateMixin {
  TextEditingController departmentController = TextEditingController();
  TextEditingController managerController = TextEditingController();
  TextEditingController superiorController = TextEditingController();
  List<EmployeeData> managers = [];
  List<String> managerNames = [];
  List<DepartmentData> departments = [];
  List<String> departmentNames = [];
  bool isNameFilled = false;
  String selectedManagerId = '';
  String selectedSuperiorId = '';

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

  void initState() {
    super.initState();
    departmentController.addListener(() {
      setState(() {
        isNameFilled = departmentController.text.isNotEmpty;
      });
    });
    fetchAndSetManagers();
    fetchAndSetDepartments();
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

  Future<void> createDepartment() async {
    final url = Uri.parse('http://localhost:9001/api/v1/employee/department');

    final departments = {
      'id': '',
      'name': departmentController.text.isNotEmpty ? departmentController.text : ' ',
      'managerId': selectedManagerId.isNotEmpty ? selectedManagerId : ' ',
      'parentDepartmentId': selectedSuperiorId.isNotEmpty ? selectedSuperiorId : ' ',
    };
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(departments),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Create department successfully')),
        );
      } else {
        print('Failed to create department: ${response.body}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error creating department: $e')),
      );
    }
  }

  @override
  void dispose() {
    departmentController.dispose();
    superiorController.dispose();
    managerController.dispose();
    super.dispose();
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
      backgroundColor: snackBarColor,
      body: SingleChildScrollView(
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
                const SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: isNameFilled
          ? FloatingActionButton(
              onPressed: () async {
                createDepartment();
                Navigator.push(context, MaterialPageRoute(builder: (ctx) => Department()));
              },
              child: const Icon(Icons.create),
            )
          : null,
    );
  }
}
