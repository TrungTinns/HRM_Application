import 'package:hrm_application/API/api.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Contract/Data/contracts_data.dart';
import 'package:hrm_application/widgets/platform_options.dart';

class EmployeeData {
  final String id;
  final String name;
  final String role;
  final String mail;
  final String mobile;
  final String department;
  final String? managerId;
  final String workLocation;
  final String personalAddress;
  final String personalMail;
  final String personalMobile;
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
  final DateTime? birthDate;
  final String? birthPlace;
  final bool? isManager;
  final ContractData? contract;
  static final List<String> defaultWorkLocations = ['Office', 'Home'];
  static final List<String> defaultCertifications = ['Graduated', 'Bachelor', 'Master', 'Doctor'];
  static final List<String> defaultMaritalStatus = ['Single', 'Married', 'Legal Cohabitant','Divorced', 'Widower'];
  static final List<String> defaultSex = ['Male', 'Female'];

  EmployeeData({
    required this.id,
    required this.name,
    required this.role,
    required this.mail,
    required this.mobile,
    required this.department,
    this.managerId,
    required this.workLocation,
    required this.personalAddress,
    required this.personalMail,
    required this.personalMobile,
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
    this.isManager,
    this.contract,
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json) {
    return EmployeeData(
      id: json['id'],
      name: json['name'],
      role: json['role'],
      mail: json['mail'],
      mobile: json['mobile'],
      department: json['department'],
      managerId: json['managerId'],
      workLocation: json['workLocation'],
      personalAddress: json['personalAddress'],
      personalMail: json['personalMail'],
      personalMobile: json['personalMobile'],
      relativeName: json['relativeName'],
      relativeMobile: json['relativeMobile'],
      certification: json['certification'],
      school: json['school'],
      maritalStatus: json['maritalStatus'],
      child: json['child'] as int? ?? 0,
      nationality: json['nationality'],
      idNum: json['idNum'],
      ssNum: json['ssNum'],
      passport: json['passport'],
      sex: json['sex'],
      birthDate: DateTime.parse(json['birthDate']),
      birthPlace: json['birthPlace'],
      contract: ContractData.fromJson(json['contract']) as ContractData? ?? ContractData(),
    );
  }
}

Future<List<EmployeeData>> fetchEmployees() async {
  try {
    final platformOptions = PlatformOptions.currentPlatform;
    final apiUrl =
        'http://${PlatformOptions.host}:${PlatformOptions.port}/api/v1/employee';

    List<EmployeeData> employees = await fetchAPI<EmployeeData>(
      apiUrl: apiUrl,
      fromJson: (json) {
        return EmployeeData(
          id: json['id'] ?? " ",
          name: json['name'] ?? " ",
          role: json['role'] ?? " ",
          mail: json['mail'] ?? " ",
          mobile: json['mobile'] ?? " ",
          department: json['department'] ?? " ",
          managerId: json['managerId'] ?? " ",
          workLocation: json['workLocation'] ?? " ",
          personalAddress: json['personalAddress'] ?? " ",
          personalMail: json['personalMail'] ?? " ",
          personalMobile: json['personalMobile'] ?? " ",
          relativeName: json['relativeName'] ?? " ",
          relativeMobile: json['relativeMobile'] ?? " ",
          certification: json['certification'] ?? " ",
          school: json['school'] ?? " ",
          maritalStatus: json['maritalStatus'] ?? " ",
          child: json['child'] as int? ?? 0,
          nationality: json['nationality'] ?? " ",
          idNum: json['idNum'] ?? " ",
          ssNum: json['ssNum'] ?? " ",
          passport: json['passport'] ?? " ",
          sex: json['sex'] ?? " ",
          birthDate: json['birthDate'] != null ? DateTime.parse(json['birthDate']) : null,
          birthPlace: json['birthPlace'] ?? " ",
          contract: json['contract'] != null ? ContractData.fromJson(json['contract']) : null,
        );
      },
    );
    print('Fetched ${employees.length} employees');
    return employees;
  } catch (e) {
    print('Error fetching employees: $e');
    return [];
  }
}

Future<List<EmployeeData>> fetchManagers() async {
  try {
    final platformOptions = PlatformOptions.currentPlatform;
    final apiUrl =
        'http://${PlatformOptions.host}:${PlatformOptions.port}/api/v1/employee/managers';
    List<EmployeeData> managers = await fetchAPI<EmployeeData>(
      apiUrl: apiUrl,
      fromJson: (json) {
        return EmployeeData(
          id: json['id'] ?? " ",
          name: json['name'] ?? " ",
          role: json['role'] ?? " ",
          mail: json['mail'] ?? " ",
          mobile: json['mobile'] ?? " ",
          department: json['department'] ?? " ",
          managerId: json['managerId'] ?? " ",
          workLocation: json['workLocation'] ?? " ",
          personalAddress: json['personalAddress'] ?? " ",
          personalMail: json['personalMail'] ?? " ",
          personalMobile: json['personalMobile'] ?? " ",
          relativeName: json['relativeName'] ?? " ",
          relativeMobile: json['relativeMobile'] ?? " ",
          certification: json['certification'] ?? " ",
          school: json['school'] ?? " ",
          maritalStatus: json['maritalStatus'] ?? " ",
          child: json['child'] as int? ?? 0,
          nationality: json['nationality'] ?? " ",
          idNum: json['idNum'] ?? " ",
          ssNum: json['ssNum'] ?? " ",
          passport: json['passport'] ?? " ",
          sex: json['sex'] ?? " ",
          birthDate: json['birthDate'] != null ? DateTime.parse(json['birthDate']) : null,
          birthPlace: json['birthPlace'] ?? " ",
          contract: json['contract'] != null ? ContractData.fromJson(json['contract']) : null,
        );
      },
    );
    print('Fetched ${managers.length} managers');
    return managers;
  } catch (e) {
    print('Error fetching managers: $e');
    return [];
  }
}