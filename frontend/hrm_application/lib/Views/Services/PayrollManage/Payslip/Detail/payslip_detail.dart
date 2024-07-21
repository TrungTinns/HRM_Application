import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_application/Component/Appbar/custom_title_appbar.dart';
import 'package:hrm_application/Component/Configuration/configuration.dart';
import 'package:hrm_application/Views/Home/home.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Contract/contracts.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Contract/contracts_inf.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Employee/employees_inf.dart';
import 'package:hrm_application/Views/Services/PayrollManage/Batch/Form/batch_form.dart';
import 'package:hrm_application/Views/Services/PayrollManage/Batch/batch.dart';
import 'package:hrm_application/Views/Services/PayrollManage/Batch/batches_inf.dart';
import 'package:hrm_application/Views/Services/PayrollManage/Dashboard/payroll_manage.dart';
import 'package:hrm_application/Views/Services/PayrollManage/Payslip/Form/payslip_form.dart';
import 'package:hrm_application/Views/Services/PayrollManage/Payslip/payslips.dart';
import 'package:hrm_application/Views/Services/PayrollManage/Payslip/payslips_inf.dart';
import 'package:hrm_application/widgets/colors.dart';
import 'package:progress_stepper/progress_stepper.dart';

class PayslipDetail extends StatefulWidget {
  final String name;
  final String reference;
  final String contractRef;
  final String startDate;
  final String endDate;
  final String batch;
  final String structure;
  final String others;
  final String status;
  final VoidCallback onDelete;
  final ValueChanged<PayslipData> onUpdate;

