class ContractData {
  static List<Map<String, dynamic>> contracts = [
    {
      'Employee': 'John Doe',
      'Reference': 'REF123',
      'Department': 'Administration',
      'Position': 'Director',
      'Start Date': '2022-01-01',
      'End Date': '2023-01-01',
      'Contract Type': 'Permanent',
      'Schedule': 'Full-time',
      'Status': 'Running',
    },
    {
      'Employee': 'Alice Johnson',
      'Reference': 'REF124',
      'Department': 'Research & Development',
      'Position': 'Project Manager',
      'Start Date': '2021-06-15',
      'End Date': '2022-06-15',
      'Contract Type': 'Temporary',
      'Schedule': 'Part-time',
      'Status': 'Expired',
    },
    {
      'Employee': 'Bob Smith',
      'Reference': 'REF125',
      'Department': 'Marketing',
      'Position': 'Coordinator',
      'Start Date': '2022-03-01',
      'End Date': '2023-03-01',
      'Contract Type': 'Full-time',
      'Schedule': 'Full-time',
      'Status': 'Cancelled',
    },
  ];

  static List<Map<String, dynamic>> getContracts() {
    return contracts;
  }

  static void updateContract(int index, Map<String, dynamic> updatedContract) {
    if (index >= 0 && index < contracts.length) {
      contracts[index] = updatedContract;
    }
  }
}