class BatchData {
  final String batch;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  static final List<String> defaultStatus = ['New', 'Confirmed', 'Done', 'Paid'];

  BatchData({
    required this.startDate,
    required this.endDate,
    required this.batch,
    required this.status,
  });

  factory BatchData.fromMap(Map<String, dynamic> data) {
    return BatchData(
      startDate: data['Start Date'],
      endDate: data['End Date'],
      batch: data['Batch'],
      status: data['Status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Start Date': startDate,
      'End Date': endDate,
      'Batch': batch,
      'Status': status,
    };
  }
}

List<Map<String, dynamic>> getBatches() {
  return batches.map((batches) => batches.toMap()).toList();
}

void updateBatch(int index, Map<String, dynamic> updateBatch) {
  if (index >= 0 && index < batches.length) {
    batches[index] = BatchData.fromMap(updateBatch);
  }
}

List<BatchData> batches = [
  BatchData(
    startDate: DateTime(2024-04-01),
    endDate: DateTime(2024-04-30),
    batch: '04/2024',
    status: 'New',
  ),
  BatchData(
    startDate: DateTime(2024-04-01),
    endDate: DateTime(2024-04-30),
    batch: '04/2024',
    status: 'Confirmed',
  ),
  BatchData(
    startDate: DateTime(2024-05-01),
    endDate: DateTime(2024-05-31),
    batch: '05/2024',
    status: 'Paid',
  ),
  BatchData(
    startDate: DateTime(2024-06-01),
    endDate: DateTime(2024-06-30),
    batch: '06/2024',
    status: 'New',
  ),
  BatchData(
    startDate: DateTime(2024-06-01),
    endDate: DateTime(2024-06-30),
    batch: '06/2024',
    status: 'Done',
  ),
  BatchData(
    startDate: DateTime(2024-06-01),
    endDate: DateTime(2024-06-30),
    batch: '06/2024',
    status: 'Done',
  ),
  BatchData(
    startDate: DateTime(2024-07-01),
    endDate: DateTime(2024-07-31),
    batch: '07/2024',
    status: 'New',
  ),
];

