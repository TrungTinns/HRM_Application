import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_application/Component/Appbar/custom_title_appbar.dart';
import 'package:hrm_application/Component/Configuration/configuration.dart';
import 'package:hrm_application/Views/Home/home.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Contract/contracts.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Contract/contracts_inf.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Department/department_inf.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Employee/employees_inf.dart';
import 'package:hrm_application/Views/Services/RecruitmentProcessManage/CandidateApplication/application_manage.dart';
import 'package:hrm_application/Views/Services/RecruitmentProcessManage/JobPosition/Form/jobposition_form.dart';
import 'package:hrm_application/Views/Services/RecruitmentProcessManage/JobPosition/jobposition_inf.dart';
import 'package:hrm_application/Views/Services/RecruitmentProcessManage/JobPosition/recruitment.dart';
import 'package:hrm_application/Widgets/colors.dart';


class JobPositionDetail extends StatefulWidget {
  final String role;
  final String department;
  final String mail;
  final String jobLocation;
  final String type;
  final int target;
  bool isPublished;
  final String recruiter;
  final String interviewer;
  final String? details;
  final VoidCallback onDelete;
  final ValueChanged<JobPositionInf> onUpdate;

  JobPositionDetail({
    required this.department,
    required this.mail,
    required this.jobLocation,
    required this.role,
    required this.type,
    required this.target,
    required this.isPublished,
    required this.recruiter,
    required this.interviewer,
    this.details,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  _JobPositionDetailState createState() => _JobPositionDetailState();
}

class _JobPositionDetailState extends State<JobPositionDetail> with SingleTickerProviderStateMixin {
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

  String pageName = 'Job Positions';
  bool showJobPositionForm = false;
  String? activeDropdown;
  bool isChanged = false;

  void setActiveDropdown(String? dropdown) {
    setState(() {
      activeDropdown = dropdown;
    });
  }

  void toggleJobPositionForm() {
    if (showJobPositionForm) {
      if (roleController.text.isEmpty) {
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
          roleController.clear();
        });
      }
    } else {
      setState(() {
        showJobPositionForm = true;
      });
    }
  }

  void clearJobPositionForm() {
    setState(() {
      showJobPositionForm = false;
      Navigator.push(context, MaterialPageRoute(builder: (ctx) => RecruitmentManage()));
    });
  }

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    roleController.text = widget.role;
    departmentController.text = widget.department;
    mailController.text = widget.mail;
    jobLocationController.text = widget.jobLocation;
    typeController.text = widget.type;
    targetController.text = widget.target.toString();
    recruiterController.text = widget.recruiter;
    interviewerController.text = widget.interviewer;
    detailsController.text = widget.details ?? '';
    isPublished = widget.isPublished;
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void saveChanges() {
    final updatedJobPosition = JobPositionInf(
      role: roleController.text,
      department: departmentController.text,
      mail: mailController.text,
      jobLocation: jobLocationController.text,
      type: typeController.text,
      target: int.parse(targetController.text),
      recruiter: recruiterController.text,
      interviewer: interviewerController.text,
      details: detailsController.text, 
      isPublished: isPublished,
    );
    widget.onUpdate(updatedJobPosition);
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
                            saveChanges();
                          } else {
                            toggleJobPositionForm();
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
                      tooltip: showJobPositionForm ? "Discard all changes" : "Delete this department",
                      onPressed: showJobPositionForm ? clearJobPositionForm : () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Do you want to delete this position?'),
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
      body: showJobPositionForm
          ? JobPositionForm()
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
                        controller: roleController,
                        onChanged: (value) {
                          setState(() {
                            isChanged = true;
                          });
                        },
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
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Is Published',
                                    style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18),
                                  ),
                                  const SizedBox(width: 100),
                                  Checkbox(
                                    value: isPublished,
                                    onChanged: (value) {
                                      setState(() {
                                        isPublished = value!;
                                        isChanged = true;
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
    );
  }
}