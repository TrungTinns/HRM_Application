import 'package:flutter/material.dart';
import 'package:hrm_application/views/recruitment_process_manage/jobPosition/jobposition_inf.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:hrm_application/views/employee_inf_manage/contract/contracts_inf.dart';
import 'package:hrm_application/views/employee_inf_manage/department/department_inf.dart';
import 'package:hrm_application/views/employee_inf_manage/employee/employees.dart';
import 'package:hrm_application/views/employee_inf_manage/employee/employees_inf.dart';
import 'package:hrm_application/widgets/colors.dart';

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

  TabController? tabController;
  bool isNameFilled = false;
  
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
      countryNames.sort(); // Sort country names alphabetically
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
                      buildDropdownRow('Department', departmentController, getDepartments()),
                      const SizedBox(height: 10),
                      buildDropdownRow('Position', roleController, getJobPositions(jobPositions)),
                      const SizedBox(height: 10),
                      buildDropdownRow('Manager', managerController, getManagers(employees)),
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
                        buildDropdownRow('Work Location', workLocationController, EmployeeInf.defaultWorkLocations),
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
                              buildDropdownRow('Certification', certificationController, EmployeeInf.defaultCertifications),
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
                              buildDropdownRow('Sex', sexController, EmployeeInf.defaultSex),
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
                              buildDropdownRow('Marital Status', maritalStatusController, EmployeeInf.defaultMaritalStatus),
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
              onPressed: () {
                final newEmployee = EmployeeInf(
                  name: nameController.text,
                  role: roleController.text,
                  mail: mailController.text,
                  mobile: mobileController.text,
                  department: departmentController.text,
                  manager: managerController.text,
                  isManager: isManager,
                  workLocation: workLocationController.text.isEmpty ? null : personalAddressController.text,
                  schedule : scheduleController.text.isEmpty ? null : personalMailController.text,
                  salaryStructure: salaryStructureController.text.isEmpty ? null : personalMobileController.text,
                  contractType: contractTypeController.text.isEmpty ? null : contractTypeController.text,
                  cost: costController.text.isEmpty ? 0.0 : double.parse(costController.text),
                  personalAddress: personalAddressController.text.isEmpty ? null : personalAddressController.text,
                  personalMail: personalMailController.text.isEmpty ? null : personalMailController.text,
                  personalMobile: personalMobileController.text.isEmpty ? null : personalMobileController.text,
                  relativeName: relativeNameController.text.isEmpty ? null : relativeNameController.text,
                  relativeMobile: relativeMobileController.text.isEmpty ? null : relativeMobileController.text,
                  certification: certificationController.text.isEmpty ? null : certificationController.text,
                  school: schoolController.text.isEmpty ? null : schoolController.text,
                  maritalStatus: maritalStatusController.text.isEmpty ? null : maritalStatusController.text,
                  child: childController.text.isEmpty ? 0 : int.parse(childController.text),
                  nationality: nationalityController.text.isEmpty ? null : nationalityController.text,
                  idNum: idNumController.text.isEmpty ? null : idNumController.text,
                  ssNum: ssNumController.text.isEmpty ? null : ssNumController.text,
                  passport: passportController.text.isEmpty ? null : passportController.text,
                  sex: sexController.text.isEmpty ? null : sexController.text,
                  // birthDate: DateTime.parse("${birthDateController.text} 00:00:00"),
                  birthDate: birthDateController.text.isEmpty ? null : birthDateController.text,
                  birthPlace: birthPlaceController.text.isEmpty ? null : birthPlaceController.text
                );
                setState(() {
                  employees.add(newEmployee);
                });
                Navigator.push(context, MaterialPageRoute(builder: (ctx) => EmployeeManage()));
              },
              child: const Icon(Icons.create),
            )
          : null,
    );
  }
}