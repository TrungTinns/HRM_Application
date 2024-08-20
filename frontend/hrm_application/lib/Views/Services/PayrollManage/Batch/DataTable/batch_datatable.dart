// import 'package:flutter/material.dart';
// import 'package:hrm_application/Views/Services/PayrollManage/Batch/Detail/batch_detail.dart';
// import 'package:hrm_application/Views/Services/PayrollManage/Batch/batches_inf.dart';
// import 'package:hrm_application/widgets/colors.dart';
// import 'package:pluto_grid/pluto_grid.dart';

// class BatchDataTable extends StatefulWidget {
//   @override
//   _BatchDataTableState createState() => _BatchDataTableState();
// }

// class _BatchDataTableState extends State<BatchDataTable> {
//   List<PlutoRow> rows = [];

//   @override
//   void initState() {
//     super.initState();
//     rows = getBatches().map((batch) {
//       return PlutoRow(cells: {
//         'Batch': PlutoCell(value: batch['Batch']),
//         'Start Date': PlutoCell(value: batch['Start Date'].toString()),
//         'End Date': PlutoCell(value: batch['End Date'].toString()),
//         'Status': PlutoCell(value: batch['Status']),
//       });
//     }).toList();
//   }

//   void deleteRow(int index) {
//     setState(() {
//       rows.removeAt(index);
//       batches.removeAt(index);
//     });
//   }

//   void updateBatch(int index, BatchData updatedBatch) {
//     setState(() {
//       rows[index] = PlutoRow(cells: {
//         'Batch': PlutoCell(value: updatedBatch.batch),
//         'Start Date': PlutoCell(value: updatedBatch.startDate.toString()),
//         'End Date': PlutoCell(value: updatedBatch.endDate.toString()),
//         'Status': PlutoCell(value: updatedBatch.status),
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<PlutoColumn> columns = [
//       PlutoColumn(
//         title: 'Batch',
//         field: 'Batch',
//         type: PlutoColumnType.text(),
//       ),
//       PlutoColumn(
//         title: 'Start Date',
//         field: 'Start Date',
//         type: PlutoColumnType.date(),
//       ),
//       PlutoColumn(
//         title: 'End Date',
//         field: 'End Date',
//         type: PlutoColumnType.date(),
//       ),
//       PlutoColumn(
//         title: 'Status',
//         field: 'Status',
//         type: PlutoColumnType.select(BatchData.defaultStatus),
//       ),
//     ];

//     return PlutoGrid(
//       columns: columns,
//       rows: rows,
//       onChanged: (PlutoGridOnChangedEvent event) {
//         // Handle changes if necessary
//       },
//       onRowDoubleTap: (event) {
//         final row = event.row;
//         final index = rows.indexOf(row);
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (ctx) => BatchDetail(
//               batch: row.cells['Batch']!.value,
//               startDate: row.cells['Start Date']!.value,
//               endDate: row.cells['End Date']!.value,
//               status: row.cells['Status']!.value,
//               onDelete: () {
//                 deleteRow(index);
//               },
//               onUpdate: (updatedBatch) {
//                 final updatedBatchMap = updatedBatch.toMap();
//                 final updatedBatchData = BatchData.fromMap(updatedBatchMap);
//                 updateBatch(index, updatedBatchData);
//               },
//             ),
//           ),
//         );
//       },
//       configuration: const PlutoGridConfiguration(
//         style: PlutoGridStyleConfig(
//           gridBorderColor: textColor,
//           menuBackgroundColor: snackBarColor,
//           iconColor: textColor,
//           cellColorInEditState: snackBarColor,
//           gridBackgroundColor: snackBarColor,
//           cellTextStyle: TextStyle(color: textColor),
//           columnTextStyle: TextStyle(color: textColor),
//           rowColor: dropdownColor,
//           activatedColor: Color.fromRGBO(38, 42, 54, 1),
//           activatedBorderColor: textColor,
//         ),
//       ),
//     );
//   }
// }
