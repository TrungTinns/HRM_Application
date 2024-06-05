import 'package:flutter/material.dart';
import 'package:hrm_application/components/employee/employee_card.dart';

class EmployeeManage extends StatefulWidget {
  @override
  _EmployeeManageState createState() => _EmployeeManageState();
}

class _EmployeeManageState extends State<EmployeeManage> {
  final List<String> tabs = ['Employees', 'Departments', 'Reporting', 'Configuration'];
  String selectedTab = 'Employees';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.group),
            SizedBox(width: 8),
            Text('Employees'),
            SizedBox(width: 16),
            DropdownButton<String>(
              value: selectedTab,
              icon: Icon(Icons.arrow_drop_down),
              onChanged: (String? newValue) {
                setState(() {
                  selectedTab = newValue!;
                });
              },
              items: tabs.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Handle new employee action
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search...',
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                EmployeeCard(
                  name: 'Huỳnh Trần Minh Tiến',
                  role: 'Dev',
                  email: 'minhtien123@email.com',
                ),
                EmployeeCard(
                  name: 'ngthns',
                  email: 'trungthn03@gmail.com',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}