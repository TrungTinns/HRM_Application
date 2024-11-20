class PayslipData {
  final String name;
  final String reference;
  final String contractRef;
  final DateTime startDate;
  final DateTime endDate;
  final String batch;
  final String structure;
  final String others;
  final String status;
  static final List<String> defaultStatus = ['Draft', 'Waiting', 'Done', 'Paid'];
  static final List<String> defaultStructures = ['Regular Pay', 'Worker Pay'];
  static final List<String> defaultOthers = ['Deduction', 'Reimbursement', 'Attachment of Salary', ' Assignment of Salary', 'Child Support'];

  PayslipData({
    required this.name,
    required this.reference,
    required this.contractRef,
    required this.startDate,
    required this.endDate,
    required this.batch,
    required this.structure,
    required this.others,
    required this.status,
  });

  factory PayslipData.fromMap(Map<String, dynamic> data) {
    return PayslipData(
      name: data['Employee'],
      reference: data['Reference'],
      contractRef: data['Contract Reference'],
      startDate: data['Start Date'],
      endDate: data['End Date'],
      batch: data['Batch'],
      structure: data['Structure'],
      others: data['Others'],
      status: data['Status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Employee': name,
      'Reference': reference,
      'Contract Reference': contractRef,
      'Start Date': startDate,
      'End Date': endDate,
      'Batch': batch,
      'Structure': structure,
      'Others': others,
      'Status': status,
    };
  }
}

List<Map<String, dynamic>> getPayslips() {
  return payslips.map((payslips) => payslips.toMap()).toList();
}

void updatePayslip(int index, Map<String, dynamic> updatePayslip) {
  if (index >= 0 && index < payslips.length) {
    payslips[index] = PayslipData.fromMap(updatePayslip);
  }
}

List<PayslipData> payslips = [
  PayslipData(
    name: 'Son Tung MTP',
    contractRef: 'REF123',
    reference: 'SLIP/001',
    startDate: DateTime(2024, 04, 01),
    endDate: DateTime(2024, 04, 30),
    batch: '04/2024',
    structure: 'Regular Pay',
    others: 'Deduction',
    status: 'Done',
  ),
  PayslipData(
    name: 'Jack J97',
    contractRef: 'REF124',
    reference: 'SLIP/002',
    startDate: DateTime(2024, 04, 01),
    endDate: DateTime(2024, 04, 30),
    batch: '04/2024',
    structure: 'Worker Pay',
    others: 'Reimbursement',
    status: 'Paid',
  ),
  PayslipData(
    name: 'Chi Pu',
    contractRef: 'REF003',
    reference: 'SLIP/003',
    startDate: DateTime(2024, 05, 01),
    endDate: DateTime(2024, 05, 31),
    batch: '05/2024',
    structure: 'Regular Pay',
    others: 'Attachment of Salary',
    status: 'Draft',
  ),
  PayslipData(
    name: 'Decao',
    contractRef: 'REF004',
    reference: 'SLIP/004',
    startDate: DateTime(2024, 06, 01),
    endDate: DateTime(2024, 06, 30),
    batch: '06/2024',
    structure: 'Regular Pay',
    others: 'Child Support',
    status: 'Done',
  ),
  PayslipData(
    name: 'HieuThuHai',
    contractRef: 'REF005',
    reference: 'SLIP/005',
    startDate: DateTime(2024, 06, 01),
    endDate: DateTime(2024, 06, 30),
    batch: '06/2024',
    structure: 'Worker Pay',
    others: 'Child Support',
    status: 'Paid',
  ),
  PayslipData(
    name: 'Huong Tit',
    contractRef: 'REF006',
    reference: 'SLIP/006',
    startDate: DateTime(2024, 06, 01),
    endDate: DateTime(2024, 06, 30),
    batch: '06/2024',
    structure: 'Regular Pay',
    others: 'Reimbursement',
    status: 'Draft',
  ),
  PayslipData(
    name: 'Hieu PC',
    contractRef: 'REF007',
    reference: 'SLIP/007',
    startDate: DateTime(2024, 07, 01),
    endDate: DateTime(2024, 07, 31),
    batch: '07/2024',
    structure: 'Worker Pay',
    others: 'Deduction',
    status: 'Waiting',
  ),
];

