import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Department/Data/department_data.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Employee/Data/employees_data.dart';
import 'package:hrm_application/Views/Services/RecruitmentProcessManage/CandidateApplication/application_manage.dart';
import 'package:hrm_application/Views/Services/RecruitmentProcessManage/JobPosition/Data/jobposition_data.dart';
import 'package:hrm_application/widgets/colors.dart';
import 'package:progress_stepper/progress_stepper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CandidateApplication extends StatefulWidget {
  final String? initialRole;
  final bool? showAllApplication;

  CandidateApplication({this.initialRole, this.showAllApplication});
  @override
  _CandidateApplicationState createState() => _CandidateApplicationState();
}

class _CandidateApplicationState extends State<CandidateApplication> with SingleTickerProviderStateMixin {
  TextEditingController subjectController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController mobileController= TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController interviewerController = TextEditingController();
  TextEditingController recruiterController = TextEditingController();
  TextEditingController introRoleController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController sourceController = TextEditingController();
  TextEditingController evaluationController = TextEditingController();
  TextEditingController availabilityController = TextEditingController();
  TextEditingController expectedSalaryController = TextEditingController();
  TextEditingController proposedSalaryController = TextEditingController();
  TextEditingController summaryController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController stageController = TextEditingController();
  int currentStep = 1;
  bool isNameFilled = false;
  String? selectedRole;
  List<DepartmentData> departments = [];
  List<String> departmentNames = [];
  String selectedIId = '';
String selectedJPId = '';
String selectedRId = '';

  List<EmployeeData> employees = [];
  List<String> employeeNames = [];
  List<JobPositionData> jobPositions = [];
  List<String> jobPositionNames = [];

  void initState() {
    super.initState();
    selectedRole = widget.initialRole;
    introRoleController.addListener(() {
      setState(() {
        isNameFilled = introRoleController.text.isNotEmpty;
      });
    });
    fetchAndSetDepartments();
    fetchAndSetEmployees();
  }

  void _handleSelectionRecruiterId(String recruiterId) {
    setState(() {
      selectedRId = recruiterId;
    });
  }

  void _handleSelectionJobId(String jobPositionId) {
    setState(() {
      selectedJPId = jobPositionId;
    });
  }

