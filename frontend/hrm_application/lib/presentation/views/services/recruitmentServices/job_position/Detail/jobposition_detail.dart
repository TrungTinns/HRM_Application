  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter/widgets.dart';
import 'package:hrm_application/core/utils/theme/colors.dart';
import 'package:hrm_application/presentation/views/services/employeeServices/contract/Data/contracts_data.dart';
import 'package:hrm_application/presentation/views/services/employeeServices/contract/contracts.dart';
import 'package:hrm_application/presentation/views/services/employeeServices/department/Data/department_data.dart';
import 'package:hrm_application/presentation/views/services/employeeServices/Employee/Data/employees_data.dart';
import 'package:hrm_application/presentation/views/services/recruitmentServices/job_position/Data/jobposition_data.dart';
import 'package:hrm_application/presentation/views/services/recruitmentServices/job_position/Form/jobposition_form.dart';
import 'package:hrm_application/presentation/views/services/recruitmentServices/job_position/recruitment.dart';
import 'package:hrm_application/presentation/widgets/appbar/custom_title_appbar.dart';
  import 'package:http/http.dart' as http;
  import 'dart:convert';


  class JobPositionDetail extends StatefulWidget {
    final String id;
    final String name;
    final String department;
    final String mail;
    final String jobLocation;
    final String empType;
    final int target;
    final String recruiterId;
    final String interviewerId;
    final String? details;

    JobPositionDetail({
      required this.id,
      required this.department,
      required this.mail,
      required this.jobLocation,
      required this.name,
      required this.empType,
      required this.target,
      required this.recruiterId,
      required this.interviewerId,
      this.details,
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
    List<DepartmentData> departments = [];
    List<String> departmentNames = [];
    String selectedId = '';
    List<EmployeeData> employees = [];
    List<String> employeeNames = [];
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
      roleController.text = widget.name;
      departmentController.text = widget.department;
      mailController.text = widget.mail;
      jobLocationController.text = widget.jobLocation;
      typeController.text = widget.empType;
      targetController.text = widget.target.toString();
      recruiterController.text = widget.recruiterId;
      interviewerController.text = widget.interviewerId;
      detailsController.text = widget.details ?? '';
      fetchAndSetDepartments();
      fetchAndSetEmployees();
    }

    @override
    void dispose() {
      tabController.dispose();
      super.dispose();
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

  Future<void> _saveChanges() async {
    final url = Uri.parse('http://localhost:9002/api/v1/recruitment/jobPosition');

    final jobPositionData = {
      "id": widget.id,
      'name': roleController.text,
      'department': departmentController.text,
      'jobLocation': jobLocationController.text,
      'empType': typeController.text,
      'mailAlias': mailController.text,
      'target': int.tryParse(targetController.text) ?? 0,
      'recruiterId':  selectedId,
      'interviewers': selectedId,
      'description': detailsController.text
    };

    try {
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(jobPositionData),
      );

      if (response.statusCode == 200) {
        setState(() {
          isChanged = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Job position updated successfully')),
        );
      } else {
        throw Exception('Failed to update job position: ${response.body}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating job position: $e')),
      );
    }
  }

  Future<void> deleteJob(String jobPositionId) async {
    try {
      final url = Uri.parse('http://localhost:9002/api/v1/recruitment/jobPosition/$jobPositionId');
      final response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Delete job position successfully')),
        );
      } else {
        throw Exception('Failed to delete job position: ${response.body}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting job position: $e')),
      );
    }
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

    Widget buildDropdownRowAPI(
      String label, 
      TextEditingController controller, 
      List<Map<String, String>> items, 
      {Function(String)? onChanged}) {
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
            value: items.any((item) => item['id'] == controller.text) ? controller.text : null,
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
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => RecruitmentManage())),
                // () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => ApplicationManage())),
              ],
              [
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Contracts())),
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Contracts())),
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
                              _saveChanges();
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
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      await deleteJob(widget.id);
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
      );
    }
  }