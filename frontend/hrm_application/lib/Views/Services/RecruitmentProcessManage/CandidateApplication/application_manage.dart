// import 'package:flutter/material.dart';
// import 'package:hrm_application/Component/Appbar/custom_title_appbar.dart';
// import 'package:hrm_application/Component/Configuration/configuration.dart';
// import 'package:hrm_application/Component/FilterSearch/filter_search.dart';
// import 'package:hrm_application/Component/Search/searchBox.dart';
// import 'package:hrm_application/Views/Home/home.dart';
// import 'package:hrm_application/Views/Services/EmployeeManage/Contract/contracts.dart';
// import 'package:hrm_application/Views/Services/RecruitmentProcessManage/CandidateApplication/Application/candidate_application.dart';
// import 'package:hrm_application/Views/Services/RecruitmentProcessManage/CandidateApplication/Data/cadidate_data.dart';
// import 'package:hrm_application/Views/Services/RecruitmentProcessManage/CandidateApplication/Progress/application_progress.dart';
// import 'package:hrm_application/Views/Services/RecruitmentProcessManage/JobPosition/Data/jobposition_data.dart';
// import 'package:hrm_application/views/services/RecruitmentProcessManage/jobPosition/recruitment.dart';
// import 'package:hrm_application/widgets/colors.dart';

// class ApplicationManage extends StatefulWidget {
//   final String? initialRole;

//   ApplicationManage({this.initialRole});
//   @override
//   _ApplicationManageState createState() => _ApplicationManageState();
// }

// class _ApplicationManageState extends State<ApplicationManage> {
//   TextEditingController introRoleController = TextEditingController();
//   String pageName = 'Applications';
//   bool showCandidateApplication = false;
//   String? activeDropdown;
//   bool showAllApplication = true;
//   String? selectedRole;
//   List<CandidateData> candidates = [];
//   List<String> candidateNames = [];
//   List<JobPositionData> jobPositions = [];
//   List<String> jobPositionNames = [];

//   @override
//   void initState() {
//     super.initState();
//     selectedRole = widget.initialRole;
//     showAllApplication = selectedRole == null;
//     fetchAndSetCandidates();
//   }

//   void setActiveDropdown(String? dropdown) {
//     setState(() {
//       activeDropdown = dropdown;
//     });
//   }

//   Future<void> fetchAndSetjobPositions() async {
//     try {
//       jobPositions = await fetchJobPositions();
//       setState(() {
//         jobPositionNames = jobPositions.map((dept) => dept.name).toList();
//         jobPositionNames.sort((a, b) => a.compareTo(b));
//       });
//     } catch (e) {
//       print('Error fetching job position: $e');
//     }
//   }

//   Future<void> fetchAndSetCandidates() async {
//     try {
//       candidates = await fetchCandidates();
//       setState(() {
//         candidateNames = candidates.map((cdd) => cdd.name).toList();
//         candidateNames.sort((a, b) => a.compareTo(b));
//       });
//     } catch (e) {
//       print('Error fetching candidates: $e');
//     }
//   }

//   void toggleCandidateApplication() {
//     if (showCandidateApplication) {
//       if(introRoleController.text.isEmpty) {
//         showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               title: const Text('Incomplete Form'),
//               content: const Text('Information is missing.'),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text('OK'),
//                 ),
//               ],
//             );
//           },
//         );
//       } else {
//         setState(() {
//           introRoleController.clear();
//         });
//       }
//     } else {
//       setState(() {
//         showCandidateApplication = true;
//       });
//     }
//   }
  
//   void clearCandidateApplication() {
//     setState(() {
//       showCandidateApplication = false;
//     });
//   }
  
//   List<CandidateData> get roleApplications {
//     if (showAllApplication) {
//       return candidates;
//     } else if (selectedRole != null) {
//       return candidates.where((app) => app.jobPositionId == selectedRole).toList();
//     } else {
//       return [];
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title:
//         CustomTitleAppbar(
//           ctx: context,
//           service: 'Recruitment',
//           titles: const ['Applications', 'Reporting'],
//           options: const [
//             ['By Job Positions', 'All Applications'],
//             ['Recruitment Analysis', 'Source Analysis', 'Time In Stage Analysis', 'Team Performance']
//           ],
//           optionNavigations: [
//             [
//               () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => RecruitmentManage())),
//               () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => ApplicationManage())),
//             ],
//             [
//               () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Contracts())),
//               () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Contracts())),
//               () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Contracts())),
//               () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Contracts())),
//             ],
//           ],
//           activeDropdowns: const ['Applications', 'Reporting'],
//           setActiveDropdown: (dropdown) {
//             setState(() {
//               activeDropdown = dropdown;
//             });
//           },
//         ),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(50),
//           child: Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     toggleCandidateApplication();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.white,
//                     backgroundColor: primaryColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                   ),
//                   child: const Text('New', style: TextStyle(color: Colors.white, fontSize: 16)),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: [
//                     Text(
//                       pageName,
//                       style: const TextStyle(fontSize: 16, color: Colors.white),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.upload),
//                       color: Colors.white,
//                       onPressed: () {},
//                       tooltip: "Import records",
//                     ),
//                     if (showCandidateApplication)
//                       IconButton(
//                         icon: const Icon(Icons.clear),
//                         color: Colors.white,
//                         iconSize: 24,
//                         tooltip: "Discard all changes",
//                         onPressed: () {
//                           clearCandidateApplication();
//                         },
//                     ),
//                   ],
//                 ),
//               ),
//               const Spacer(),
//               if (!showCandidateApplication)
//                 searchBoxWithFilterTable(context, 'Search...', filter(
//                   titles: const ['Filter', 'Group By', 'Favorites'],
//                   icons: const [Icons.filter_alt, Icons.groups, Icons.star_rounded],
//                   iconColors: const [primaryColor, Colors.greenAccent, Colors.yellow],
//                   options: const [
//                     ['My Team', 'My Department', 'Newly Hired', 'Achieved'],
//                     ['Manager', 'Department', 'Job', 'Skill', 'Start Date', 'Tags'],
//                     ['Save Current Search']
//                   ],
//                   navigators: [
//                     [
//                       () => Navigator.pushNamed(context, '/my_team'), 
//                       () => Navigator.pushNamed(context, '/my_department'), 
//                       () => Navigator.pushNamed(context, '/newly_hired'), 
//                       () => Navigator.pushNamed(context, '/achieved')],
//                     [
//                       () => Navigator.pushNamed(context, '/manager'), 
//                       () => Navigator.pushNamed(context, '/department'), 
//                       () => Navigator.pushNamed(context, '/job'), 
//                       () => Navigator.pushNamed(context, '/skill'), 
//                       () => Navigator.pushNamed(context, '/start_date'), 
//                       () => Navigator.pushNamed(context, '/tags')],
//                     [() => print('Save Current Search')],
//                   ],
//                 )
//               ),
//               const Spacer(),
//             ],
//           ),
//         ),
//         backgroundColor: snackBarColor,
//       ),
//       body: showCandidateApplication
//           ? showAllApplication ? CandidateApplication() : CandidateApplication(initialRole: selectedRole,)
//           : ProgressBoard(initialRole: selectedRole),
//           backgroundColor: snackBarColor,
//         );
//   }
// }