  void _handleSelectionInterviewerId(String interviewerId) {
    setState(() {
      selectedIId = interviewerId;
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

  Future<void> fetchAndSetJobs() async {
    try {
      jobPositions = await fetchJobPositions();
      setState(() {
        jobPositionNames = jobPositions.map((jp) => jp.name).toList();
        jobPositionNames.sort((a, b) => a.compareTo(b));
      });
    } catch (e) {
      print('Error fetching employees: $e');
    }
  }

  @override
  void dispose() {
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

  Future<void> createCandidate() async {
    final url = Uri.parse('http://localhost:9002/api/v1/recruitment/candidate');

    final candidate = {
      'id': '',
      'name': nameController.text.isNotEmpty ? nameController.text : '',
      'subject': subjectController.text.isNotEmpty ? subjectController.text : '',
      'mail': mailController.text.isNotEmpty ? mailController.text : '',
      'mobile': mobileController.text.isNotEmpty ? mobileController.text : '',
      'profileAddress': '',
      'degree': degreeController.text.isNotEmpty ? degreeController.text : '',
      'interviewerId': selectedIId.isNotEmpty ? selectedIId : '',
      'recruiterId': selectedRId.isNotEmpty ? selectedRId : '',
      'appliedJob': introRoleController.text.isEmpty ? introRoleController : '',
      'department': departmentController.text.isNotEmpty ? departmentController.text : '',
      'source': sourceController.text.isNotEmpty ? sourceController.text : '',
      'medium': '',
      'availability': availabilityController.text.isNotEmpty ? availabilityController.text : DateTime.now().toIso8601String(),
      'evaluation': double.tryParse(evaluationController.text) ?? 0.0,
      'expectedSalary': double.tryParse(expectedSalaryController.text) ?? 0.0,
      'proposedSalary': double.tryParse(proposedSalaryController.text) ?? 0.0,
      'applicationSummary': summaryController.text.isNotEmpty ? summaryController.text : '',
      'jobPositionId': selectedJPId.isNotEmpty ? selectedJPId : '',
      'stage': int.tryParse(stageController.text) ?? 0,
    };
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(candidate),
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

  Widget buildTextFieldRow(String label, TextEditingController controller, {bool isDateField = false}) {
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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: snackBarColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProgressStepper(
              width: 1000,
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
              stepCount: 6, 
              labels: const <String>[
                'New', 
                'Initial Qualification', 
                'First Interview', 
                'Second Interview', 
                'Contract Proposal', 
                'Contract Signed'
              ],
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: introRoleController,
                        style: const TextStyle(color: textColor, fontSize: 40.0),
                        decoration: const InputDecoration(
                          hintText: "Subject/Application",
                          hintStyle: TextStyle(color: termTextColor, fontSize: 40.0),
                        ),
                      ),
                      TextField(
                        controller: nameController,
                        style: const TextStyle(color: textColor, fontSize: 20.0),
                        decoration: const InputDecoration(
                          hintText: "Applicant's Name",
                          hintStyle: TextStyle(color: termTextColor, fontSize: 20.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTextFieldRow('Email', mailController),
                      const SizedBox(height: 10),
                      buildTextFieldRow('Mobile', mobileController),
                      const SizedBox(height: 10),
                      buildTextFieldRow('Subject', subjectController),
                      const SizedBox(height: 10),
                      buildTextFieldRow('LinkedIn Profile', sourceController),
                      const SizedBox(height: 10),
                      buildDropdownRow('Degree', degreeController, EmployeeData.defaultCertifications),
                      const SizedBox(height: 40),
                      const Text('JOB', style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16)),
                      const Divider(
                        thickness: 0.5,
                        color: textColor,
                      ),
                      buildDropdownRowAPI(
                                'Applied Job',
                                jobController,
                                jobPositions.map((mgr) => {'id': mgr.id, 'name': mgr.name}).toList(),
                                onChanged: _handleSelectionJobId
                              ),
                      const SizedBox(height: 10),
                      buildDropdownRow('Department', departmentController, departmentNames),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Elevation',
                            style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const SizedBox(width: 120),
                          RatingBar(
                            filledIcon: Icons.star,
                            emptyIcon: Icons.star_border,
                            initialRating: double.tryParse(evaluationController.text) ?? 0.0,
                            onRatingChanged: (initialRating) {
                              setState(() {
                                evaluationController.text = initialRating.toString();
                              });
                            },
                            maxRating: 3,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      buildTextFieldRow('Availability', availabilityController, isDateField: true),
                      const SizedBox(height: 40),
                      const Text('CONTRACT', style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16)),
                      const Divider(
                        thickness: 0.5,
                        color: textColor, 
                      ),
                      buildTextFieldRow('Expected Salary', expectedSalaryController),
                      const SizedBox(height: 10),
                      buildTextFieldRow('Proposed Salary', proposedSalaryController),
                    ],
                  ),
                ),
              ]
            ),
            const SizedBox(height: 40),
            const Text('APPLICATION SUMMARY', style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16)),
            const Divider(
              thickness: 0.5,
              color: textColor, 
            ),
            TextField(
              controller: summaryController,
              style: const TextStyle(color: textColor, fontSize: 18.0),
              decoration: const InputDecoration(
                hintText: "Motivation and experience",
                hintStyle: TextStyle(color: termTextColor, fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: isNameFilled
          ? FloatingActionButton(
              onPressed: () async {
                await createCandidate();
                Navigator.push(context, MaterialPageRoute(builder: (ctx) => ApplicationManage(initialRole: selectedRole,)));
              },
              child: const Icon(Icons.create),
            )
          : null,
    );
  }
}