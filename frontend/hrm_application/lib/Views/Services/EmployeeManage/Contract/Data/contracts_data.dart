import 'package:hrm_application/API/api.dart';
import 'package:hrm_application/widgets/platform_options.dart';

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
    final platformOptions = PlatformOptions.currentPlatform;
    final apiUrl =
        'http://${PlatformOptions.host}:${PlatformOptions.port}/api/v1/employee/contract';
    List<ContractData> contracts = await fetchAPI<ContractData>(
      apiUrl: apiUrl,
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
