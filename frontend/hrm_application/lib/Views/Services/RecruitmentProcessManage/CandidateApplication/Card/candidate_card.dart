// import 'package:flutter/material.dart';
// import 'package:hrm_application/views/recruitment_process_manage/candidate_application/cadidate_inf.dart';
// import 'package:custom_rating_bar/custom_rating_bar.dart';
// import 'package:hrm_application/views/recruitment_process_manage/candidate_application/detail/candidate_detail.dart';

// class ApplicationCard extends StatelessWidget {
//   final String introRole;
//   final String role;
//   final String name;
//   final String mail;
//   final String mobile;
//   final String department;
//   final String? profile;
//   final String? degree;
//   final String? interviewer;
//   final String? recruiter;
//   double? elevation;
//   final String? availability;
//   final double? expectedSalary;
//   final double? proposedSalary;
//   final String? summary;
//   final VoidCallback onDelete;
//   final ValueChanged<CandidateInf> onUpdate;
//   final int progress;

//   ApplicationCard({
//     required this.introRole,
//     required this.role,
//     required this.name,
//     required this.mail,
//     required this.mobile,
//     required this.department,
//     this.profile,
//     this.degree,
//     this.interviewer,
//     this.recruiter,
//     this.elevation,
//     this.availability,
//     this.expectedSalary,
//     this.proposedSalary,
//     this.summary,
//     required this.onDelete,
//     required this.onUpdate,
//     required this.progress,
//   });

//   @override
//   Widget build(BuildContext context) {
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
//                     name,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (ctx) =>
//                         CandidateDetail(
//                           introRole: introRole,
//                           role: role,
//                           name: name,
//                           mail: mail,
//                           mobile: mobile,
//                           department: department,
//                           profile: profile,
//                           degree: degree,
//                           interviewer: interviewer,
//                           recruiter: recruiter,
//                           availability: availability,
//                           expectedSalary: expectedSalary,
//                           proposedSalary: proposedSalary,
//                           summary: summary,
//                           elevation: elevation,
//                           onDelete: onDelete,
//                           onUpdate: onUpdate,
//                           progress: progress,
//                         )
//                       ));
//                     },
//                     icon: const Icon(Icons.more_vert)
//                   )
//                 ],
//               ),
//             ),
//             Text(role),
//             const SizedBox(height: 10,),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 RatingBar(
//                   filledIcon: Icons.star, 
//                   emptyIcon: Icons.star_border,
//                   initialRating: elevation!,
//                   onRatingChanged: (value) {
//                     elevation = value;
//                     onUpdate(
//                       CandidateInf(
//                         introRole: introRole,
//                         role: role,
//                         name: name,
//                         mail: mail,
//                         mobile: mobile,
//                         department: department,
//                         profile: profile,
//                         degree: degree,
//                         interviewer: interviewer,
//                         recruiter: recruiter,
//                         availability: availability,
//                         expectedSalary: expectedSalary,
//                         proposedSalary: proposedSalary,
//                         summary: summary,
//                         elevation: elevation,
//                         progress: progress
//                       ),
//                     );
//                   },
//                   maxRating: 3,
//                 ),
//                 IconButton(
//                   onPressed: (){
                
//                   },
//                   icon: const Icon(Icons.attachment),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }