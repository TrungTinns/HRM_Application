import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_application/views/employee_inf_manage/contract/contracts.dart';
import 'package:hrm_application/views/employee_inf_manage/contract/contracts_inf.dart';
import 'package:hrm_application/views/employee_inf_manage/employee/employees_inf.dart';
import 'package:hrm_application/widgets/colors.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ContractForm extends StatefulWidget {
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
  final List<String> status = ['Running', 'Expired', 'Cancelled'];
  int toggleIndex = 0;

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

  Widget buildTextFieldRow(String label, TextEditingController controller, {bool isDateField = false}) {
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
          child: GestureDetector(
            onTap: () {
              if (isDateField) {
                _selectDate(controller);
              }
            },
            child: AbsorbPointer(
              child: TextField(
                controller: controller,
                style: const TextStyle(color: textColor),
                decoration: const InputDecoration(
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
          width: 200,
          child: Text(
            label,
            style: const TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Expanded(
          child: DropdownButtonFormField<dynamic>(
            dropdownColor: dropdownColor,
            value: null,
            items: items.map((item) {
              return DropdownMenuItem<dynamic>(
                value: item,
                child: Text(item is EmployeeInf ? item.name : item.toString(), style: const TextStyle(color: textColor),),
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
                        controller: referenceController,
                        style: const TextStyle(color: textColor, fontSize: 30.0),
                        decoration: const InputDecoration(
                          hintText: "Contract Reference",
                          hintStyle: TextStyle(color: termTextColor, fontSize: 30.0),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                ToggleSwitch(
                  minWidth: 90.0,
                  initialLabelIndex: toggleIndex,
                  cornerRadius: 20.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  totalSwitches: 3,
                  labels: ['Running', 'Expired', 'Cancelled'],
                  icons: [Icons.play_arrow, Icons.hourglass_empty, Icons.cancel],
                  activeBgColors: [[Colors.green], [Colors.orange], [Colors.red]],
                  onToggle: (index) {
                    setState(() {
                      toggleIndex = index!;
                      statusController.text = status[index];
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      buildDropdownRow('Employee', employees, employeeNameController),
                      const SizedBox(height: 10),
                      buildTextFieldRow('Contract Start Date', startDateController, isDateField: true),
                      const SizedBox(height: 10),
                      buildTextFieldRow('Contract End Date', endDateController, isDateField: true),
                      const SizedBox(height: 10),
                      buildDropdownRow('Working Schedule', schedules, scheduleController),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    children: [
                      buildDropdownRow('Salary Structure Type', salaryStructures, salaryStructureController),
                      const SizedBox(height: 10),
                      buildTextFieldRow('Department', departmentController),
                      const SizedBox(height: 10),
                      buildTextFieldRow('Job Position', positionController),
                      const SizedBox(height: 10),
                      buildDropdownRow('Contract Type', contractTypes, contractTypeController),
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
                Tab(text: 'Salary Information'),
                Tab(text: 'Contract Details'),
              ],
            ),
            SizedBox(
              height: 200,
              child: TabBarView(
                controller: tabController,
                children: const [
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
            onPressed: () {
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
              setState(() {
                contracts.add(newContract);
              });
              Navigator.push(context, MaterialPageRoute(builder: (ctx) => Contracts()));
            },
            child: const Icon(Icons.create),
          )
          : null,
    );
  }
}