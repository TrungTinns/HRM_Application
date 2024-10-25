import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_application/Component/Appbar/custom_title_appbar.dart';
import 'package:hrm_application/Component/Configuration/configuration.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Contract/contracts.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Contract/Data/contracts_data.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Department/department.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Department/Data/department_data.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Employee/Form/employee_form.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Employee/employees.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Employee/Data/employees_data.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/OrgChart/orgchart.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Position/position.dart';
import 'package:hrm_application/Views/Home/home.dart';
import 'package:hrm_application/Views/Services/RecruitmentProcessManage/JobPosition/Data/jobposition_data.dart';
import 'package:hrm_application/Widgets/colors.dart';
import 'package:hrm_application/widgets/platform_options.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class EmployeeDetail extends StatefulWidget {
  final String id;
  final String name;
  final String? role;
  final String mail;
  final String mobile;
  final String department;
  final String managerId;
  final bool isManager;
  final String? workLocation;
  final String? schedule;
  final String? salaryStructure;
  final String? contractType;
  final double? cost;
  final String? personalAddress;
  final String? personalMail;
  final String? personalMobile;
  final String? relativeName;
  final String? relativeMobile;
  final String? certification;
  final String? school;
  final String? maritalStatus;
  final int? child;
  final String? nationality;
  final String? idNum;
  final String? ssNum;
  final String? passport;
  final String? sex;
  final String? birthDate;
  final String? birthPlace;
  final String? idContract;

  EmployeeDetail({
    required this.id,
    required this.name,
    required this.role,
    required this.mail,
    required this.mobile,
    required this.department,
    required this.managerId,
    required this.isManager,
    this.workLocation,
    this.schedule,
    this.salaryStructure,
    this.contractType,
    this.cost,
    this.personalAddress,
    this.personalMail,
    this.personalMobile,
    this.relativeName,
    this.relativeMobile,
    this.certification,
    this.school,
    this.maritalStatus,
    this.child,
    this.nationality,
    this.idNum,
    this.ssNum,
    this.passport,
    this.sex,
    this.birthDate,
    this.birthPlace,
    this.idContract,
  });

  @override
  _EmployeeDetailState createState() => _EmployeeDetailState();
}

class _EmployeeDetailState extends State<EmployeeDetail> with SingleTickerProviderStateMixin {
  TextEditingController nameController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController managerController = TextEditingController();
  TextEditingController workLocationController = TextEditingController();
  TextEditingController scheduleController = TextEditingController();
  TextEditingController salaryStructureController = TextEditingController();
  TextEditingController contractTypeController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController personalAddressController = TextEditingController();
  TextEditingController personalMailController = TextEditingController();
  TextEditingController personalMobileController = TextEditingController();
  TextEditingController relativeNameController = TextEditingController();
  TextEditingController relativeMobileController = TextEditingController();
  TextEditingController certificationController = TextEditingController();
  TextEditingController schoolController = TextEditingController();
  TextEditingController maritalStatusController = TextEditingController();
  TextEditingController childController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController idNumController = TextEditingController();
  TextEditingController ssNumController = TextEditingController();
  TextEditingController passportController = TextEditingController();
  TextEditingController sexController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController birthPlaceController = TextEditingController();
  bool isManager = false;
  List<DepartmentData> departments = [];
  List<String> departmentNames = [];
  List<JobPositionData> jobPositions = [];
  List<String> roleNames = [];
  List<EmployeeData> managers = [];
  List<String> managerNames = [];
  String pageName = 'Employees';
  bool showEmployeeForm = false;
  String? activeDropdown;
  bool isChanged = false;
  String selectedManagerId = '';

  void setActiveDropdown(String? dropdown) {
    setState(() {
      activeDropdown = dropdown;
    });
  }

