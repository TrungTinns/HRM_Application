// import 'package:flutter/material.dart';
// import 'package:hrm_application/Views/Services/EmployeeManage/Employee/employees_inf.dart';
// import 'package:hrm_application/Widgets/colors.dart';
// import 'package:intl/intl.dart';

// class AttendanceForm extends StatefulWidget {
//   final String employee;
//   final int dayIndex;
//   final AttendanceData data;
//   final Function(AttendanceData) onSave;

//   AttendanceForm({
//     required this.employee,
//     required this.dayIndex,
//     required this.data,
//     required this.onSave
//   });

//   @override
//   _AttendanceFormState createState() => _AttendanceFormState();
// }

// class _AttendanceFormState extends State<AttendanceForm> {
//   late AttendanceData data;
//   TextEditingController nameController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     data = widget.data;
//     nameController.text = widget.employee;
//   }

//   Widget buildTextFieldRow(String label, TextEditingController controller, {bool isDateField = false}) {
//     return Row(
//       children: [
//         SizedBox(
//           width: 200,
//           child: Text(
//             label,
//             style: const TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16),
//           ),
//         ),
//         Expanded(
//           child: GestureDetector(
//             onTap: () {
//               // if (isDateField) {
//               //   _selectDate(controller);
//               // }
//             },
//             child: isDateField
//                 ? AbsorbPointer(
//                     child: TextField(
//                       controller: controller,
//                       style: const TextStyle(color: textColor),
//                       decoration: const InputDecoration(
//                         filled: true,
//                         fillColor: snackBarColor,
//                       ),
//                     ),
//                   )
//                 : TextField(
//                     controller: controller,
//                     style: const TextStyle(color: textColor),
//                     decoration: const InputDecoration(
//                       filled: true,
//                       fillColor: snackBarColor,
//                     ),
//                   ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildDropdownRow(String label, TextEditingController controller, List<String> items) {  
//     return Row(
//       children: [
//         SizedBox(
//           width: 200,
//           child: Text(
//             label,
//             style: const TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16),
//           ),
//         ),
//         Expanded(
//           child: DropdownButtonFormField<String>(
//             dropdownColor: dropdownColor,
//             items: items.map((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value, style: const TextStyle(color: textColor)),
//               );
//             }).toList(),
//             onChanged: (value) {
//               controller.text = value!;
//             },
//             decoration: const InputDecoration(
//               filled: true,
//               fillColor: snackBarColor,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Column(
//                     children: [
//                       buildDropdownRow('Employee', nameController, getNameEmp(employees)),
//                       Text('Check In:', style: TextStyle(fontWeight: FontWeight.bold)),
//                       Text(DateFormat('dd/MM/yyyy HH:mm:ss').format(data.checkIn ?? DateTime.now())),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Column(
//                     children: [
//                       Text(
//                         'Attendance Form',
//                         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.close),
//                         onPressed: () => Navigator.of(context).pop(),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Employee:', style: TextStyle(fontWeight: FontWeight.bold)),
//                 CircleAvatar(
//                   child: Text(widget.employee[0]),
//                 ),
//                 SizedBox(width: 8),
//                 Text(widget.employee),
//               ],
//             ),
//             SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
                
//               ],
//             ),
//             SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Check Out:', style: TextStyle(fontWeight: FontWeight.bold)),
//                 Text(DateFormat('dd/MM/yyyy HH:mm:ss').format(data.checkOut ?? DateTime.now())),
//               ],
//             ),
//             SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Worked Hours:', style: TextStyle(fontWeight: FontWeight.bold)),
//                 Text('${data.workDuration.inHours}:${data.workDuration.inMinutes.remainder(60).toString().padLeft(2, '0')}'),
//               ],
//             ),
//             SizedBox(height: 10),
//             Text('Comments:', style: TextStyle(fontWeight: FontWeight.bold)),
//             TextFormField(
//               initialValue: data.comment,
//               onChanged: (value) => setState(() => data.comment = value),
//             ),
//             SizedBox(height: 20),
//             Align(
//               alignment: Alignment.bottomRight,
//               child: ElevatedButton(
//                 onPressed: () {
//                   widget.onSave(data);
//                   Navigator.of(context).pop();
//                 },
//                 child: Text(data.isPresent ? 'Update' : 'Check In'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class AttendanceData {
//   bool isPresent;
//   DateTime? checkIn;
//   DateTime? checkOut;
//   Duration workDuration;
//   String comment;

//   AttendanceData({
//     this.isPresent = false,
//     this.checkIn,
//     this.checkOut,
//     this.workDuration = Duration.zero,
//     this.comment = '',
//   });
// }