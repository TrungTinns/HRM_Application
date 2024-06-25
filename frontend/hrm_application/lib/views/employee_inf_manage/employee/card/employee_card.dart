import 'package:flutter/material.dart';
import 'package:hrm_application/views/employee_inf_manage/employee/detail/employee_detail.dart';

class EmployeeCard extends StatelessWidget {
  final String name;
  final String? role;
  final String mail;
  final String mobile;
  final String department;
  final String manager;
  final VoidCallback onDelete;
  final bool isManager;

  EmployeeCard({
    required this.name,
    required this.role,
    required this.mail,
    required this.mobile,
    required this.department,
    required this.manager,
    required this.onDelete,
    required this.isManager, 
  });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EmployeeDetail(
              name: name,
              role: role,
              mail: mail,
              mobile: mobile,
              department: department,
              manager: manager,
              onDelete: onDelete,
              isManager: isManager,
            ),
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.purple,
                child: Text(
                  name.isNotEmpty ? name[0].toUpperCase() : '',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (role != null) Text(role!),
                    Text(mail),
                    Text(mobile),
                    Text(department),
                    // Text(isManager.toString()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}