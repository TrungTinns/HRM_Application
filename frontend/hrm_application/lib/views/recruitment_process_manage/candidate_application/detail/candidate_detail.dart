import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:hrm_application/views/recruitment_process_manage/candidate_application/application/candidate_application.dart';
import 'package:hrm_application/views/recruitment_process_manage/candidate_application/application_manage.dart';
import 'package:hrm_application/views/recruitment_process_manage/candidate_application/cadidate_inf.dart';
import 'package:hrm_application/views/recruitment_process_manage/candidate_application/progress/application_progress.dart';
import 'package:hrm_application/views/recruitment_process_manage/jobPosition/jobposition_inf.dart';
import 'package:hrm_application/views/recruitment_process_manage/jobPosition/recruitment.dart';
import 'package:hrm_application/components/appbar/custom_title_appbar.dart';
import 'package:hrm_application/components/configuration/configurtion.dart';
import 'package:hrm_application/views/employee_inf_manage/contract/contracts.dart';
import 'package:hrm_application/views/employee_inf_manage/department/department_inf.dart';
import 'package:hrm_application/views/employee_inf_manage/employee/employees_inf.dart';
import 'package:hrm_application/views/home/home.dart';
import 'package:hrm_application/widgets/colors.dart';
import 'package:progress_stepper/progress_stepper.dart';
class CandidateDetail extends StatefulWidget {
  final String introRole;
  final String role;
  final String name;
  final String mail;
  final String mobile;
  final String department;
  final String? profile;
  final String? degree;
  final String? interviewer;
  final String? recruiter;
  double? elevation;
  final String? availability;
  final double? expectedSalary;
  final double? proposedSalary;
  final String? summary;
  final VoidCallback onDelete;
  // final ValueChanged<CandidateInf> onUpdate;
  final int stage;

  CandidateDetail({
    required this.introRole,
    required this.role,
    required this.name,
    required this.mail,
    required this.mobile,
    required this.department,
    this.profile,
    this.degree,
    this.interviewer,
    this.recruiter,
    this.elevation,
    this.availability,
    this.expectedSalary,
    this.proposedSalary,
    this.summary,
    required this.onDelete,
    // required this.onUpdate,
    required this.stage,
  });

  @override
  _CandidateDetailState createState() => _CandidateDetailState();
}

class _CandidateDetailState extends State<CandidateDetail> with SingleTickerProviderStateMixin {
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
  bool isPublished = false;

  String pageName = 'Applications';
  bool showCandidateApplication = false;
  String? activeDropdown;
  bool isChanged = false;
  int currentStep = 0;

  void setActiveDropdown(String? dropdown) {
    setState(() {
      activeDropdown = dropdown;
    });
  }

  void toggleCandidateApplication() {
    if (showCandidateApplication) {
      if(introRoleController.text.isEmpty) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Incomplete Form'),
              content: const Text('Information is missing.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        setState(() {
          introRoleController.clear();
        });
      }
    } else {
      setState(() {
        showCandidateApplication = true;
      });
    }
  }
  
  void clearCandidateApplication() {
    setState(() {
      showCandidateApplication = false;
      Navigator.push(context, MaterialPageRoute(builder: (ctx) => ApplicationManage()));
    });
  }

  void deleteCandidate() {
  int index = candidates.indexWhere((candidate) => candidate.name == widget.name);
  if (index != -1) {
    setState(() {
      candidates.removeAt(index);
    });
    Navigator.pop(context);
  }
}

  @override
  void initState() {
    super.initState();
    introRoleController.text = widget.introRole;
    roleController.text = widget.role;
    nameController.text = widget.name;
    mailController.text = widget.mail;
    mobileController.text = widget.mobile;
    departmentController.text = widget.department;
    profileController.text = widget.profile ?? '';
    degreeController.text = widget.degree ?? '';
    interviewerController.text = widget.interviewer ?? '';
    recruiterController.text = widget.recruiter ?? '';
    elevationController.text = widget.elevation?.toString() ?? '';
    availabilityController.text = widget.availability ?? '';
    expectedSalaryController.text = widget.expectedSalary?.toString() ?? '';
    proposedSalaryController.text = widget.proposedSalary?.toString() ?? '';
    summaryController.text = widget.summary ?? '';
    currentStep = widget.stage;
  }

  @override
  void dispose() {
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
            value: controller.text.toString(),
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
        title: 
        CustomTitleAppbar(
          ctx: context,
          service: 'Recruitment',
          titles: const ['Applications', 'Reporting'],
          options: const [
            ['By Job Positions', 'All Applications'],
            ['Recruitment Analysis', 'Source Analysis', 'Time In Stage Analysis', 'Team Performance']
          ],
          optionNavigations: [
            [
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => RecruitmentManage())),
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => ApplicationManage())),
            ],
            [
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Contracts())),
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Contracts())),
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
            titles: const ['', 'Job Positons', 'Applications', 'Employees', 'Activities'],
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
          )
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child:  Row(
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
                            
                          } else {
                            toggleCandidateApplication();
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
                      tooltip: showCandidateApplication ? "Discard all changes" : "Delete this department",
                      onPressed: showCandidateApplication ? clearCandidateApplication : () {
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
                                    deleteCandidate();
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
      body: showCandidateApplication
          ? CandidateApplication()
      : SingleChildScrollView(
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
                  isChanged = true;
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
                        onChanged: (value) {
                          setState(() {
                            isChanged = true;
                          });
                        },
                        style: const TextStyle(color: textColor, fontSize: 40.0),
                        decoration: const InputDecoration(
                          hintText: "Subject/Application",
                          hintStyle: TextStyle(color: termTextColor, fontSize: 40.0),
                        ),
                      ),
                      TextField(
                        controller: nameController,
                        onChanged: (value) {
                          setState(() {
                            isChanged = true;
                          });
                        },
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
                            initialRating: double.parse(elevationController.text),
                            onRatingChanged: (value) {
                              setState(() {
                                elevationController.text = value.toString();
                                isChanged = true;
                              });
                            },
                            maxRating: 3,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      buildTextFieldRow('Availability', availabilityController),
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
              onChanged: (value) {
                setState(() {
                  isChanged = true;
                });
              },
              style: const TextStyle(color: textColor, fontSize: 18.0),
              decoration: const InputDecoration(
                hintText: "Motivation and experience",
                hintStyle: TextStyle(color: termTextColor, fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 