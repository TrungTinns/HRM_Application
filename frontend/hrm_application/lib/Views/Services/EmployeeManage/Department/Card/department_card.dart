import 'package:flutter/material.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Department/Detail/department_detail.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Department/Manage/department_manage.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Department/department_inf.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Employee/employees_inf.dart';
import 'package:hrm_application/Widgets/colors.dart';


class DepartmentCard extends StatelessWidget {
  final String department;
  final String manager;
  final String superior;
  final VoidCallback onDelete;
  final ValueChanged<DepartmentInf> onUpdate;

  DepartmentCard({
    required this.department,
    required this.manager,
    required this.superior,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    int employeeCount = countEmployeesInDepartment(employees, department);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    department,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) =>
                        DepartmentDetail(
                          department: department,
                          manager: manager,
                          superior: superior,
                          onDelete: onDelete,
                          onUpdate: onUpdate,
                        )
                      ));
                    },
                    icon: const Icon(Icons.more_vert)
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => EmployeeofDepartment(
                      initialDepartment: department,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: textColor,
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text('$employeeCount Employees', style: const TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
