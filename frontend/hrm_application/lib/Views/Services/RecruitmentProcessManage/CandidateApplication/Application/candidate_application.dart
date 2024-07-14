import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_application/Views/Services/RecruitmentProcessManage/CandidateApplication/application_manage.dart';
import 'package:hrm_application/Views/Services/RecruitmentProcessManage/CandidateApplication/cadidate_inf.dart';
import 'package:hrm_application/views/services/EmployeeManage/department/department_inf.dart';
import 'package:hrm_application/views/services/EmployeeManage/employee/employees_inf.dart';
import 'package:hrm_application/views/services/RecruitmentProcessManage/jobPosition/jobposition_inf.dart';
import 'package:hrm_application/widgets/colors.dart';
import 'package:progress_stepper/progress_stepper.dart';

class CandidateApplication extends StatefulWidget {
  final String? initialRole;
  final bool? showAllApplication;

  CandidateApplication({this.initialRole, this.showAllApplication});
  @override
  _CandidateApplicationState createState() => _CandidateApplicationState();
}

class _CandidateApplicationState extends State<CandidateApplication> with SingleTickerProviderStateMixin {
  TextEditingController introRoleController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController mobileController= TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController profileController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController interviewerController = TextEditingController();
  TextEditingController recruiterController = TextEditingController();
  TextEditingController elevationController = TextEditingController();
  TextEditingController availabilityController = TextEditingController();
  TextEditingController expectedSalaryController = TextEditingController();
  TextEditingController proposedSalaryController = TextEditingController();
  TextEditingController summaryController = TextEditingController();
  TextEditingController stageController = TextEditingController();
  int currentStep = 1;
  bool isNameFilled = false;
  String? selectedRole; 

  void initState() {
    super.initState();
    selectedRole = widget.initialRole;
    roleController.addListener(() {
      setState(() {
        isNameFilled = roleController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    introRoleController.dispose();
    roleController.dispose();
    nameController.dispose();
    mailController.dispose();
    mobileController.dispose();
    departmentController.dispose();
    profileController.dispose();
    degreeController.dispose();
    interviewerController.dispose();
    recruiterController.dispose();
    elevationController.dispose();
    availabilityController.dispose();
    expectedSalaryController.dispose();
    proposedSalaryController.dispose();
    summaryController.dispose();
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
                      buildTextFieldRow('LinkedIn Profile', profileController),
                      const SizedBox(height: 10),
                      buildDropdownRow('Degree', degreeController, EmployeeInf.defaultCertifications),
                      const SizedBox(height: 40),
                      const Text('JOB', style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16)),
                      const Divider(
                        thickness: 0.5,
                        color: textColor, 
                      ),
                      buildDropdownRow('Applied Job', roleController, getJobPositions(jobPositions)),
                      const SizedBox(height: 10),
                      buildDropdownRow('Department', departmentController, getDepartments()),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildDropdownRow('Interviewer', interviewerController, employees.map((employee) => employee.name).toList()),
                      const SizedBox(height: 10),
                      buildDropdownRow('Recruiter', recruiterController, employees.map((employee) => employee.name).toList()),
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
                            initialRating: double.tryParse(elevationController.text) ?? 0.0,
                            onRatingChanged: (initialRating) {
                              setState(() {
                                elevationController.text = initialRating.toString();
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
              onPressed: () {
                final newApplication = CandidateInf(
                  introRole: introRoleController.text,
                  role: roleController.text,
                  department: departmentController.text,
                  name: nameController.text,
                  mail: mailController.text,
                  mobile: mobileController.text,
                  profile: profileController.text,
                  degree: degreeController.text,
                  interviewer: interviewerController.text,
                  recruiter: recruiterController.text,
                  elevation: double.tryParse(elevationController.text),
                  availability: availabilityController.text,
                  summary: summaryController.text,
                  expectedSalary: double.tryParse(expectedSalaryController.text),
                  proposedSalary: double.tryParse(proposedSalaryController.text),
                  stage: currentStep,
                );
                setState(() {
                  candidates.add(newApplication);
                });
                Navigator.push(context, MaterialPageRoute(builder: (ctx) => ApplicationManage(initialRole: selectedRole,)));
              },
              child: const Icon(Icons.create),
            )
          : null,
    );
  }
}