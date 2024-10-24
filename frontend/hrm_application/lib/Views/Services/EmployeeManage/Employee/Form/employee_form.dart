import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Contract/Data/contracts_data.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Department/Data/department_data.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Employee/employees.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Employee/Data/employees_data.dart';
import 'package:hrm_application/Views/Services/RecruitmentProcessManage/JobPosition/Data/jobposition_data.dart';
import 'package:hrm_application/Widgets/colors.dart';
import 'package:hrm_application/widgets/platform_options.dart';
import 'package:http/http.dart' as http;


class EmployeeForm extends StatefulWidget {
  final String? name;
  final String? role;
  final String? department;
  final String? mobile;
  final String? mail;
  final String? certification;

  const EmployeeForm({
  Key? key,
  this.name,
  this.role,
  this.department,
  this.mobile,
  this.mail,
  this.certification,
  }) : super(key: key);
  @override
  _EmployeeFormState createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> with SingleTickerProviderStateMixin {
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
  FocusNode nameFocusNode = FocusNode();
  TabController? tabController;
  bool isNameFilled = false;
  List<DepartmentData> departments = [];
  List<String> departmentNames = [];
  List<JobPositionData> jobPositions = [];
  List<String> roleNames = [];
  List<EmployeeData> managers = [];
  List<String> managerNames = [];
  String selectedManagerId = '';

  void _handleManagerSelection(String managerId) {
    setState(() {
      selectedManagerId = managerId;
    });
  }

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name ?? '';
    roleController.text = widget.role ?? '';
    mobileController.text = widget.mobile ?? '';
    mailController.text = widget.mail ?? '';
    departmentController.text = widget.department ?? '';
    certificationController.text = widget.certification ?? '';
    tabController = TabController(length: 2, vsync: this);
    nameController.addListener(() {
      setState(() {
        isNameFilled = nameController.text.isNotEmpty;
      });
    });
      WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(nameFocusNode);
    });
    fetchAndSetDepartments();
    fetchAndSetManagers();
    fetchAndSetjobPositions();
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

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  Future<void> _selectImage() async {}

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

  Future<List<String>> fetchCountries() async {
    final response = await http.get(Uri.parse('https://restcountries.com/v3.1/all?fields=name,capital,currencies'));
    if (response.statusCode == 200) {
      final List<dynamic> countries = jsonDecode(response.body);
      List<String> countryNames = countries.map<String>((country) => country['name']['common'] as String).toList();
      countryNames.sort();
      return countryNames;
    } else {
      throw Exception('Failed to load countries');
    }
  }

  Widget buildDropdownCountry(String label, TextEditingController controller) {
    return FutureBuilder<List<String>>(
      future: fetchCountries(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
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
                  style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Expanded(
                child: DropdownButtonFormField<String>(
                  dropdownColor: snackBarColor,
                  value: controller.text.isEmpty || !countries.contains(controller.text) ? null : controller.text,
                  onChanged: (String? newValue) {
                    setState(() {
                      controller.text = newValue!;
                    });
                  },
                  items: countries.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(color: textColor)),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: snackBarColor,
                  ),
                ),
              ),
            ],
          );
        } else {
          return Center(child: Text('No data available'));
        }
      },
    );
  }

  Widget buildTextFieldRow(String label, TextEditingController controller, {bool isDateField = false}) {
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
            style: const TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Expanded(
          child: DropdownButtonFormField<String>(
            dropdownColor: dropdownColor,
            value: controller.text.isEmpty ? null : controller.text,
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: const TextStyle(color: textColor)),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                controller.text = value!;
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

  Future<void> createEmployee() async {
    final platformOptions = PlatformOptions.currentPlatform;
    final apiUrl =
        'http://${PlatformOptions.host}:${PlatformOptions.port}/api/v1/employee';
        
    final url = Uri.parse(apiUrl);

    final contract = {
      'id': '',
      'referenceName': '',
      'department': departmentController.text.isNotEmpty ? departmentController.text : ' ',
      'empName': nameController.text.isNotEmpty ? nameController.text : ' ',
      'position': roleController.text.isNotEmpty ? roleController.text : ' ',
      'status': '',
      'schedule': scheduleController.text.isNotEmpty ? scheduleController.text : ' ',
      'schedulePay': '',
      'salaryStructure': salaryStructureController.text.isNotEmpty ? salaryStructureController.text : ' ',
      'contractType': contractTypeController.text.isNotEmpty ? contractTypeController.text : ' ',
      'cost': double.tryParse(costController.text) ?? 0.0,
      'note': '',
      'wageType': '',
      'startDate':  DateTime.now().toIso8601String(),
      'endDate':  DateTime.now().toIso8601String(),
    };

    final employee = {
      'id': '',
      'name': nameController.text.isNotEmpty ? nameController.text : ' ',
      'role': roleController.text.isNotEmpty ? roleController.text : ' ',
      'mail': mailController.text.isNotEmpty ? mailController.text : ' ',
      'mobile': mobileController.text.isNotEmpty ? mobileController.text : ' ',
      'department': departmentController.text.isNotEmpty ? departmentController.text : ' ',
      'managerId': selectedManagerId.isNotEmpty ? selectedManagerId : ' ',
      'isManager': isManager,
      'workLocation': workLocationController.text.isNotEmpty ? workLocationController.text : ' ',
      'personalAddress': personalAddressController.text.isNotEmpty ? personalAddressController.text : ' ',
      'personalMail': personalMailController.text.isNotEmpty ? personalMailController.text : ' ',
      'personalMobile': personalMobileController.text.isNotEmpty ? personalMobileController.text : ' ',
      'relativeName': relativeNameController.text.isNotEmpty ? relativeNameController.text : ' ',
      'relativeMobile': relativeMobileController.text.isNotEmpty ? relativeMobileController.text : ' ',
      'certification': certificationController.text.isNotEmpty ? certificationController.text : ' ',
      'school': schoolController.text.isNotEmpty ? schoolController.text : ' ',
      'maritalStatus': maritalStatusController.text.isNotEmpty ? maritalStatusController.text : ' ',
      'child': int.tryParse(childController.text) ?? 0,
      'nationality': nationalityController.text.isNotEmpty ? nationalityController.text : ' ',
      'idNum': idNumController.text.isNotEmpty ? idNumController.text : ' ',
      'ssNum': ssNumController.text.isNotEmpty ? ssNumController.text : ' ',
      'passport': passportController.text.isNotEmpty ? passportController.text : ' ',
      'sex': sexController.text.isNotEmpty ? sexController.text : ' ',
      'birthDate': birthDateController.text.isNotEmpty ? birthDateController.text : DateTime.now().toIso8601String(),
      'birthPlace': birthPlaceController.text.isNotEmpty ? birthPlaceController.text : ' ',
      'contract': contract,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(employee),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Create employee successfully')),
        );
      } else {
        print('Failed to create employee: ${response.body}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error creating employee: $e')),
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
                        focusNode: nameFocusNode,
                        controller: nameController,
                        style: const TextStyle(color: textColor, fontSize: 40.0),
                        decoration: const InputDecoration(
                          hintText: "Employee's Name",
                          hintStyle: TextStyle(color: termTextColor, fontSize: 40.0),
                        ),
                      ),
                      TextField(
                        controller: roleController,
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
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
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
                                isManager = value;
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
                              buildTextFieldRow('Date of Birth', birthDateController, isDateField: true),
                              // buildTextFieldRow('Date of Birth', birthDateController),
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
    floatingActionButton: isNameFilled
        ? FloatingActionButton(
            onPressed: ()  async {
              await createEmployee();
              Navigator.push(context, MaterialPageRoute(builder: (ctx) => EmployeeManage()));
            },
            child: const Icon(Icons.create),
          )
        : null,
    );
  }
}