import 'package:flutter/material.dart';
import 'package:hrm_application/components/appbar/custom_title_appbar.dart';
import 'package:hrm_application/components/configuration/configurtion.dart';
import 'package:hrm_application/views/employee_inf_manage/contract/contracts.dart';
import 'package:hrm_application/views/employee_inf_manage/contract/contracts_inf.dart';
import 'package:hrm_application/views/employee_inf_manage/contract/form/contract_form.dart';
import 'package:hrm_application/views/employee_inf_manage/department/department.dart';
import 'package:hrm_application/views/employee_inf_manage/employee/employees.dart';
import 'package:hrm_application/views/employee_inf_manage/employee/employees_inf.dart';
import 'package:hrm_application/views/employee_inf_manage/org%20chart/orgchart.dart';
import 'package:hrm_application/views/home/home.dart';
import 'package:hrm_application/widgets/colors.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ContractDetail extends StatefulWidget {
  final String name;
  final String reference;
  final String department;
  final String position;
  final String startDate;
  final String endDate;
  final String salaryStructure;
  final String contractType;
  final String schedule;
  final String status;
  final VoidCallback onDelete;
  final ValueChanged<ContractData> onUpdate;
  final double? salary;
  final String? note;

  ContractDetail({
    required this.name,
    required this.reference,
    required this.department,
    required this.position,
    required this.startDate,
    required this.endDate,
    required this.salaryStructure,
    required this.contractType,
    required this.schedule,
    required this.status,
    required this.onDelete,
    required this.onUpdate,
    this.salary,
    this.note,
  });

  @override
  _ContractDetailState createState() => _ContractDetailState();
}

class _ContractDetailState extends State<ContractDetail> with SingleTickerProviderStateMixin {
  late TextEditingController nameController;
  late TextEditingController referenceController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  late TextEditingController departmentController;
  late TextEditingController positionController;
  late TextEditingController scheduleController;
  late TextEditingController salaryStructureController;
  late TextEditingController contractTypeController;
  late TextEditingController statusController;
  late TextEditingController salaryController;
  late TextEditingController noteController;
  String pageName = 'Contracts';
  bool showContractForm = false;
  String? activeDropdown;
  bool isChanged = false;
  late int toggleIndex;

  void setActiveDropdown(String? dropdown) {
    setState(() {
      activeDropdown = dropdown;
    });
  }

