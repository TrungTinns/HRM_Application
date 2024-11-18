import 'package:flutter/material.dart';
import 'package:hrm_application/API/api.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Contract/Data/contracts_data.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Department/Data/department_data.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Employee/Data/employees_data.dart';
import 'package:hrm_application/Views/Services/RecruitmentProcessManage/JobPosition/Data/jobposition_data.dart';
import 'package:hrm_application/views/services/RecruitmentProcessManage/jobPosition/recruitment.dart';
import 'package:hrm_application/widgets/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class JobPositionForm extends StatefulWidget {
  @override
  _JobPositionFormState createState() => _JobPositionFormState();
}

class _JobPositionFormState extends State<JobPositionForm> with SingleTickerProviderStateMixin {
  TextEditingController roleController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController jobLocationController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController targetController = TextEditingController();
  TextEditingController recruiterController = TextEditingController();
  TextEditingController interviewerController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  bool isPublished = false;
  TabController? tabController;
  bool isNameFilled = false;
  List<DepartmentData> departments = [];
  List<String> departmentNames = [];
  String selectedId = '';
  List<EmployeeData> employees = [];
  List<String> employeeNames = [];

  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    roleController.addListener(() {
      setState(() {
        isNameFilled = roleController.text.isNotEmpty;
      });
    });
    fetchAndSetDepartments();
    fetchAndSetEmployees();
  }

  void _handleSelectionRecruiterId(String recruiterId) {
    setState(() {
      selectedId = recruiterId;
    });
  }

  void _handleSelectionInterviewerId(String interviewerId) {
    setState(() {
      selectedId = interviewerId;
    });
  }

  Future<void> fetchAndSetDepartments() async {
    try {
      departments = await fetchDepartments();
      setState(() {
        departmentNames = departments.map((dept) => dept.department).toList();
        departmentNames.sort((a, b) => a.compareTo(b));
      });
    } catch (e) {
      print('Error fetching departments: $e');
    }
  }

    Future<void> fetchAndSetEmployees() async {
    try {
      employees = await fetchEmployees();
      setState(() {
        employeeNames = employees.map((emp) => emp.name).toList();
        employeeNames.sort((a, b) => a.compareTo(b));
      });
    } catch (e) {
      print('Error fetching employees: $e');
    }
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
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

  Widget buildDropdownRowAPI(String label, TextEditingController controller, List<Map<String, String>> items, {Function(String)? onChanged}) {
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
            value: controller.text.isEmpty ? null : controller.text,
            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: item['id'],
                child: Text(item['name']!, style: const TextStyle(color: textColor)),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                controller.text = value!;
                if (onChanged != null) {
                  onChanged(value);
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

  Future<void> createjobPosition() async {
    final url = Uri.parse('http://localhost:9002/api/v1/recruitment/jobPosition');

    final jobPosition = {
      'id': '',
      'name': roleController.text.isNotEmpty ? roleController.text : '',
      'department': departmentController.text.isNotEmpty ? departmentController.text : '',
      'jobLocation': jobLocationController.text.isNotEmpty? jobLocationController.text : '',
      'empType': typeController.text.isNotEmpty? typeController.text : '',
      'mailAlias': mailController.text.isNotEmpty? mailController.text : '',
      'target': int.tryParse(targetController.text) ?? 0,
      'recruiterId':  selectedId.isNotEmpty? selectedId : '',
      'interviewers': selectedId.isNotEmpty? selectedId : '',
      'description': detailsController.text.isNotEmpty? detailsController.text : '',
    };
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(jobPosition),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Create job position successfully')),
        );
      } else {
        print('Failed to create job position: ${response.body}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error creating job position: $e')),
      );
    }
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
                        controller: roleController,
                        style: const TextStyle(color: textColor, fontSize: 40.0),
                        decoration: const InputDecoration(
                          hintText: "Job Position",
                          hintStyle: TextStyle(color: termTextColor, fontSize: 40.0),
                        ),
                      ),
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
                Tab(text: 'Recruitment'),
                Tab(text: 'Details'),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 300,
              child: TabBarView(
                controller: tabController,
                children: [
                  SingleChildScrollView(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildDropdownRow('Department', departmentController, departmentNames),
                              const SizedBox(height: 10),
                              buildDropdownRow('Job Location', jobLocationController, JobPositionData.defaultJobLocations),
                              const SizedBox(height: 10),
                              buildTextFieldRow('Email Alias', mailController),
                              const SizedBox(height: 10),
                              buildDropdownRow('Employment Type', typeController, ContractData.defaultContractTypes),                          
                            ]
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildTextFieldRow('Target', targetController),
                              const SizedBox(height: 10),
                              buildDropdownRowAPI(
                                'Recruiter',
                                recruiterController,
                                employees.map((mgr) => {'id': mgr.id, 'name': mgr.name}).toList(),
                                onChanged: _handleSelectionRecruiterId
                              ),
                              const SizedBox(height: 10),
                              buildDropdownRowAPI(
                                'Interviewer',
                                interviewerController,
                                employees.map((mgr) => {'id': mgr.id, 'name': mgr.name}).toList(),
                                onChanged: _handleSelectionInterviewerId,
                              ),
                            ]
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildTextFieldRow('Details', detailsController),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: isNameFilled
          ? FloatingActionButton(
              onPressed: () async {
                await createjobPosition();
                Navigator.push(context, MaterialPageRoute(builder: (ctx) => RecruitmentManage()));
              },
              child: const Icon(Icons.create),
            )
          : null,
    );
  }
}