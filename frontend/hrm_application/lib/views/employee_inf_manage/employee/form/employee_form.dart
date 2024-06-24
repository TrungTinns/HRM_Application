import 'package:flutter/material.dart';
import 'package:hrm_application/views/employee_inf_manage/employee/employees.dart';
import 'package:hrm_application/views/employee_inf_manage/employee/employees_inf.dart';
import 'package:hrm_application/widgets/colors.dart';

class EmployeeForm extends StatefulWidget {
  @override
  _EmployeeFormState createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> with SingleTickerProviderStateMixin {
  TextEditingController nameController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController managerController = TextEditingController();

  final List<String> departments = ['Administration', 'Research & Development', 'Quality', 'Human Resources', 'Sales', 'Accounting', 'Financial'];
  final List<String> roles = ['Director', 'CEO', 'Project Manager', 'Dev', 'Tester', 'Quality Assurance', 'HR', 'Content Creator', 'Accountant', 'Business Analysis', 'Designer', 'Actuary', 'Secretary', 'Sales', 'Database Administrator', 'Collaborator'];
  final List<String> managers = ['John Doe', 'Gordon Ramsay', 'Manager 3'];

  TabController? tabController;
  bool isNameFilled = false;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    nameController.addListener(() {
      setState(() {
        isNameFilled = nameController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    roleController.dispose();
    mobileController.dispose();
    departmentController.dispose();
    managerController.dispose();
    tabController?.dispose();
    super.dispose();
  }

  Future<void> _selectImage() async {}

  Widget buildTextFieldRow(String label, TextEditingController controller) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Expanded(
          child: TextField(
            controller: controller,
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
          width: 150,
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
      backgroundColor: snackBarColor,
      body: SingleChildScrollView(
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
                        style: const TextStyle(color: textColor, fontSize: 40.0),
                        decoration: const InputDecoration(
                          hintText: "Employee's Name",
                          hintStyle: TextStyle(color: termTextColor, fontSize: 40.0),
                        ),
                      ),
                      TextField(
                        controller: roleController,
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
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
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
            SizedBox(
              height: 200,
              child: TabBarView(
                controller: tabController,
                children: const [
                  Center(child: Text('Content for Tab 1')),
                  Center(child: Text('Content for Tab 2')),
                  Center(child: Text('Content for Tab 3')),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: isNameFilled
          ? FloatingActionButton(
              onPressed: () {
                final newEmployee = EmployeeInf(
                  name: nameController.text,
                  role: roleController.text,
                  mail: mailController.text,
                  mobile: mobileController.text,
                  department: departmentController.text,
                  manager: managerController.text,
                );
                setState(() {
                  employees.add(newEmployee);
                });
                Navigator.push(context, MaterialPageRoute(builder: (ctx) => EmployeeManage()));
              },
              child: const Icon(Icons.create),
            )
          : null,
    );
  }
}