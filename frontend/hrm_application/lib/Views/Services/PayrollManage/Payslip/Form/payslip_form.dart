import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_application/Views/Home/home.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Contract/contracts.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Contract/contracts_inf.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Department/department_inf.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Employee/employees_inf.dart';
import 'package:hrm_application/Views/Services/PayrollManage/Batch/batch.dart';
import 'package:hrm_application/Views/Services/PayrollManage/Batch/batches_inf.dart';
import 'package:hrm_application/Views/Services/PayrollManage/Payslip/payslips_inf.dart';
import 'package:hrm_application/widgets/colors.dart';
import 'package:progress_stepper/progress_stepper.dart';

class PayslipForm extends StatefulWidget {
  @override
  _PayslipFormState createState() => _PayslipFormState();
}

class _PayslipFormState extends State<PayslipForm> with SingleTickerProviderStateMixin {
  TextEditingController nameController = TextEditingController();
  TextEditingController referenceController = TextEditingController();
  TextEditingController contractRefController = TextEditingController();
  TextEditingController structureController = TextEditingController();
  TextEditingController othersController = TextEditingController();
  TextEditingController batchController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  int currentStep = 1;
  bool isRefFilled = false;

  @override
  void initState() {
    super.initState();
    nameController.addListener(() {
      setState(() {
        isRefFilled = nameController.text.isNotEmpty;
      });
    });
  }

  String? findContractReference(String employeeName) {
    for (var contract in contracts) {
      if (contract.name == employeeName) {
        return contract.reference;
      }
    }
    return null;
  }

  void showCreateContractDialog(String employeeName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create Contract for $employeeName'),
          content: const Text('No contract found for this employee. Would you like to create one?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Create'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (ctx) => Contracts(name: employeeName)));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    batchController.dispose();
    nameController.dispose();
    referenceController.dispose();
    contractRefController.dispose();
    structureController.dispose();
    othersController.dispose();
    statusController.dispose();
    startDateController.dispose();
    endDateController.dispose();
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
            child: isDateField
                ? AbsorbPointer(
                    child: TextField(
                      controller: controller,
                      style: const TextStyle(color: textColor),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: snackBarColor,
                      ),
                    ),
                  )
                : TextField(
                    controller: controller,
                    style: const TextStyle(color: textColor),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: snackBarColor,
                    ),
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
          width: 200,
          child: Text(
            label,
            style: const TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    dropdownColor: dropdownColor,
                    items: getNameEmp(employees).map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: const TextStyle(color: textColor, fontSize: 18)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          nameController.text = value;
                          String? contractRef = findContractReference(value);
                          if (contractRef != null) {
                            contractRefController.text = contractRef;
                          } else {
                            contractRefController.text = '';
                            showCreateContractDialog(value);
                          }
                        });
                      }
                    },
                    style: const TextStyle(color: textColor, fontSize: 40),
                    decoration: const InputDecoration(
                      hintText: 'Employee',
                      filled: true,
                      fillColor: snackBarColor,
                      hintStyle: TextStyle(color: termTextColor, fontSize: 40.0),

                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ProgressStepper(
                  width: 400,
                  height: 50,
                  padding: 1,
                  currentStep: currentStep,
                  onClick: (index) {
                    setState(() {
                      currentStep = index;
                    });
                  },
                  bluntHead: true,
                  bluntTail: true,
                  color: Colors.transparent,
                  progressColor: Colors.green,
                  stepCount: 4,
                  labels: PayslipData.defaultStatus,
                  defaultTextStyle: const TextStyle(
                    fontSize: 16,
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                  selectedTextStyle: const TextStyle(
                    fontSize: 16,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 200,
                  child: Text(
                    'Period',
                    style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Container(
                  width: 120,
                  margin: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () {
                      _selectDate(startDateController);
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        controller: startDateController,
                        style: const TextStyle(color: textColor),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: snackBarColor,
                        ),
                      ),
                    ),
                  ),
                ),
                const Text('-', style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 20)),
                Container(
                  width: 120,
                  margin: const EdgeInsets.only(left: 8),
                  child: GestureDetector(
                    onTap: () {
                      _selectDate(endDateController);
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        controller: endDateController,
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
            ),
            const SizedBox(height: 10,),
            Column(
              children: [
                buildTextFieldRow('Contract', contractRefController),
                const SizedBox(height: 10,),
                buildDropdownRow('Batch', batchController, getNameBatch(batches)),
                const SizedBox(height: 10,),
                buildDropdownRow('Structure', structureController, PayslipData.defaultStructures)
              ],
            )
          ],
        ),
      ),
      floatingActionButton: isRefFilled
          ? FloatingActionButton(
            onPressed: () {
              final newBatch = BatchData(
                batch: batchController.text,
                status: statusController.text,
                startDate: DateTime.parse(startDateController.text),
                endDate: DateTime.parse(endDateController.text),
              );
              setState(() {
                batches.add(newBatch);
              });
              Navigator.push(context, MaterialPageRoute(builder: (ctx) => BatchManage()));
            },
            child: const Icon(Icons.create),
          )
          : null,
    );
  }
}