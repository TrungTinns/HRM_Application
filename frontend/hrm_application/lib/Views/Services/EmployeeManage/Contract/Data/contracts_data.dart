import 'package:hrm_application/API/api.dart';

class ContractData {
  final String? id;
  final String? reference;
  final String? department;
  final String? empName;
  final String? position;
  final String? status;
  final String? schedule;
  final String?  schedulePay;
  final String? salaryStructure;
  final String? contractType;
  final double? cost;
  final String? note;
  final String? wageType;
  final DateTime? startDate;
  final DateTime? endDate;
  static final List<String> defaultSalaryStructures = ['Employee', 'Worker'];
  static final List<String> defaultContractTypes = ['Permanent', 'Temporary', 'Seasonal', 'Full-time', 'Part-time'];
  static final List<String> defaultSchedules = ['Standard 40 hours/week', 'Part-time 25 hours/week'];
  static final List<String> defaultStatus = ['Running', 'Expired', 'Cancelled'];
  static final List<String> defaultWageTypes = ['Fixed Wage', 'Hourly Wage'];
  static final List<String> defaultSchedulePays = ['Annually', 'Semi-Annually', 'Quarterly', 'Bi-monthly', 'Monthly', 'Semi-Monthly', 'Bi-weekly', 'Weekly', 'Daily'];

  ContractData({
    this.id,
    this.reference,
    this.department,
    this.empName,
    this.position,
    this.status,
    this.schedule,
    this.schedulePay,
    this.salaryStructure,
    this.contractType,
    this.cost,
    this.note,
    this.wageType,
    this.startDate,
    this.endDate,
  });

  factory ContractData.fromJson(Map<String, dynamic> json) {
    return ContractData(
      id: json['id'],
      reference: json['referenceName'],
      department: json['department'],
      empName: json['empName'],
      position: json['position'],
      status: json['status'],
      schedule: json['schedule'],
      schedulePay: json['schedulePay'],
      salaryStructure: json['salaryStructure'],
      contractType: json['contractType'],
      cost: json['cost'] as double? ?? 0.0,
      note: json['note'],
      wageType: json['wageType'],
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
    );
  }