  void toggleContractForm() {
    if (showContractForm) {
      if (referenceController.text.isEmpty) {
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
          referenceController.clear();
          
        });
      }
    } else {
      setState(() {
        showContractForm = true;
      });
    }
  }

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    referenceController = TextEditingController(text: widget.reference);
    startDateController = TextEditingController(text: formatDate(DateTime.parse(widget.startDate)));
    endDateController = TextEditingController(text: formatDate(DateTime.parse(widget.endDate)));
    departmentController = TextEditingController(text: widget.department);
    positionController = TextEditingController(text: widget.position);
    scheduleController = TextEditingController(text: widget.schedule);
    salaryStructureController = TextEditingController(text: widget.salaryStructure);
    contractTypeController = TextEditingController(text: widget.contractType); 
    statusController = TextEditingController(text: widget.status);
    toggleIndex = ContractData.defaultStatus.indexOf(widget.status);
    salaryController = TextEditingController(text: widget.salary.toString());
    noteController = TextEditingController(text: widget.note);
    tabController = TabController(length: 2, vsync: this);
  }

  String formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    tabController.dispose();
    nameController.dispose();
    referenceController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    departmentController.dispose();
    positionController.dispose();
    scheduleController.dispose();
    salaryStructureController.dispose();
    contractTypeController.dispose();
    statusController.dispose();
    super.dispose();
  }

  void clearDepartmentForm() {
    setState(() {
      showContractForm = false;
      departmentController.clear();
      positionController.clear();
      scheduleController.clear();
      salaryStructureController.clear();
      contractTypeController.clear();
      statusController.clear();
      salaryController.clear();
      noteController.clear();
      Navigator.push(context, MaterialPageRoute(builder: (ctx) => Contracts()));
    });
  }

  void _updateEmployeeInfo(EmployeeInf employee) {
    setState(() {
      departmentController.text = employee.department;
      positionController.text = employee.role;
    });
  }

  void deleteContract(String reference){
    setState(() {
      contracts.removeWhere((contract) => contract.reference == reference );
    });
  }

  void saveChanges() {
    final updatedContract= ContractData(
      name: nameController.text,
      reference: referenceController.text,
      department: departmentController.text,
      position: positionController.text,
      startDate: DateTime.parse("${startDateController.text} 00:00:00"),
      endDate: DateTime.parse("${endDateController.text} 00:00:00"),
      schedule: scheduleController.text,
      salaryStructure: salaryStructureController.text,
      contractType: contractTypeController.text,
      status: statusController.text,
      salary: double.parse(salaryController.text),
      note: noteController.text
    );
    widget.onUpdate(updatedContract);
    Navigator.pop(context);
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

Widget buildDropdownRow(String label, List<dynamic> items, TextEditingController controller) {
  dynamic currentValue = controller.text;
  if (!items.any((item) => item.toString() == currentValue)) {
    currentValue = items.first.toString();
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
        child: DropdownButtonFormField<dynamic>(
          dropdownColor: dropdownColor,
          value: currentValue,
          items: items.map((item) {
            return DropdownMenuItem<dynamic>(
              value: item,
              child: Text(item is EmployeeInf ? item.name : item.toString(), style: const TextStyle(color: textColor)),
            );
          }).toList(),
          onChanged: (selectedItem) {
            setState(() {
              if (selectedItem is EmployeeInf) {
                _updateEmployeeInfo(selectedItem);
              } else {
                controller.text = selectedItem.toString();
              }
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
          service: pageName,
          titles: const ['Employees', 'Reporting'],
          options: const [
            ['Employees', 'Department', 'Contracts', 'Org Chart'],
            ['Contracts', 'Skills']
          ],
          optionNavigations: [
            [
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => EmployeeManage())),
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Department())),
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Contracts())),
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => OrgChartManage())),
            ],
            [
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
            ],
          ],
          activeDropdowns: const ['Employees', 'Reporting'],
          setActiveDropdown: (dropdown) {
            setState(() {
              activeDropdown = dropdown;
            });
          },
          config: configuration(
            isActive: activeDropdown == 'Configuration',
            onOpen: () => setActiveDropdown('Configuration'),
            onClose: () => setActiveDropdown(null),
            titles: const ['Setting', 'Employee', 'Recruitment'],
            options: const [
              ['Setting', 'Activity Plan'],
              ['Departments', 'Work Locations', 'Working Schedules', 'Departure Reasons', 'Skill Types'],
              ['Job Positions', 'Employment Types']
            ],
            navigators: [
              [
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
              ],
              [
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
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
                            toggleContractForm();
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
                      tooltip: showContractForm ? "Discard all changes" : "Delete this department",
                      onPressed: showContractForm ? clearDepartmentForm : () {
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
      body: showContractForm
      ? ContractForm()
        : SingleChildScrollView(
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
                              onChanged: (value) {
                                setState(() {
                                  isChanged = true;
                                });
                              },
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
                        labels: const ['Running', 'Expired', 'Cancelled'],
                        icons: const [Icons.play_arrow, Icons.hourglass_empty, Icons.cancel],
                        activeBgColors: const [[Colors.green], [Colors.orange], [Colors.red]],
                        onToggle: (index) {
                          setState(() {
                            toggleIndex = index!;
                            statusController.text = ['Running', 'Expired', 'Cancelled'][index];
                            isChanged = true;
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
                            buildDropdownRow('Employee',  employees.map((employee) => employee.name).toList(), nameController),
                            const SizedBox(height: 10),
                            buildTextFieldRow('Contract Start Date', startDateController),
                            const SizedBox(height: 10),
                            buildTextFieldRow('Contract End Date', endDateController),
                            const SizedBox(height: 10),
                            buildDropdownRow('Working Schedule', ContractData.defaultSchedules, scheduleController),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          children: [
                            buildDropdownRow('Salary Structure Type', ContractData.defaultSalaryStructures, salaryStructureController),
                            const SizedBox(height: 10),
                            buildTextFieldRow('Department', departmentController),
                            const SizedBox(height: 10),
                            buildTextFieldRow('Job Position', positionController),
                            const SizedBox(height: 10),
                            buildDropdownRow('Contract Type', ContractData.defaultContractTypes, contractTypeController),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TabBar(
                    labelColor: textColor,
                    unselectedLabelColor: termTextColor,
                    controller: tabController,
                    labelStyle: const TextStyle(color: textColor, fontSize: 16),
                    tabs: const [
                      Tab(text: 'Salary Information'),
                      Tab(text: 'Contract Details'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 200,
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              buildTextFieldRow('Wages/salaries', salaryController),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              const Text('NOTE', style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16)),
                              const Divider(
                                thickness: 0.5,
                                color: textColor, 
                              ),
                              buildTextFieldRow('Note', noteController),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
