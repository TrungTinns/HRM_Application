import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_application/views/employee_inf_manage/contract/contracts.dart';
import 'package:hrm_application/views/employee_inf_manage/contract/contracts_inf.dart';
import 'package:hrm_application/views/employee_inf_manage/employee/employees_inf.dart';
import 'package:hrm_application/widgets/colors.dart';

class ContractForm extends StatefulWidget {
  final Function(ContractData) addContract;

  ContractForm({required this.addContract});
  @override
  _ContractFormState createState() => _ContractFormState();
}

class _ContractFormState extends State<ContractForm> with SingleTickerProviderStateMixin {
  TextEditingController employeeNameController = TextEditingController();
  TextEditingController referenceController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController scheduleController = TextEditingController();
  TextEditingController salaryStructureController = TextEditingController();
  TextEditingController contractTypeController = TextEditingController();
  TextEditingController statusController = TextEditingController();

  TabController? tabController;
  bool isRefFilled = false;
  final List<String> schedules = ['Standard 40 hours/week', 'Part-time 25 hours/week'];
  final List<String> salaryStructures = ['Employee', 'Worker'];
  final List<String> contractTypes = ['Permanent', 'Temporary', 'Seasonal', 'Full-time', 'Part-time'];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    referenceController.addListener(() {
      setState(() {
        isRefFilled = referenceController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    referenceController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    departmentController.dispose();
    positionController.dispose();
    scheduleController.dispose();
    salaryStructureController.dispose();
    contractTypeController.dispose();
    tabController?.dispose();
    super.dispose();
  }

  Future<void> _selectDate(TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        controller.text = picked.toString().substring(0, 10);
      });
    }
  }

  void _updateEmployeeInfo(EmployeeInf employee) {
    setState(() {
      departmentController.text = employee.department;
      positionController.text = employee.role;
    });
  }

  void _addContract() {
    final newContract = ContractData(
      employeeName: employeeNameController.text,
      reference: referenceController.text,
      department: departmentController.text,
      position: positionController.text,
      startDate: DateTime.parse(startDateController.text),
      endDate: DateTime.parse(endDateController.text),
      schedule: scheduleController.text,
      salaryStructure: salaryStructureController.text,
      contractType: contractTypeController.text,
      status: statusController.text,                
    );
    widget.addContract(newContract);
    Navigator.push(context, MaterialPageRoute(builder: (ctx) => Contracts()));
  }

  Widget buildTextFieldRow(String label, TextEditingController controller, {bool isDateField = false}) {
    return Row(
      children: [
        SizedBox(
          width: 150,
          child: Text(
            label,
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (isDateField) {
                _selectDate(controller);
              }
            },
            child: AbsorbPointer(
              child: TextField(
                controller: controller,
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: snackBarColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDropdownRow(String label, List<dynamic> items, TextEditingController controller) {
    return Row(
      children: [
        SizedBox(
          width: 150,
          child: Text(
            label,
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Expanded(
          child: DropdownButtonFormField<dynamic>(
            dropdownColor: dropdownColor,
            value: null,
            items: items.map((item) {
              return DropdownMenuItem<dynamic>(
                value: item,
                child: Text(item is EmployeeInf ? item.name : item.toString(), style: TextStyle(color: textColor),),
              );
            }).toList(),
            onChanged: (selectedItem) {
              setState(() {
                if (selectedItem is EmployeeInf) {
                  _updateEmployeeInfo(selectedItem);
                } else {
                  controller.text = selectedItem.toString();
                }
              });
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
                        controller: referenceController,
                        style: TextStyle(color: textColor, fontSize: 30.0),
                        decoration: InputDecoration(
                          hintText: "Contract Reference",
                          hintStyle: TextStyle(color: termTextColor, fontSize: 30.0),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      buildDropdownRow('Employee', employees, employeeNameController),
                      SizedBox(height: 10),
                      buildTextFieldRow('Contract Start Date', startDateController, isDateField: true),
                      SizedBox(height: 10),
                      buildTextFieldRow('Contract End Date', endDateController, isDateField: true),
                      SizedBox(height: 10),
                      buildDropdownRow('Working Schedule', schedules, scheduleController),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    children: [
                      buildDropdownRow('Salary Structure Type', salaryStructures, salaryStructureController),
                      SizedBox(height: 10),
                      buildTextFieldRow('Department', departmentController),
                      SizedBox(height: 10),
                      buildTextFieldRow('Job Position', positionController),
                      SizedBox(height: 10),
                      buildDropdownRow('Contract Type', contractTypes, contractTypeController),
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
                Tab(text: 'Salary Information'),
                Tab(text: 'Contract Details'),
              ],
            ),
            Container(
              height: 200,
              child: TabBarView(
                controller: tabController,
                children: [
                  Center(child: Text('Content for Tab 1')),
                  Center(child: Text('Content for Tab 2')),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: isRefFilled
          ? FloatingActionButton(
            onPressed: _addContract,
            child: Icon(Icons.create),
          )
          : null,
    );
  }
}