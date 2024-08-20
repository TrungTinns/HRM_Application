import 'package:hrm_application/API/api.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Contract/Data/contracts_data.dart';

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
    List<EmployeeData> employees = await fetchAPI<EmployeeData>(
      apiUrl: 'http://localhost:9001/api/v1/employee',
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
    List<EmployeeData> managers = await fetchAPI<EmployeeData>(
      apiUrl: 'http://localhost:9001/api/v1/employee/managers',
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



  // List<String> managerNames = [];
  // Future<void> fetchAndStoreManagerNames() async {
  //   List<EmployeeData> managers = await fetchManagers();
    
  //   managerNames = managers.map((manager) => manager.name).toList();
    
  //   print('Stored manager names: $managerNames');
  // }

// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class Employee {
//   final String id;
//   final String name;
//   final String role;
//   final String mail;
//   final String mobile;
//   final String department;
//   final String managerId;
//   final String workLocation;
//   final String personalAddress;
//   final String personalMail;
//   final String personalMobile;
//   final String? relativeName;
//   final String? relativeMobile;
//   final String? certification;
//   final String? school;
//   final String? maritalStatus;
//   final int? child;
//   final String? nationality;
//   final String? idNum;
//   final String? ssNum;
//   final String? passport;
//   final String? sex;
//   final DateTime? birthDate;
//   final String? birthPlace;
//   final Contract? contract;
//   final bool? manager;

//   Employee({
//     required this.id,
//     required this.name,
//     required this.role,
//     required this.mail,
//     required this.mobile,
//     required this.department,
//     required this.managerId,
//     required this.workLocation,
//     required this.personalAddress,
//     required this.personalMail,
//     required this.personalMobile,
//     this.relativeName,
//     this.relativeMobile,
//     this.certification,
//     this.school,
//     this.maritalStatus,
//     this.child,
//     this.nationality,
//     this.idNum,
//     this.ssNum,
//     this.passport,
//     this.sex,
//     this.birthDate,
//     this.birthPlace,
//     this.contract,
//     this.manager,
//   });

//   factory Employee.fromJson(Map<String, dynamic> json) {
//     return Employee(
//       id: json['id'],
//       name: json['name'],
//       role: json['role'],
//       mail: json['mail'],
//       mobile: json['mobile'],
//       department: json['department'],
//       managerId: json['managerId'],
//       workLocation: json['workLocation'],
//       personalAddress: json['personalAddress'],
//       personalMail: json['personalMail'],
//       personalMobile: json['personalMobile'],
//       relativeName: json['relativeName'],
//       relativeMobile: json['relativeMobile'],
//       certification: json['certification'],
//       school: json['school'],
//       maritalStatus: json['maritalStatus'],
//       child: json['child'],
//       nationality: json['nationality'],
//       idNum: json['idNum'],
//       ssNum: json['ssNum'],
//       passport: json['passport'],
//       sex: json['sex'],
//       birthDate: DateTime.parse(json['birthDate']),
//       birthPlace: json['birthPlace'],
//       contract: Contract.fromJson(json['contract']),
//       manager: json['manager'],
//     );
//   }
// }

// class Contract {
//   final String id;
//   final String schedule;
//   final String salaryStructure;
//   final String contractType;
//   final double cost;
//   final DateTime? startDate;
//   final DateTime? endDate;

//   Contract({
//     required this.id,
//     required this.schedule,
//     required this.salaryStructure,
//     required this.contractType,
//     required this.cost,
//     required this.startDate,
//     required this.endDate,
//   });

//   factory Contract.fromJson(Map<String, dynamic> json) {
//     return Contract(
//       id: json['id'],
//       schedule: json['schedule'],
//       salaryStructure: json['salaryStructure'],
//       contractType: json['contractType'],
//       cost: json['cost'],
//       startDate: json['startDate'] != null
//           ? DateTime.parse(json['startDate'])
//           : null,
//       endDate: json['endDate'] != null
//           ? DateTime.parse(json['endDate'])
//           : null,
//     );
//   }
// }



// class EmployeeInf {
//   final String id;
//   final String name;
//   final String role;
//   final String mail;
//   final String mobile;
//   final String department;
//   final String manager;
//   final bool isManager;
//   final String? workLocation;
//   final String? schedule;
//   final String? salaryStructure;
//   final String? contractType;
//   final double? cost;
//   final String? personalAddress;
//   final String? personalMail;
//   final String? personalMobile;
//   final String? relativeName;
//   final String? relativeMobile;
//   final String? certification;
//   final String? school;
//   final String? maritalStatus;
//   final int? child;
//   final String? nationality;
//   final String? idNum;
//   final String? ssNum;
//   final String? passport;
//   final String? sex;
//   final DateTime? birthDate;
//   final String? birthPlace;
//   final String? contractId;
//   static final List<String> defaultWorkLocations = ['Office', 'Home'];
//   static final List<String> defaultCertifications = ['Graduated', 'Bachelor', 'Master', 'Doctor'];
//   static final List<String> defaultMaritalStatus = ['Single', 'Married', 'Legal Cohabitant','Divorced', 'Widower'];
//   static final List<String> defaultSex = ['Male', 'Female'];

//   EmployeeInf({
//     required this.id,
//     required this.name,
//     required this.role,
//     required this.mail,
//     required this.mobile,
//     required this.department,
//     required this.manager,
//     required this.isManager,
//     this.workLocation,
//     this.schedule,
//     this.salaryStructure,
//     this.contractType,
//     this.cost,
//     this.personalAddress,
//     this.personalMail,
//     this.personalMobile,
//     this.relativeName,
//     this.relativeMobile,
//     this.certification,
//     this.school,
//     this.maritalStatus,
//     this.child,
//     this.nationality,
//     this.idNum,
//     this.ssNum,
//     this.passport,
//     this.sex,
//     this.birthDate,
//     this.birthPlace,
//     this.contractId,
//   });
//     factory EmployeeInf.fromJson(Map<String, dynamic> json) {
//     return EmployeeInf(
//       id: json['id'],
//       name: json['name'],
//       role: json['role'],
//       mail: json['mail'],
//       mobile: json['mobile'],
//       department: json['department'],
//       manager: json['managerId'],
//       isManager: json['manager'] ?? false,
//       workLocation: json['workLocation'],
//       schedule: json['contract'] != null ? json['contract']['schedule'] : null,
//       salaryStructure: json['contract'] != null ? json['contract']['salaryStructure'] : null,
//       contractType: json['contract'] != null ? json['contract']['contractType'] : null,
//       cost: json['contract'] != null ? json['contract']['cost'].toDouble() : null,
//       personalAddress: json['personalAddress'],
//       personalMail: json['personalMail'],
//       personalMobile: json['personalMobile'],
//       relativeName: json['relativeName'],
//       relativeMobile: json['relativeMobile'],
//       certification: json['certification'],
//       school: json['school'],
//       maritalStatus: json['maritalStatus'],
//       child: json['child'],
//       nationality: json['nationality'],
//       idNum: json['idNum'],
//       ssNum: json['ssNum'],
//       passport: json['passport'],
//       sex: json['sex'],
//       birthDate: json['birthDate'],
//       birthPlace: json['birthPlace'],
//       contractId: json['contract'] != null ? json['contract']['id'] : null,
//     );
//   }
// }

//   int countEmployeesInDepartment(List<EmployeeInf> employees, String department) {
//     return employees.where((employee) => employee.department == department).length;
//   }

//   int countEmployeesInPosition(List<EmployeeInf> employees, String role) {
//     return employees.where((employee) => employee.role == role).length;
//   }

//   List<String> getManagers(List<EmployeeInf> employees) {
//     return employees.where((employee) => employee.isManager).map((e) => e.name).toList()..sort((a, b) => a.compareTo(b));
//   }

//   List<String> getNameEmp(List<EmployeeInf> employees) {
//     return employees.map((employee) => employee.name).toSet().toList()..sort((a, b) => a.compareTo(b));
//   }

// final List<EmployeeInf> employees = [
//   //Administration
//   EmployeeInf(
//     name: 'Son Tung MTP',
//     role: 'Director',
//     mail: 'sontung@gmail.com',
//     mobile: '123-456-7890',
//     department: 'Administration',
//     manager: 'Phuong Hang',
//     isManager: true,
//     workLocation: 'Office',
//     schedule: 'Standard 40 hours/week',
//     salaryStructure: 'Employee',
//     contractType: 'Permanent',
//     cost: 25.0000,  
//     personalAddress: 'HCM',
//     personalMail: 'sontung@gmail.com',
//     personalMobile: '123-456-7890',
//     relativeName: 'Dat G',
//     relativeMobile: '987-654-3210',  
//     certification: 'Flutter', 
//     school: 'University of California', 
//     maritalStatus: 'Married', 
//     child: 2, 
//     nationality: 'USA', 
//     idNum: '123456789', 
//     ssNum: '987654321', 
//     passport: 'password', 
//     sex: 'Male', 
//     // birthDate: DateTime(2000, 08, 11), 
//     birthDate: '2000-08-11',
//     birthPlace: 'California',
//   ),
//   EmployeeInf(
//     name: 'Phuong Hang',
//     role: 'CEO',
//     mail: 'phuonghang@gmail.com',
//     mobile: '890-123-4567',
//     department: 'Administration',
//     manager: 'Phuong Hang',
//     isManager: true,
//     workLocation: 'Office',
//     schedule: 'Standard 40 hours/week',  
//     salaryStructure: 'Employee',
//     contractType: 'Permanent',  
//     cost: 25.0000,  
//     personalAddress: 'HCM',
//     personalMail: 'sontung@gmail.com',
//     personalMobile: '123-456-7890',
//     relativeName: 'Dat G',
//     relativeMobile: '987-654-3210',  
//   ),
//   EmployeeInf(
//     name: 'Dat G',
//     role: 'Secretary',
//     mail: 'vosu@gmail.com',
//     mobile: '123-456-7890',
//     department: 'Administration',
//     manager: 'Son Tung MTP',
//     isManager: false,  
//     workLocation: 'Office',
//     schedule: 'Standard 40 hours/week',  
//     salaryStructure: 'Employee',
//     contractType: 'Permanent',  
//     cost: 25.0000,  
//     personalAddress: 'HCM',
//     personalMail: 'sontung@gmail.com',
//     personalMobile: '123-456-7890',
//     relativeName: 'Dat G',
//     relativeMobile: '987-654-3210',  
//   ),
//   EmployeeInf(
//     name: 'HieuThuHai',
//     role: 'Database Administrator',
//     mail: 'babyboo@gmail.com',
//     mobile: '123-456-7890',
//     department: 'Administration',
//     manager: 'Son Tung MTP',
//     isManager: false,  
//     workLocation: 'Office',
//     schedule: 'Standard 40 hours/week',  
//     salaryStructure: 'Employee',
//     contractType: 'Permanent',  
//     cost: 25.0000,  
//     personalAddress: 'HCM',
//     personalMail: 'sontung@gmail.com',
//     personalMobile: '123-456-7890',
//     relativeName: 'Dat G',
//     relativeMobile: '987-654-3210',  
//   ),
//   //Research & Development
//   EmployeeInf(
//     name: 'Jack J97',
//     role: 'Project Manager',
//     mail: '5tr@gmail.com',
//     mobile: '234-567-8901',
//     department: 'Research & Development',
//     manager: 'Son Tung MTP',
//     isManager: true,  
//     workLocation: 'Office',
//     schedule: 'Standard 40 hours/week',  
//     salaryStructure: 'Employee',
//     contractType: 'Permanent',  
//     cost: 25.0000,  
//     personalAddress: 'HCM',
//     personalMail: 'sontung@gmail.com',
//     personalMobile: '123-456-7890',
//     relativeName: 'Dat G',
//     relativeMobile: '987-654-3210',  
//   ),
//   EmployeeInf(
//     name: 'Huong Tit',
//     role: 'Dev',
//     mail: 'kth@gmail.com',
//     mobile: '345-678-9012',
//     department: 'Research & Development',
//     manager: 'Jack J97',
//     isManager: false,  
//     workLocation: 'Office',
//     schedule: 'Standard 40 hours/week',  
//     salaryStructure: 'Employee',
//     contractType: 'Permanent',  
//     cost: 25.0000,  
//     personalAddress: 'HCM',
//     personalMail: 'sontung@gmail.com',
//     personalMobile: '123-456-7890',
//     relativeName: 'Dat G',
//     relativeMobile: '987-654-3210',  
//   ),
//   EmployeeInf(
//     name: 'Hieu PC',
//     role: 'Dev',
//     mail: 'hieupc@gmail.com',
//     mobile: '456-789-0123',
//     department: 'Research & Development',
//     manager: 'Jack J97',
//     isManager: false,  
//     workLocation: 'Office',
//     schedule: 'Standard 40 hours/week',  
//     salaryStructure: 'Employee',
//     contractType: 'Permanent',  
//     cost: 25.0000,  
//     personalAddress: 'HCM',
//     personalMail: 'sontung@gmail.com',
//     personalMobile: '123-456-7890',
//     relativeName: 'Dat G',
//     relativeMobile: '987-654-3210',  
//   ),
//   EmployeeInf(
//     name: 'Andree RH',
//     role: 'Designer',
//     mail: 'lefthand@gmail.com',
//     mobile: '123-456-7890',
//     department: 'Research & Development',
//     manager: 'Jack J97',
//     isManager: false,  
//     workLocation: 'Office',
//     schedule: 'Standard 40 hours/week',  
//     salaryStructure: 'Employee',
//     contractType: 'Permanent',  
//     cost: 25.0000,  
//     personalAddress: 'HCM',
//     personalMail: 'sontung@gmail.com',
//     personalMobile: '123-456-7890',
//     relativeName: 'Dat G',
//     relativeMobile: '987-654-3210',  
//   ),
//   EmployeeInf(
//     name: 'Decao CG',
//     role: 'Actuary',
//     mail: 'lamminh@gmail.com',
//     mobile: '123-456-7890',
//     department: 'Research & Development',
//     manager: 'Jack J97',
//     isManager: false,  
//     workLocation: 'Office',
//     schedule: 'Standard 40 hours/week',  
//     salaryStructure: 'Employee',
//     contractType: 'Permanent',  
//     cost: 25.0000,  
//     personalAddress: 'HCM',
//     personalMail: 'sontung@gmail.com',
//     personalMobile: '123-456-7890',
//     relativeName: 'Dat G',
//     relativeMobile: '987-654-3210',  
//   ),
//   EmployeeInf(
//     name: 'Minh Tien',
//     role: 'Collaborator',
//     mail: 'tandien@gmail.com',
//     mobile: '123-456-7890',
//     department: 'Research & Development',
//     manager: 'Jack J97',
//     isManager: false,  
//     workLocation: 'Office',
//     schedule: 'Part-time 25 hours/week',  
//     salaryStructure: 'Employee',
//     contractType: 'Permanent',  
//     cost: 25.0000,  
//     personalAddress: 'HCM',
//     personalMail: 'sontung@gmail.com',
//     personalMobile: '123-456-7890',
//     relativeName: 'Dat G',
//     relativeMobile: '987-654-3210',  
//   ),
//   //Human Resource
//   EmployeeInf(
//     name: 'Chau Bui',
//     role: 'Human Resource',
//     mail: 'chaubui@gmail.com',
//     mobile: '678-901-2345',
//     department: 'Human Resource',
//     manager: 'Son Tung MTP',
//     isManager: true,  
//     workLocation: 'Office',
//     schedule: 'Standard 40 hours/week',  
//     salaryStructure: 'Employee',
//     contractType: 'Permanent',  
//     cost: 25.0000,  
//     personalAddress: 'HCM',
//     personalMail: 'sontung@gmail.com',
//     personalMobile: '123-456-7890',
//     relativeName: 'Dat G',
//     relativeMobile: '987-654-3210',  
//   ),
//   EmployeeInf(
//     name: 'Dam Tong',
//     role: 'Human Resource',
//     mail: 'ngoclinh@gmail.com',
//     mobile: '789-012-3456',
//     department: 'Human Resource',
//     manager: 'Chau Bui',
//     isManager: false,  
//     workLocation: 'Office',
//     schedule: 'Standard 40 hours/week',  
//     salaryStructure: 'Employee',
//     contractType: 'Permanent',  
//     cost: 25.0000,  
//     personalAddress: 'HCM',
//     personalMail: 'sontung@gmail.com',
//     personalMobile: '123-456-7890',
//     relativeName: 'Dat G',
//     relativeMobile: '987-654-3210',  
//   ),
//   //Sales
//   EmployeeInf(
//     name: 'Tran Thanh',
//     role: 'Content Creator',
//     mail: 'mrcry@gmail.com',
//     mobile: '901-234-5678',
//     department: 'Sales',
//     manager: 'Son Tung MTP',
//     isManager: true,  
//     workLocation: 'Office',
//     schedule: 'Standard 40 hours/week',  
//     salaryStructure: 'Employee',
//     contractType: 'Permanent',  
//     cost: 25.0000,  
//     personalAddress: 'HCM',
//     personalMail: 'sontung@gmail.com',
//     personalMobile: '123-456-7890',
//     relativeName: 'Dat G',
//     relativeMobile: '987-654-3210',  
//   ),
//   EmployeeInf(
//     name: 'Chi Pu',
//     role: 'Content Creator',
//     mail: 'cbc@gmail.com',
//     mobile: '012-345-6789',
//     department: 'Sales',
//     manager: 'Tran Thanh',
//     isManager: false,  
//     workLocation: 'Office',
//     schedule: 'Standard 40 hours/week',  
//     salaryStructure: 'Employee',
//     contractType: 'Permanent',  
//     cost: 25.0000,  
//     personalAddress: 'HCM',
//     personalMail: 'sontung@gmail.com',
//     personalMobile: '123-456-7890',
//     relativeName: 'Dat G',
//     relativeMobile: '987-654-3210',  
//   ),
//   EmployeeInf(
//     name: 'Trung Tin',
//     role: 'Collaborator',
//     mail: 'trungtin@gmail.com',
//     mobile: '123-456-7890',
//     department: 'Sales',
//     manager: 'Tran Thanh',
//     isManager: false,  
//     workLocation: 'Office',
//     schedule: 'Part-time 25 hours/week',  
//     salaryStructure: 'Employee',
//     contractType: 'Permanent',  
//     cost: 25.0000,  
//     personalAddress: 'HCM',
//     personalMail: 'sontung@gmail.com',
//     personalMobile: '123-456-7890',
//     relativeName: 'Dat G',
//     relativeMobile: '987-654-3210',  
//   ),
//   EmployeeInf(
//     name: 'Thang Ngot',
//     role: 'Sales',
//     mail: 'nhactamda@gmail.com',
//     mobile: '123-456-7890',
//     department: 'Sales',
//     manager: 'Tran Thanh',
//     isManager: false,  
//     workLocation: 'Office',
//     schedule: 'Standard 40 hours/week',  
//     salaryStructure: 'Employee',
//     contractType: 'Permanent',  
//     cost: 25.0000,  
//     personalAddress: 'HCM',
//     personalMail: 'sontung@gmail.com',
//     personalMobile: '123-456-7890',
//     relativeName: 'Dat G',
//     relativeMobile: '987-654-3210',  
//   ),
//   EmployeeInf(
//     name: 'Truong Giang',
//     role: 'Sales',
//     mail: 'hetai@gmail.com',
//     mobile: '123-456-7890',
//     department: 'Sales',
//     manager: 'Tran Thanh',
//     isManager: false,  
//     workLocation: 'Office',
//     schedule: 'Standard 40 hours/week',  
//     salaryStructure: 'Employee',
//     contractType: 'Permanent',  
//     cost: 25.0000,  
//     personalAddress: 'HCM',
//     personalMail: 'sontung@gmail.com',
//     personalMobile: '123-456-7890',
//     relativeName: 'Dat G',
//     relativeMobile: '987-654-3210',  
//   ),
//   //Accounting
//   EmployeeInf(
//     name: 'Chi Long',
//     role: 'Accountant',
//     mail: 'mck@gmail.com',
//     mobile: '123-456-7890',
//     department: 'Accounting',
//     manager: 'Son Tung MTP',
//     isManager: true,  
//     workLocation: 'Office',
//     schedule: 'Standard 40 hours/week',  
//     salaryStructure: 'Employee',
//     contractType: 'Permanent',  
//     cost: 25.0000,  
//     personalAddress: 'HCM',
//     personalMail: 'sontung@gmail.com',
//     personalMobile: '123-456-7890',
//     relativeName: 'Dat G',
//     relativeMobile: '987-654-3210',  
//   ),
//   //Quality
//   EmployeeInf(
//     name: 'Thinh Noo',
//     role: 'Quality Assurance',
//     mail: 'noo@gmail.com',
//     mobile: '234-567-8901',
//     department: 'Quality',
//     manager: 'Son Tung MTP',
//     isManager: true,  
//     workLocation: 'Office',
//     schedule: 'Standard 40 hours/week',  
//     salaryStructure: 'Employee',
//     contractType: 'Permanent',  
//     cost: 25.0000,  
//     personalAddress: 'HCM',
//     personalMail: 'sontung@gmail.com',
//     personalMobile: '123-456-7890',
//     relativeName: 'Dat G',
//     relativeMobile: '987-654-3210',  
//   ),
//   EmployeeInf(
//     name: 'Ngoc Thy',
//     role: 'Tester',
//     mail: 'victoria@gmail.com',
//     mobile: '567-890-1234',
//     department: 'Quality',
//     manager: 'Thinh Noo',
//     isManager: false,  
//     workLocation: 'Office',
//     schedule: 'Standard 40 hours/week',  
//     salaryStructure: 'Employee',
//     contractType: 'Permanent',  
//     cost: 25.0000,  
//     personalAddress: 'HCM',
//     personalMail: 'sontung@gmail.com',
//     personalMobile: '123-456-7890',
//     relativeName: 'Dat G',
//     relativeMobile: '987-654-3210',  
//   ),
//   //Financial
//   EmployeeInf(
//     name: 'Obito',
//     role: 'Business Analysis',
//     mail: 'vstra@gmail.com',
//     mobile: '123-456-7890',
//     department: 'Financial',
//     manager: 'Son Tung MTP',
//     isManager: true,  
//     workLocation: 'Office',
//     schedule: 'Standard 40 hours/week',  
//     salaryStructure: 'Employee',
//     contractType: 'Permanent',  
//     cost: 25.0000,  
//     personalAddress: 'HCM',
//     personalMail: 'sontung@gmail.com',
//     personalMobile: '123-456-7890',
//     relativeName: 'Dat G',
//     relativeMobile: '987-654-3210',  
//   ),
// ];
