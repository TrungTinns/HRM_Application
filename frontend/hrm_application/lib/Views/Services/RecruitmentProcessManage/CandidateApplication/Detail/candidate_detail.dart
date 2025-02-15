
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:hrm_application/Component/Appbar/custom_title_appbar.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Contract/contracts.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Department/Data/department_data.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Employee/Data/employees_data.dart';
import 'package:hrm_application/Views/Services/RecruitmentProcessManage/CandidateApplication/Application/candidate_application.dart';
import 'package:hrm_application/Views/Services/RecruitmentProcessManage/CandidateApplication/application_manage.dart';
import 'package:hrm_application/Views/Services/RecruitmentProcessManage/JobPosition/Data/jobposition_data.dart';
import 'package:hrm_application/Views/Services/RecruitmentProcessManage/JobPosition/recruitment.dart';
import 'package:hrm_application/Views/home/home.dart';
import 'package:hrm_application/widgets/colors.dart';
import 'package:progress_stepper/progress_stepper.dart';

class CandidateDetail extends StatefulWidget {
  final String? initialRole;
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
  final int stage;
  final bool isRefused;

  CandidateDetail({
    this.initialRole,
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
    this.elevation = 0,
    this.availability,
    this.expectedSalary,
    this.proposedSalary,
    this.summary,
    required this.stage,
    required this.isRefused,
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
  String? selectedRole; 
  bool isRefused = false; 

  List<JobPositionData> jobPositions = [];
  List<String> roleNames = [];
  List<DepartmentData> departments = [];
  List<String> departmentNames = [];
  List<EmployeeData> employees = [];
  List<String> employeeNames = [];

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

  Future<void> fetchAndSetjobPositions() async {
    try {
      jobPositions = await fetchJobPositions();
      setState(() {
        roleNames = jobPositions.map((dept) => dept.name).toList();
        roleNames.sort((a, b) => a.compareTo(b));
      });
    } catch (e) {
      print('Error fetching departments: $e');
    }
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
        employeeNames = employees.map((mgr) => mgr.name).toList();
        employeeNames.sort((a, b) => a.compareTo(b));
      });
    } catch (e) {
      print('Error fetching managers: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    selectedRole = widget.role;
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
    isRefused = widget.isRefused;
    fetchAndSetDepartments(); 
    fetchAndSetjobPositions();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void saveCandidateChanges() {

  }

  void showRefuseDialog() {
    List<String> refuseReasons = [
      "Doesn't fit the job requirement",
      'Duplicate',
      'Language issues',
      'Refused by Applicant: better offer',
      "Refused by Applicant: don't like job",
      'Refused by Applicant: salary',
      'Role already fulfilled',
      'Spam'
    ];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String? selectedReason;
        return AlertDialog(
          title: Text('Refuse Reason',style: const TextStyle(color: textColor)),
          backgroundColor: snackBarColor,
          content: SingleChildScrollView(
            child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(color: Colors.grey, thickness: 0.2,),
              Row(
                children: [
                  Text('Reason', style: const TextStyle(color: textColor, fontSize: 16.0)),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      dropdownColor: snackBarColor,
                      value: selectedReason,
                      items: refuseReasons.map((String reason) {
                        return DropdownMenuItem<String>(
                          value: reason,
                          child: Text(reason, style: const TextStyle(color: textColor)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedReason = value!;
                          isChanged = true;
                      });
                    },
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                    ),
                  ),
                ),
                ],
              ),
            ],
          )
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isRefused = true;
                  Navigator.of(context).pop();
                  saveCandidateChanges();
                });
              },
              child: Text('Refuse',style: const TextStyle(color: textColor)),
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: const TextStyle(color: textColor)),
              style: TextButton.styleFrom(backgroundColor: dropdownColor),
            ),
          ],  
        );
      },
    );
  }

  void restoreCandidate() {
    setState(() {
      isRefused = false;
      saveCandidateChanges();
    });
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
                            saveCandidateChanges();
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
                              title: const Text('Do you want to delete this candidate?'),
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
                                    // deleteCandidate();
                                    Navigator.push(context, MaterialPageRoute(builder: (ctx) => RecruitmentManage()));
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: isRefused,
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        restoreCandidate();
                      },
                      style: ElevatedButton.styleFrom(  
                        side: const BorderSide(color: Colors.red),
                        backgroundColor: snackBarColor,
                        foregroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        'Restore',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: !isRefused,
                  child: ProgressStepper(
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
                ),
                const Spacer(),
                Visibility(
                      visible: !isRefused && widget.stage == 6, 
                      child: Row(
                        children: [
                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => EmployeeManage(                  
                                //       name: widget.name,
                                //       role: widget.role,
                                //       department: widget.department,
                                //       mobile: widget.mobile,
                                //       mail: widget.mail,
                                //       certification: widget.degree, 
                                //     ),
                                //   ),
                                // );
                              },
                              style: ElevatedButton.styleFrom(
                                side: const BorderSide(color: Colors.green),
                                backgroundColor: snackBarColor,
                                foregroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: const Text(
                                'Create Employee',
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                Visibility(
                  visible: !isRefused,
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        showRefuseDialog();
                      },
                      style: ElevatedButton.styleFrom(  
                        side: const BorderSide(color: Colors.red),
                        backgroundColor: snackBarColor,
                        foregroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        'Refuse',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
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
                      buildDropdownRow('Degree', degreeController, EmployeeData.defaultCertifications),
                      const SizedBox(height: 40),
                      const Text('JOB', style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16)),
                      const Divider(
                        thickness: 0.5,
                        color: textColor, 
                      ),
                      buildDropdownRow('Applied Job', roleController, roleNames),
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
                      buildDropdownRow('Interviewer', interviewerController, employeeNames),
                      const SizedBox(height: 10),
                      buildDropdownRow('Recruiter', recruiterController, employeeNames),
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