  factory ContractData.fromMap(Map<String, dynamic> data) {
    return ContractData(
      empName: data['Employee'],
      reference: data['Reference'],
      department: data['Department'],
      position: data['Position'],
      startDate: data['Start Date'],
      endDate: data['End Date'],
      salaryStructure: data['Salary Structure'],
      contractType: data['Contract Type'],
      schedule: data['Schedule'],
      status: data['Status'],
      cost: data['Salary'],
      note: data['Note'],
      wageType: data['Wage Type'],
      schedulePay: data['Schedule Pay'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Employee': empName,
      'Reference': reference,
      'Department': department,
      'Position': position,
      'Start Date': startDate,
      'End Date': endDate,
      'Salary Structure': salaryStructure,
      'Contract Type': contractType,
      'Schedule': schedule,
      'Status': status,
      'Salary': cost,
      'Note': note,
      'Wage Type': wageType,
      'Schedule Pay': schedulePay,
    };
  }
}

Future<List<ContractData>> fetchContracts() async {
  try {
    List<ContractData> contracts = await fetchAPI<ContractData>(
      apiUrl: 'http://localhost:9001/api/v1/employee/contract',
      fromJson: (json) {
        return ContractData(
          id: json['id'] ?? " ",
          reference: json['referenceName'] ?? " ",
          department: json['department'] ?? " ",
          empName: json['empName'] ?? " ",
          position: json['position'] ?? " ",
          status: json['status'] ?? " ",
          schedule: json['schedule'] ?? " ",
          schedulePay: json['schedulePay'] ?? " ",
          salaryStructure: json['salaryStructure'] ?? " ",
          contractType: json['contractType'] ?? " ",
          cost: json['cost'] as double? ?? 0.0,
          note: json['note'] ?? " ",
          wageType: json['wageType'] ?? " ",
          startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
          endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
        );
      },
    );
    print('Fetched ${contracts.length} contracts');
    return contracts;
  } catch (e) {
    print('Error fetching contracts: $e');
    return [];
  }
}
// class ContractData {
//   final String name;
//   final String reference;
//   final String department;
//   final String position;
//   final DateTime startDate;
//   final DateTime endDate;
//   final String schedule;
//   final String salaryStructure;
//   final String contractType;
//   final String status;
//   final double? salary;
//   final String? note;
//   final String? wageType;
//   final String? schedulePay;
//   static final List<String> defaultSalaryStructures = ['Employee', 'Worker'];
//   static final List<String> defaultContractTypes = ['Permanent', 'Temporary', 'Seasonal', 'Full-time', 'Part-time'];
//   static final List<String> defaultSchedules = ['Standard 40 hours/week', 'Part-time 25 hours/week'];
//   static final List<String> defaultStatus = ['Running', 'Expired', 'Cancelled'];
//   static final List<String> defaultWageTypes = ['Fixed Wage', 'Hourly Wage'];
//   static final List<String> defaultSchedulePays = ['Annually', 'Semi-Annually', 'Quarterly', 'Bi-monthly', 'Monthly', 'Semi-Monthly', 'Bi-weekly', 'Weekly', 'Daily'];

//   ContractData({
//     required this.name,
//     required this.reference,
//     required this.department,
//     required this.position,
//     required this.startDate,
//     required this.endDate,
//     required this.schedule,
//     required this.salaryStructure,
//     required this.contractType,
//     required this.status,
//     this.salary,
//     this.note,
//     this.wageType,
//     this.schedulePay,
//   });


//   factory ContractData.fromMap(Map<String, dynamic> data) {
//     return ContractData(
//       name: data['Employee'],
//       reference: data['Reference'],
//       department: data['Department'],
//       position: data['Position'],
//       startDate: data['Start Date'],
//       endDate: data['End Date'],
//       salaryStructure: data['Salary Structure'],
//       contractType: data['Contract Type'],
//       schedule: data['Schedule'],
//       status: data['Status'],
//       salary: data['Salary'],
//       note: data['Note'],
//       wageType: data['Wage Type'],
//       schedulePay: data['Schedule Pay'],
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'Employee': name,
//       'Reference': reference,
//       'Department': department,
//       'Position': position,
//       'Start Date': startDate,
//       'End Date': endDate,
//       'Salary Structure': salaryStructure,
//       'Contract Type': contractType,
//       'Schedule': schedule,
//       'Status': status,
//       'Salary': salary,
//       'Note': note,
//       'Wage Type': wageType,
//       'Schedule Pay': schedulePay,
//     };
//   }
// }

// List<Map<String, dynamic>> getContracts() {
//   return contracts.map((contract) => contract.toMap()).toList();
// }

// void updateContract(int index, Map<String, dynamic> updatedContract) {
//   if (index >= 0 && index < contracts.length) {
//     contracts[index] = ContractData.fromMap(updatedContract);
//   }
// }

// List<ContractData> contracts = [
//   ContractData(
//     name: 'Son Tung MTP',
//     reference: 'REF123',
//     department: 'Administration',
//     position: 'Director',
//     startDate: DateTime(2021 ,06 ,15), 
//     endDate: DateTime(2021 ,06 ,15),
//     salaryStructure: 'Employee',
//     contractType: 'Permanent',
//     schedule: 'Standard 40 hours/week',
//     status: 'Running',
//     salary: 10000000,
//     note: 'This is a note',
//     wageType: 'Hourly Wage',
//     schedulePay: 'Monthly',
//   ),
//   ContractData(
//     name: 'Jack J97',
//     reference: 'REF124',
//     department: 'Research & Development',
//     position: 'Project Manager',
//     startDate: DateTime(2021 ,06 ,15),
//     endDate: DateTime(2021 ,06 ,15),
//     salaryStructure: 'Employee',
//     contractType: 'Temporary',
//     schedule: 'Part-time 25 hours/week',
//     status: 'Expired',
//     note: 'This is another note',
//     wageType: 'Fixed Wage',
//     schedulePay: 'Weekly',
//   ),
//   ContractData(
//     name: 'Chi Pu',
//     reference: 'REF003',
//     department: 'Sales',
//     position: 'Content Creator',
//     startDate: DateTime(2021 ,06 ,15),
//     endDate: DateTime(2021 ,06 ,15),
//     salaryStructure: 'Employee',
//     contractType: 'Full-time',
//     schedule: 'Standard 40 hours/week',
//     status: 'Running',
//     salary: 20000000,
//     note: 'This is a note',
//     wageType: 'Hourly Wage',
//     schedulePay: 'Monthly',
//   ),
// ];

