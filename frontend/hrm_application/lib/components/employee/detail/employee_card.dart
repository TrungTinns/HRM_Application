import 'package:flutter/material.dart';

class EmployeeCard extends StatelessWidget {
  final String name;
  final String? role;
  final String email;

  EmployeeCard({
    required this.name,
    this.role,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              child: Text(
                name.isNotEmpty ? name[0].toUpperCase() : '',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.purple,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (role != null) Text(role!),
                  Text(email),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}