  void toggleEmployeeForm() {
    if (showEmployeeForm) {
      if (nameController.text.isEmpty) {
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
          nameController.clear();
        });
      }
    } else {
      setState(() {
        showEmployeeForm = true;
      });
    }
  }

  void clearEmployeeForm() {
    setState(() {
      showEmployeeForm = false;
      Navigator.push(context, MaterialPageRoute(builder: (ctx) => EmployeeManage()));
    });
  }

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    roleController.text = widget.role ?? '';
    mobileController.text = widget.mobile;
    mailController.text = widget.mail;
    departmentController.text = widget.department;
    managerController.text = widget.managerId;
    tabController = TabController(length: 2, vsync: this);
    isManager = widget.isManager;
    workLocationController.text = widget.workLocation ?? '';
    scheduleController.text = widget.schedule ?? '';
    salaryStructureController.text = widget.salaryStructure ?? '';
    contractTypeController.text = widget.contractType ?? '';
    costController.text = widget.cost.toString();
    personalAddressController.text = widget.personalAddress ?? '';
    personalMailController.text = widget.personalMail ?? '';
    personalMobileController.text = widget.personalMobile ?? '';
    relativeNameController.text = widget.relativeName ?? '';
    relativeMobileController.text = widget.relativeMobile ?? '';
    certificationController.text = widget.certification ?? '';
    schoolController.text = widget.school ?? '';
    maritalStatusController.text = widget.maritalStatus ?? '';
    childController.text = widget.child.toString();
    nationalityController.text = widget.nationality ?? '';
    idNumController.text = widget.idNum ?? '';
    ssNumController.text = widget.ssNum ?? '';
    passportController.text = widget.passport ?? '';
    sexController.text = widget.sex ?? '';
    birthDateController.text = widget.birthDate?? '';
    birthPlaceController.text = widget.birthPlace ?? '';
    fetchAndSetDepartments();
    fetchAndSetManagers();
    fetchAndSetjobPositions();
  }


  void _handleManagerSelection(String managerId) {
    setState(() {
      selectedManagerId = managerId;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
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

  Future<void> fetchAndSetManagers() async {
    try {
      managers = await fetchManagers();
      setState(() {
        managerNames = managers.map((mgr) => mgr.name).toList();
        managerNames.sort((a, b) => a.compareTo(b));
      });
    } catch (e) {
      print('Error fetching managers: $e');
    }
  }

  String formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
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

  Future<void> _saveChanges() async {
    final platformOptions = PlatformOptions.currentPlatform;
    final apiUrl =
        'http://${PlatformOptions.host}:${PlatformOptions.port}/api/v1/employee';
        
    final url = Uri.parse(apiUrl);

    final contractData = {
      "id": widget.idContract ?? widget.id,
      "schedule": scheduleController.text,
      "contractType": contractTypeController.text,
      "cost": double.tryParse(costController.text) ?? 0.0,
      "startDate":  DateTime.now().toIso8601String(),
      "endDate":  DateTime.now().toIso8601String(),
      'department': departmentController.text,
      'empName': nameController.text,
      'position': roleController.text,
      'salaryStructure': salaryStructureController.text,
    };
    final employeeData = {
      "id": widget.id,
      "name": nameController.text,
      "role": roleController.text,
      "mail": mailController.text,
      "mobile": mobileController.text,
      "department": departmentController.text,
      "managerId": managerController.text,
      "isManager": isManager,
      "workLocation": workLocationController.text,
      "personalAddress": personalAddressController.text,
      "personalMail": personalMailController.text,
      "personalMobile": personalMobileController.text,
      "relativeName": relativeNameController.text,
      "relativeMobile": relativeMobileController.text,
      "certification": certificationController.text,
      "school": schoolController.text,
      "maritalStatus": maritalStatusController.text,
      "child": int.tryParse(childController.text) ?? 0,
      "nationality": nationalityController.text,
      "idNum": idNumController.text,
      "ssNum": ssNumController.text,
      "passport": passportController.text,
      "sex": sexController.text,
      "birthDate": DateTime.parse(birthDateController.text).toIso8601String(),
      "birthPlace": birthPlaceController.text,
      "contract": contractData,
    };

    try {
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(employeeData),
      );

      if (response.statusCode == 200) {
        setState(() {
          isChanged = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Employee updated successfully')),
        );
      } else {
        throw Exception('Failed to update employee: ${response.body}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating employee: $e')),
      );
    }
  }

  Future<void> deleteEmployee(String employeeId) async {
    try {
      final platformOptions = PlatformOptions.currentPlatform;
      final apiUrl =
        'http://${PlatformOptions.host}:${PlatformOptions.port}/api/v1/employee/$employeeId';
        
      final url = Uri.parse(apiUrl);
      final response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Delete employee successfully')),
        );
      } else {
        throw Exception('Failed to delete employee: ${response.body}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting employee: $e')),
      );
    }
  }

  Future<List<String>> fetchCountries() async {
    final response = await http.get(Uri.parse('https://restcountries.com/v3/all'));
    if (response.statusCode == 200) {
      final List<dynamic> countries = jsonDecode(response.body);
      return countries.map((country) => country['name']['common'] as String).toList();
    } else {
      throw Exception('Failed to load countries');
    }
  }

  Widget buildDropdownCountry(String label, TextEditingController controller) {
    return FutureBuilder<List<String>>(
      future: fetchCountries(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final countries = snapshot.data!;
          if (!countries.contains(controller.text)) {
            controller.text = countries.first;
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
              child: DropdownButtonFormField<String>(
                dropdownColor: dropdownColor,
                value: countries.contains(controller.text) ? controller.text : null,
                onChanged: (String? newValue) {
                  setState(() {
                    controller.text = newValue!;
                    isChanged = true;
                  });
                },
                items: countries.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: const TextStyle(color: textColor)),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: snackBarColor,
                ),
              ),
            )
            ],
          );
        } else {
          return Text('No data available');
        }
      },
    );
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
    if (!items.contains(controller.text)) {
      controller.text = items.isNotEmpty ? items.first : '';
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
        title: CustomTitleAppbar(
          ctx: context,
          service: pageName,
          titles: const ['Employees', 'Department'],
          options: const [
            ['Employees', 'Contracts', 'Org Chart'],
            ['Department', 'Position']
          ],
          optionNavigations: [
            [
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => EmployeeManage())),
                            () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => EmployeeManage())),

              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => EmployeeManage())),

              // () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Contracts())),
              // () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => OrgChartManage())),
            ],
            [
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Department())),

              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => EmployeeManage())),

              // () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => PositionManage())),
            ],
          ],
          activeDropdowns: const ['Employees', 'Reporting'],
          setActiveDropdown: (dropdown) {
            setState(() {
              activeDropdown = dropdown;
            });
          },
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
                        onPressed: () async {
                          if (isChanged) {
                            _saveChanges();
                          } else {
                            toggleEmployeeForm();
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
                      tooltip: showEmployeeForm ? "Discard all changes" : "Delete this employee",
                      onPressed: showEmployeeForm ? clearEmployeeForm : () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Do you want to delete this employee?'),
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
                                    deleteEmployee(widget.id);
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
      body: showEmployeeForm
          ? EmployeeForm()
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
                        controller: nameController,
                        onChanged: (value) {
                          setState(() {
                            isChanged = true;
                          });
                        },
                        style: const TextStyle(color: textColor, fontSize: 40.0),
                        decoration: const InputDecoration(
                          hintText: "Employee's Name",
                          hintStyle: TextStyle(color: termTextColor, fontSize: 40.0),
                        ),
                      ),
                      TextField(
                        controller: roleController,
                          onChanged: (value) {
                            setState(() {
                              isChanged = true;
                            });
                          },
                        style: const TextStyle(color: textColor, fontSize: 20.0),
                        decoration: const InputDecoration(
                          hintText: "Job Position",
                          hintStyle: TextStyle(color: termTextColor, fontSize: 20.0),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                if (widget.name.isNotEmpty)
                  Column(
                    children: [
                      const SizedBox(height: 20,),
                      IconButton(
                        icon: const Icon(Icons.insert_photo),
                        color: textColor,
                        iconSize: 120,
                        onPressed: () {},
                        tooltip: "Upload photo",
                      ),
                    ],
                  ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      buildTextFieldRow('Mobile', mobileController),
                      const SizedBox(height: 10),
                      buildTextFieldRow('Email', mailController),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Management Authority',
                            style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const SizedBox(width: 20),
                          Switch(
                            value: isManager,
                            onChanged: (value) {
                              setState(() {
                                // isManager = value;
                                isChanged = true;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    children: [
                      buildDropdownRow('Department', departmentController, departmentNames),
                      const SizedBox(height: 10),
                      buildDropdownRow('Position', roleController, roleNames),
                      const SizedBox(height: 10),
                      buildDropdownRowAPI(
                        'Manager',
                        managerController,
                        managers.map((mgr) => {'id': mgr.id, 'name': mgr.name}).toList(),
                        onChanged: _handleManagerSelection,
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
                Tab(text: 'Work Information'),
                Tab(text: 'Private Information'),
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
                        buildDropdownRow('Work Location', workLocationController, EmployeeData.defaultWorkLocations),
                        const SizedBox(height: 10),
                        buildDropdownRow('Working Schedule', scheduleController, ContractData.defaultSchedules),
                        const SizedBox(height: 10),
                        buildDropdownRow('Salary Structure Type', salaryStructureController, ContractData.defaultSalaryStructures),
                        const SizedBox(height: 10),
                        buildDropdownRow('Contract Type', contractTypeController, ContractData.defaultContractTypes),
                        const SizedBox(height: 10),
                        buildTextFieldRow('Cost per Hour', costController),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('PERSONAL CONTACT', style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16)),
                              const Divider(
                                thickness: 0.5,
                                color: textColor,
                              ),
                              buildTextFieldRow('Personal Address', personalAddressController),
                              const SizedBox(height: 10),
                              buildTextFieldRow('Email', personalMailController),
                              const SizedBox(height: 10),
                              buildTextFieldRow('Phone', personalMobileController),
                              const SizedBox(height: 20),
                              const Text('EDUCATION', style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16)),
                              const Divider(
                                thickness: 0.5,
                                color: textColor,
                              ),
                              buildDropdownRow('Certification', certificationController, EmployeeData.defaultCertifications),
                              const SizedBox(height: 10),
                              buildTextFieldRow('School', schoolController),
                              const SizedBox(height: 20),
                              const Text('CITIZEN', style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16)),
                        const Divider(
                          thickness: 0.5,
                          color: textColor,
                        ),
                        buildDropdownCountry('Nationality', nationalityController),
                        const SizedBox(height: 10),
                        buildTextFieldRow('ID Number', idNumController),
                        const SizedBox(height: 10),
                        buildTextFieldRow('Social Security Number', ssNumController),
                        const SizedBox(height: 10),
                        buildTextFieldRow('Passport', passportController),
                        const SizedBox(height: 10),
                        buildDropdownRow('Sex', sexController, EmployeeData.defaultSex),
                        const SizedBox(height: 10),
                        // buildTextFieldRow('Date of Birth', birthDateController, isDateField: true),
                        buildTextFieldRow('Date of Birth', birthDateController),
                        const SizedBox(height: 10),
                        buildTextFieldRow('Place of Birth', birthPlaceController),
                            ]
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('EMERGENCY CONTACT ', style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16)),
                              const Divider(
                                thickness: 0.5,
                                color: textColor,
                              ),
                              buildTextFieldRow('Relative Contact Name', relativeNameController),
                              const SizedBox(height: 10),
                              buildTextFieldRow('Relative Phone', relativeMobileController),
                              const SizedBox(height: 78),
                              const Text('FAMILY STATUS', style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16)),
                              const Divider(
                                thickness: 0.5,
                                color: textColor,
                              ),
                              buildDropdownRow('Marital Status', maritalStatusController, EmployeeData.defaultMaritalStatus),
                              const SizedBox(height: 10),
                              buildTextFieldRow('Number of children', childController),
                            ]
                          ),
                        ),
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