  PayslipDetail({
    required this.name,
    required this.reference,
    required this.contractRef,
    required this.startDate,
    required this.endDate,
    required this.batch,
    required this.structure,
    required this.others,
    required this.status,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  _PayslipDetailState createState() => _PayslipDetailState();
}

class _PayslipDetailState extends State<PayslipDetail> with SingleTickerProviderStateMixin {
  late TextEditingController nameController;
  late TextEditingController statusController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  late TextEditingController referenceController;
  late TextEditingController contractRefController;
  late TextEditingController batchController;
  late TextEditingController structureController;
  late TextEditingController othersController;
  String pageName = 'Employee Payslips';
  bool showPayslipForm = false;
  String? activeDropdown;
  bool isChanged = false;
  late int currentStep;

  void setActiveDropdown(String? dropdown) {
    setState(() {
      activeDropdown = dropdown;
    });
  }

  void togglePayslipForm() {
    if (showPayslipForm) {
      if (nameController.text.isEmpty) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Incomplete Form'),
              content: const Text('Name field is missing.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        setState(() {
          nameController.clear();
        });
      }
    } else {
      setState(() {
        showPayslipForm = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    batchController = TextEditingController(text: widget.batch);
    startDateController = TextEditingController(text: formatDate(DateTime.parse(widget.startDate)));
    endDateController = TextEditingController(text: formatDate(DateTime.parse(widget.endDate)));
    referenceController = TextEditingController(text: widget.reference);
    contractRefController = TextEditingController(text: widget.contractRef);
    nameController = TextEditingController(text: widget.name);
    structureController = TextEditingController(text: widget.structure);
    othersController = TextEditingController(text: widget.others);
    statusController = TextEditingController(text: widget.status);
    currentStep = PayslipData.defaultStatus.indexOf(widget.status)+1;
  }

  String formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    batchController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    statusController.dispose();
    referenceController.dispose();
    contractRefController.dispose();
    nameController.dispose();
    structureController.dispose();
    othersController.dispose();
    super.dispose();
  }

  void clearPayslipForm() {
    setState(() {
      showPayslipForm = false;
      Navigator.push(context, MaterialPageRoute(builder: (ctx) => PayrollManage()));
    });
  }

  void deletePayslip(String name){
    setState(() {
      payslips.removeWhere((payslip) => payslip.name == name );
    });
  }

  void saveChanges() {
    final updatedPayslip = PayslipData(
      batch: batchController.text,
      name: nameController.text,
      reference: referenceController.text,
      contractRef: contractRefController.text,
      startDate: DateTime.parse("${startDateController.text} 00:00:00"),
      endDate: DateTime.parse("${endDateController.text} 00:00:00"),
      status: PayslipData.defaultStatus[currentStep-1],
      structure: structureController.text,
      others: othersController.text,
    );
    widget.onUpdate(updatedPayslip);
    Navigator.pop(context);
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
          content: Text('No contract found for this employee. Would you like to create one?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Create'),
              onPressed: () {
                // Here you would navigate to a contract creation form or implement the logic to create a new contract
                // For now, we'll just close the dialog
                Navigator.of(context).pop();
                // You might want to call a method here to create a new contract
                // createNewContract(employeeName);
              },
            ),
          ],
        );
      },
    );
  }


  Widget buildTextFieldRow(String label, TextEditingController controller) {
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
          child: TextField(
            controller: controller,
            onChanged: (value) {
              setState(() {
                isChanged = true;
              });
            },
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
    if (!items.contains(controller.text)) {
      controller.text = items.isNotEmpty ? items.first : '';
    }
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
            value: controller.text,
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: const TextStyle(color: textColor)),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                controller.text = value!;
                isChanged = true;
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomTitleAppbar(
          ctx: context,
          service: 'Payroll',
          titles: const ['Dashboard', 'Contracts', 'Work Entries', 'Payslips', 'Reporting'],
          options: const [
            [],
            ['Contracts', 'Salary Attachments'],
            ['Work Entries', 'Time Off'],
            ['All Payslips', 'Batches'],
            ['By Job Positions', 'All Applications'],
            ['Recruitment Analysis', 'Source Analysis', 'Time In Stage Analysis', 'Team Performance']
          ],
          optionNavigations: [
            [ () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => PayrollManage())),
            ],
            [
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Contracts())),
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Home())),
            ],
            [
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Home())),
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Home())),
            ],
            [
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => PayslipManage())),
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => BatchManage())),
            ],
            [
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Home())),
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Home())),
            ],
            [
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Home())),
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Home())),
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Home())),
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Home())),
            ],
          ],
          activeDropdowns: const ['Applications', 'Reporting'],
          setActiveDropdown: (dropdown) {
            setState(() {
              activeDropdown = dropdown;
            });
          },
          config: configuration(
            isActive: activeDropdown == 'Configuration',
            onOpen: () => setActiveDropdown('Configuration'),
            onClose: () => setActiveDropdown(null),
            titles: const ['', 'Job Positions', 'Applications', 'Employees', 'Activities'],
            options: const [
              ['Setting'],
              ['Employment Types'],
              ['Refuse Reasons'],
              ['Departments', 'Skill Types'],
              ['Activities Types', 'Activity Plans'],
            ],
            navigators: [
              [
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
              ],
              [
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
              ],
              [
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
              ],
              [
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
              ],
              [
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
              ],
            ],
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (isChanged) {
                            saveChanges();
                          } else {
                            togglePayslipForm();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: textColor,
                          backgroundColor: primaryColor ,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          isChanged ? 'Save' : 'New',
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    Text(
                      pageName,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    IconButton(
                      icon: const Icon(Icons.upload),
                      color: Colors.white,
                      onPressed: () {},
                      tooltip: "Import records",
                    ),
                    IconButton(
                      icon: const Icon(Icons.clear),
                      color: Colors.white,
                      iconSize: 24,
                      tooltip: showPayslipForm ? "Discard all changes" : "Delete this department",
                      onPressed: showPayslipForm ? clearPayslipForm: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Do you want to delete this department?'),
                              content: const Text(''),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    widget.onDelete();
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: snackBarColor,
      ),
      backgroundColor: snackBarColor,
      body: showPayslipForm
          ? PayslipForm()
          : Padding(
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
                                nameController.text = value!;
                                // String? contractRef = findContractReference(value);
                                // if (contractRef != null) {
                                //   contractRefController.text = contractRef;
                                // } else {
                                //   contractRefController.text = '';
                                //   showCreateContractDialog(value);
                                // }
                                isChanged = true;
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
                            statusController.text = PayslipData.defaultStatus[index-1];
                            isChanged = true;
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
                            isChanged = true;
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
                            isChanged = true;
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
    );
  }
}