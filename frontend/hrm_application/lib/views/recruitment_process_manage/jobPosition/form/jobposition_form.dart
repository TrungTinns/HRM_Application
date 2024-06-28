import 'package:flutter/material.dart';
import 'package:hrm_application/views/employee_inf_manage/department/department_inf.dart';
import 'package:hrm_application/views/employee_inf_manage/employee/employees_inf.dart';
import 'package:hrm_application/views/recruitment_process_manage/jobposition_inf.dart';
import 'package:hrm_application/views/recruitment_process_manage/recruitment.dart';
import 'package:hrm_application/widgets/colors.dart';

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

  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    roleController.addListener(() {
      setState(() {
        isNameFilled = roleController.text.isNotEmpty;
      });
    });
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
                              buildDropdownRow('Department', departmentController, getDepartments()),
                              const SizedBox(height: 10),
                              buildDropdownRow('Job Location', jobLocationController, JobPositionInf.defaultJobLocations),
                              const SizedBox(height: 10),
                              buildTextFieldRow('Email Alias', mailController),
                              const SizedBox(height: 10),
                              buildDropdownRow('Employment Type', typeController, JobPositionInf.defaultTypes),                          
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Management Authority',
                                    style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18),
                                  ),
                                  const SizedBox(width: 20),
                                  Checkbox(
                                    value: isPublished,
                                    onChanged: (value) {
                                      setState(() {
                                        isPublished = value!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              buildDropdownRow('Recruiter', recruiterController, employees.map((employee) => employee.name).toList()),
                              const SizedBox(height: 10),
                              buildDropdownRow('Interviewers', interviewerController, employees.map((employee) => employee.name).toList()),
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
              onPressed: () {
                final newJobPosition = JobPositionInf(
                  role: roleController.text,
                  department: departmentController.text,
                  jobLocation: jobLocationController.text,
                  mail: mailController.text,
                  type: typeController.text,
                  target: targetController.text.isEmpty ? 0 : int.parse(targetController.text),
                  isPublished: isPublished,
                  recruiter: recruiterController.text,
                  interviewer: interviewerController.text,
                  details: detailsController.text,
                );
                setState(() {
                  jobPositions.add(newJobPosition);
                });
                Navigator.push(context, MaterialPageRoute(builder: (ctx) => RecruitmentManage()));
              },
              child: const Icon(Icons.create),
            )
          : null,
    );
  }
}