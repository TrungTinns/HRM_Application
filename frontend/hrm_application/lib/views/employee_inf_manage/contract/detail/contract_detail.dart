import 'package:flutter/material.dart';
import 'package:hrm_application/components/appbar/custom_title_appbar.dart';
import 'package:hrm_application/components/configuration/configurtion.dart';
import 'package:hrm_application/views/employee_inf_manage/contract/contracts.dart';
import 'package:hrm_application/views/employee_inf_manage/contract/contracts_inf.dart';
import 'package:hrm_application/views/employee_inf_manage/department/department.dart';
import 'package:hrm_application/views/employee_inf_manage/employee/employees.dart';
import 'package:hrm_application/views/employee_inf_manage/employee/employees_inf.dart';
import 'package:hrm_application/views/employee_inf_manage/org%20chart/orgchart.dart';
import 'package:hrm_application/views/home/home.dart';
import 'package:hrm_application/widgets/colors.dart';

class ContractDetail extends StatefulWidget {
  final String employeeName;
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

  ContractDetail({
    required this.employeeName,
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
  });

  @override
  _ContractDetailState createState() => _ContractDetailState();
}

class _ContractDetailState extends State<ContractDetail> with SingleTickerProviderStateMixin {
  late TextEditingController employeeNameController;
  late TextEditingController referenceController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  late TextEditingController departmentController;
  late TextEditingController positionController;
  late TextEditingController scheduleController;
  late TextEditingController salaryStructureController;
  late TextEditingController contractTypeController;
  late TextEditingController statusController;
  String pageName = 'Contracts';
  bool showContractForm = false;
  String? activeDropdown;

  final List<String> schedules = ['Standard 40 hours/week', 'Part-time 25 hours/week'];
  final List<String> salaryStructures = ['Employee', 'Worker'];
  final List<String> contractTypes = ['Permanent', 'Temporary', 'Seasonal', 'Full-time', 'Part-time'];

  void setActiveDropdown(String? dropdown) {
    setState(() {
      activeDropdown = dropdown;
    });
  }

  void toggleContractForm() {
    if (showContractForm) {
      if (employeeNameController.text.isEmpty) {
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
          employeeNameController.clear();
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
    employeeNameController = TextEditingController(text: widget.employeeName);
    referenceController = TextEditingController(text: widget.reference);
    startDateController = TextEditingController(text: widget.startDate);
    endDateController = TextEditingController(text: widget.endDate);
    departmentController = TextEditingController(text: widget.department);
    positionController = TextEditingController(text: widget.position);
    scheduleController = TextEditingController(text: widget.schedule);
    salaryStructureController = TextEditingController(text: widget.salaryStructure);
    contractTypeController = TextEditingController(text: widget.contractType);
    statusController = TextEditingController(text: widget.status);

    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    employeeNameController.dispose();
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


  Widget buildTextFieldRow(String label, TextEditingController controller) {
    return Row(
      children: [
        SizedBox(
          width: 150,
          child: Text(
            label,
            style: const TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Expanded(
          child: TextField(
            controller: controller,
            readOnly: true,
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
                child: ElevatedButton(
                  onPressed: () {
                    toggleContractForm();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: textColor,
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text('New', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
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
                      tooltip: "Delete this contract",
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Do you want to delete this contract?'),
                              content: const Text(''),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    widget.onDelete();
                                    Navigator.pop(context); 
                                    Navigator.pop(context); 
                                  },
                                  child: const Text('OK'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel'),
                                ),
                              ],
                            );
                          },
                        );
                      },
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
      body:
          SingleChildScrollView(
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
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            buildTextFieldRow('Employee', employeeNameController),
                            const SizedBox(height: 10),
                            buildTextFieldRow('Contract Start Date', startDateController),
                            const SizedBox(height: 10),
                            buildTextFieldRow('Contract End Date', endDateController),
                            const SizedBox(height: 10),
                            buildTextFieldRow('Working Schedule', scheduleController),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          children: [
                            buildTextFieldRow('Salary Structure Type', salaryStructureController),
                            const SizedBox(height: 10),
                            buildTextFieldRow('Department', departmentController),
                            const SizedBox(height: 10),
                            buildTextFieldRow('Job Position', positionController),
                            const SizedBox(height: 10),
                            buildTextFieldRow('Contract Type', contractTypeController),
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
    );
  }
}
