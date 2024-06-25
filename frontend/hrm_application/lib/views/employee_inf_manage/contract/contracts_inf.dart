class ContractData {
  final String employeeName;
  final String reference;
  final String department;
  final String position;
  final DateTime startDate;
  final DateTime endDate;
  final String schedule;
  final String salaryStructure;
  final String contractType;
  final String status;

  ContractData({
    required this.employeeName,
    required this.reference,
    required this.department,
    required this.position,
    required this.startDate,
    required this.endDate,
    required this.schedule,
    required this.salaryStructure,
    required this.contractType,
    required this.status,
  });

  factory ContractData.fromMap(Map<String, dynamic> data) {
    return ContractData(
      employeeName: data['Employee'],
      reference: data['Reference'],
      department: data['Department'],
      position: data['Position'],
      startDate: data['Start Date'],
      endDate: data['End Date'],
      salaryStructure: data['Salary Structure'],
      contractType: data['Contract Type'],
      schedule: data['Schedule'],
      status: data['Status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Employee': employeeName,
      'Reference': reference,
      'Department': department,
      'Position': position,
      'Start Date': startDate,
      'End Date': endDate,
      'Salary Structure': salaryStructure,
      'Contract Type': contractType,
      'Schedule': schedule,
      'Status': status,
    };
  }
}

List<Map<String, dynamic>> getContracts() {
  return contracts.map((contract) => contract.toMap()).toList();
}

void updateContract(int index, Map<String, dynamic> updatedContract) {
  if (index >= 0 && index < contracts.length) {
    contracts[index] = ContractData.fromMap(updatedContract);
  }
}

List<ContractData> contracts = [
  ContractData(
    employeeName: 'Son Tung MTP',
    reference: 'REF123',
    department: 'Administration',
    position: 'Director',
    startDate: DateTime(2021-06-15), 
    endDate: DateTime(2021-06-15),
    salaryStructure: 'Employee',
    contractType: 'Permanent',
    schedule: 'Standard 40 hours/week',
    status: 'Running',
  ),
  ContractData(
    employeeName: 'Jack J97',
    reference: 'REF124',
    department: 'Research & Development',
    position: 'Project Manager',
    startDate: DateTime(2021-06-15),
    endDate: DateTime(2021-06-15),
    salaryStructure: 'Employee',
    contractType: 'Temporary',
    schedule: 'Part-time 25 hours/week-',
    status: 'Expired',
  ),
  ContractData(
    employeeName: 'Chi Pu',
    reference: 'REF003',
    department: 'Sales',
    position: 'Content Creator',
    startDate: DateTime(2021-06-15),
    endDate: DateTime(2021-06-15),
    salaryStructure: 'Employee',
    contractType: 'Full-time',
    schedule: 'Standard 40 hours/week',
    status: 'Running',
  ),
];

