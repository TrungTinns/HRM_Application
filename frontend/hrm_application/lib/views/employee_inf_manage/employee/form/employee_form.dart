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

  TabController? tabController;

  bool _isSidebarOpen = true;

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
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Expanded(
          child: TextField(
            controller: controller,
            style: TextStyle(color: textColor),
            decoration: InputDecoration(
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
          width: 100,
          child: Text(
            label,
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Expanded(
          child: DropdownButtonFormField<String>(
            dropdownColor: dropdownColor,
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(color: textColor)),
              );
            }).toList(),
            onChanged: (value) {
              controller.text = value!;
            },
            decoration: InputDecoration(
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
        padding: EdgeInsets.all(16.0),
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
                        style: TextStyle(color: textColor, fontSize: 40.0),
                        decoration: InputDecoration(
                          hintText: "Employee's Name",
                          hintStyle: TextStyle(color: termTextColor, fontSize: 40.0),
                        ),
                      ),
                      TextField(
                        controller: roleController,
                        style: TextStyle(color: textColor, fontSize: 20.0),
                        decoration: InputDecoration(
                          hintText: "Job Position",
                          hintStyle: TextStyle(color: termTextColor, fontSize: 20.0),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    IconButton(
                      icon: Icon(Icons.insert_photo),
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
                      SizedBox(height: 10),
                      buildTextFieldRow('Email', mailController),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    children: [
                      buildDropdownRow('Department', departmentController, ['Administration', 'Research & Development', 'Quality', 'Human Resources', 'Sales', 'Accounting', 'Financial']),
                      SizedBox(height: 10),
                      buildDropdownRow('Position', roleController, ['Director', 'CEO', 'Project Manager', 'Dev', 'Tester', 'Quality Assurance', 'HR', 'Content Creator', 'Accountant', 'Business Analysis', 'Designer', 'Actuary', 'Secretary', 'Sales', 'Database Administrator', 'Collaborator']),
                      SizedBox(height: 10),
                      buildDropdownRow('Manager', managerController, ['Manager 1', 'Manager 2', 'Manager 3']),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TabBar(
              controller: tabController,
              labelStyle: TextStyle(color: textColor, fontSize: 16),
              tabs: [
                Tab(text: 'Work Information'),
                Tab(text: 'Private Information'),
                Tab(text: 'Contract'),
              ],
            ),
            Container(
              height: 200,
              child: TabBarView(
                controller: tabController,
                children: [
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
              child: Icon(Icons.create),
            )
          : null,
    );
  }
}