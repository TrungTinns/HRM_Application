class ContractData {
  final String name;
  final String reference;
  final String department;
  final String position;
  final DateTime startDate;
  final DateTime endDate;
  final String schedule;
  final String salaryStructure;
  final String contractType;
  final String status;
  final double? salary;
  final String? note;
  static final List<String> defaultSalaryStructures = ['Employee', 'Worker'];
  static final List<String> defaultContractTypes = ['Permanent', 'Temporary', 'Seasonal', 'Full-time', 'Part-time'];
  static final List<String> defaultSchedules = ['Standard 40 hours/week', 'Part-time 25 hours/week'];
  static final List<String> defaultStatus = ['Running', 'Expired', 'Cancelled'];

  ContractData({
    required this.name,
    required this.reference,
    required this.department,
    required this.position,
    required this.startDate,
    required this.endDate,
    required this.schedule,
    required this.salaryStructure,
    required this.contractType,
    required this.status,
    this.salary,
    this.note,
  });

  factory ContractData.fromMap(Map<String, dynamic> data) {
    return ContractData(
      name: data['Employee'],
      reference: data['Reference'],
      department: data['Department'],
      position: data['Position'],
      startDate: data['Start Date'],
      endDate: data['End Date'],
      salaryStructure: data['Salary Structure'],
      contractType: data['Contract Type'],
      schedule: data['Schedule'],
      status: data['Status'],
      salary: data['Salary'],
      note: data['Note'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Employee': name,
      'Reference': reference,
      'Department': department,
      'Position': position,
      'Start Date': startDate,
      'End Date': endDate,
      'Salary Structure': salaryStructure,
      'Contract Type': contractType,
      'Schedule': schedule,
      'Status': status,
      'Salary': salary,
      'Note': note,
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
    name: 'Son Tung MTP',
    reference: 'REF123',
    department: 'Administration',
    position: 'Director',
    startDate: DateTime(2021-06-15), 
    endDate: DateTime(2021-06-15),
    salaryStructure: 'Employee',
    contractType: 'Permanent',
    schedule: 'Standard 40 hours/week',
    status: 'Running',
    salary: 10000000,
    note: 'This is a note',
  ),
  ContractData(
    name: 'Jack J97',
    reference: 'REF124',
    department: 'Research & Development',
    position: 'Project Manager',
    startDate: DateTime(2021-06-15),
    endDate: DateTime(2021-06-15),
    salaryStructure: 'Employee',
    contractType: 'Temporary',
    schedule: 'Part-time 25 hours/week',
    status: 'Expired',
    note: 'This is another note',
  ),
  ContractData(
    name: 'Chi Pu',
    reference: 'REF003',
    department: 'Sales',
    position: 'Content Creator',
    startDate: DateTime(2021-06-15),
    endDate: DateTime(2021-06-15),
    salaryStructure: 'Employee',
    contractType: 'Full-time',
    schedule: 'Standard 40 hours/week',
    status: 'Running',
    salary: 20000000,
  ),
];

