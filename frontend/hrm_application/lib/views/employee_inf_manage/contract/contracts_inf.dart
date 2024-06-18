class ContractData {
  String employeeName;
  String reference;
  String department;
  String position;
  String startDate;
  String endDate;
  String contractType;
  String schedule;
  String status;

  ContractData({
    required this.employeeName,
    required this.reference,
    required this.department,
    required this.position,
    required this.startDate,
    required this.endDate,
    required this.contractType,
    required this.schedule,
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
    employeeName: 'John Doe',
    reference: 'REF123',
    department: 'Administration',
    position: 'Director',
    startDate: '2022-01-01',
    endDate: '2023-01-01',
    contractType: 'Permanent',
    schedule: 'Full-time',
    status: 'Running',
  ),
  ContractData(
    employeeName: 'Alice Johnson',
    reference: 'REF124',
    department: 'Research & Development',
    position: 'Project Manager',
    startDate: '2021-06-15',
    endDate: '2022-06-15',
    contractType: 'Temporary',
    schedule: 'Part-time',
    status: 'Expired',
  ),
  ContractData(
    employeeName: 'Trung Tin',
    reference: 'REF003',
    department: 'Research & Development',
    position: 'Dev',
    startDate: '2023-11-12',
    endDate: '2025-11-12',
    contractType: 'Full-time',
    schedule: 'Part-time',
    status: 'Running',
  ),
];

