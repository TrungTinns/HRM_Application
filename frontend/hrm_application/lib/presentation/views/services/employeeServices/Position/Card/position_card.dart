// import 'package:flutter/material.dart';
// import 'package:hrm_application/Views/Services/EmployeeManage/Employee/employees_inf.dart';
// import 'package:hrm_application/Views/Services/EmployeeManage/Position/Detail/jobposition_detail.dart';
// import 'package:hrm_application/Views/Services/EmployeeManage/Position/Manage/position_manage.dart';
// import 'package:hrm_application/Views/Services/RecruitmentProcessManage/JobPosition/jobposition_inf.dart';
// import 'package:hrm_application/Widgets/colors.dart';


// class PositionCard extends StatelessWidget {
//   final String role;
//   final String department;
//   final String mail;
//   final String jobLocation;
//   final String type;
//   final int target;
//   bool isPublished;
//   final String recruiter;
//   final String interviewer;
//   final String? details;
//   final VoidCallback onDelete;
//   final ValueChanged<JobPositionInf> onUpdate;

//   PositionCard({ 
//     required this.department,
//     required this.mail,
//     required this.jobLocation,
//     required this.role,
//     required this.type,
//     required this.target,
//     required this.isPublished,
//     required this.recruiter,
//     required this.interviewer,
//     this.details,
//     required this.onDelete,
//     required this.onUpdate,
//   });

//   @override
//   Widget build(BuildContext context) {
//     int employeeCount = countEmployeesInPosition(employees, role);
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     role,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (ctx) =>
//                         PositionDetail(
//                           role: role,
//                           department: department,
//                           mail: mail,
//                           jobLocation: jobLocation,
//                           type: type,
//                           target: target,
//                           isPublished: isPublished,
//                           recruiter: recruiter,
//                           interviewer: interviewer,
//                           details: details,
//                           onDelete: onDelete,
//                           onUpdate: onUpdate,
//                         )
//                       ));
//                     },
//                     icon: const Icon(Icons.more_vert)
//                   )
//                 ],
//               ),
//             ),
//             const SizedBox(height: 30,),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (ctx) => EmployeeofPosition(
//                           initialRole: role,
//                         ),
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: textColor,
//                     backgroundColor: primaryColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                   ),
//                   child: Text('$employeeCount Employees', style: const TextStyle(color: Colors.white, fontSize: 16)),
//                 ),
//                 Text('$target To Recruit', style: const TextStyle(color: primaryColor, fontSize: 16, fontWeight: FontWeight.bold)),
//               ],
//             ),
//             const SizedBox(height: 10,),
//             Divider(color: Colors.grey.shade300),
//             Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//               children: [                          
//                 Switch(               
//                   activeTrackColor: Colors.green,
//                   value: isPublished,
//                   onChanged: (value) {
//                     isPublished = value;
//                     onUpdate(
//                       JobPositionInf(
//                         role: role,
//                         department: department,
//                         mail: mail,
//                         jobLocation: jobLocation,
//                         type: type,
//                         target: target,
//                         recruiter: recruiter,
//                         interviewer: interviewer,
//                         details: details,
//                         isPublished: isPublished,
//                       ),
//                     );
//                   },
//                 ),   
//                 const SizedBox(width: 10),
//                 const Text(
//                   'Is Published', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
//                 ),
//               ],
//             ),            
//           ],
//         ),
//       ),
//     );
//   }
// }
