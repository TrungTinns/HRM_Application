import 'package:flutter/material.dart';
import 'package:hrm_application/views/employee_inf_manage/department/department_inf.dart';
import 'package:hrm_application/views/employee_inf_manage/employee/employees_inf.dart';
import 'package:hrm_application/widgets/colors.dart';

class DepartmentForm extends StatefulWidget {
  final Function(DepartmentInf) onAddDepartment;

  DepartmentForm({
    required this.onAddDepartment
  });

  @override
  _DepartmentFormState createState() => _DepartmentFormState();
}

class _DepartmentFormState extends State<DepartmentForm> with SingleTickerProviderStateMixin {
  final List<String> superiors = ['Administration', 'Research & Development', 'Quality', 'Human Resources', 'Sales', 'Accounting', 'Financial'];
  TextEditingController departmentController = TextEditingController();
  TextEditingController managerController = TextEditingController();
  TextEditingController superiorController = TextEditingController();
  bool isNameFilled = false;

  void initState() {
    super.initState();
    departmentController.addListener(() {
      setState(() {
        isNameFilled = departmentController.text.isNotEmpty;
      });
    });
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
                buildDropdownRow('Manage', managerController, employees.map((employee) => employee.name).toList()),
                const SizedBox(height: 10),
                buildDropdownRow('Superior Department', superiorController, superiors),
                const SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: isNameFilled
          ? FloatingActionButton(
              onPressed: () {
                final newDepartment = DepartmentInf(
                  department: departmentController.text,
                  manager: managerController.text,
                  superior: superiorController.text,
                );
                widget.onAddDepartment(newDepartment);
              },
              child: const Icon(Icons.create),
            )
          : null,
    );
  }
}
