// import 'package:flutter/material.dart';
// import 'package:hrm_application/Component/Appbar/custom_title_appbar.dart';
// import 'package:hrm_application/Component/Configuration/configuration.dart';
// import 'package:hrm_application/Component/FilterSearch/filter_search.dart';
// import 'package:hrm_application/Component/Search/searchBox.dart';
// import 'package:hrm_application/Views/Services/EmployeeManage/Contract/contracts.dart';
// import 'package:hrm_application/Views/Services/PayrollManage/Batch/batch.dart';
// import 'package:hrm_application/Views/Services/PayrollManage/Payslip/DataTable/payslip_datatable.dart';
// import 'package:hrm_application/Views/Services/PayrollManage/Payslip/Form/payslip_form.dart';
// import 'package:hrm_application/views/home/home.dart';
// import 'package:hrm_application/views/services/PayrollManage/Dashboard/payroll_manage.dart';
// import 'package:hrm_application/widgets/colors.dart';
// import 'package:pluto_grid/pluto_grid.dart';

// class PayslipManage extends StatefulWidget {
//   @override
//   _PayslipManageState createState() => _PayslipManageState();
// }

// class _PayslipManageState extends State<PayslipManage> {
//   TextEditingController nameController= TextEditingController();
//   String pageName = 'Employee Payslips';
//   bool showPayslipForm = false;
//   String? activeDropdown;
//   List<PlutoRow> rows = [];

//   void setActiveDropdown(String? dropdown) {
//     setState(() {
//       activeDropdown = dropdown;
//     });
//   }

//   void togglePayslipForm() {
//     if (showPayslipForm) {
//       if (nameController.text.isEmpty) {
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
//                   child: const Text('OK'),
//                 ),
//               ],
//             );
//           },
//         );
//       } else {
//         setState(() {
//           nameController.clear();
//         });
//       }
//     } else {
//       setState(() {
//         showPayslipForm = true;
//       });
//     }
//   }

//   void clearPayslipForm() {
//     setState(() {
//       showPayslipForm = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: CustomTitleAppbar(
//           ctx: context,
//           service: 'Payroll',
//           titles: const ['Dashboard', 'Contracts', 'Work Entries', 'Payslips', 'Reporting'],
//           options: const [
//             [],
//             ['Contracts', 'Salary Attachments'],
//             ['Work Entries', 'Time Off'],
//             ['All Payslips', 'Batches'],
//             ['By Job Positions', 'All Applications'],
//             ['Recruitment Analysis', 'Source Analysis', 'Time In Stage Analysis', 'Team Performance']
//           ],
//           optionNavigations: [
//             [ () => Navigator.push(
//                   context, MaterialPageRoute(builder: (ctx) => PayrollManage())),
//             ],
//             [
//               () => Navigator.push(
//                   context, MaterialPageRoute(builder: (ctx) => Contracts())),
//               () => Navigator.push(
//                   context, MaterialPageRoute(builder: (ctx) => Home())),
//             ],
//             [
//               () => Navigator.push(
//                   context, MaterialPageRoute(builder: (ctx) => Home())),
//               () => Navigator.push(
//                   context, MaterialPageRoute(builder: (ctx) => Home())),
//             ],
//             [
//               () => Navigator.push(
//                   context, MaterialPageRoute(builder: (ctx) => PayslipManage())),
//               () => Navigator.push(
//                   context, MaterialPageRoute(builder: (ctx) => BatchManage())),
//             ],
//             [
//               () => Navigator.push(
//                   context, MaterialPageRoute(builder: (ctx) => Home())),
//               () => Navigator.push(
//                   context, MaterialPageRoute(builder: (ctx) => Home())),
//             ],
//             [
//               () => Navigator.push(
//                   context, MaterialPageRoute(builder: (ctx) => Home())),
//               () => Navigator.push(
//                   context, MaterialPageRoute(builder: (ctx) => Home())),
//               () => Navigator.push(
//                   context, MaterialPageRoute(builder: (ctx) => Home())),
//               () => Navigator.push(
//                   context, MaterialPageRoute(builder: (ctx) => Home())),
//             ],
//           ],
//           activeDropdowns: const ['Applications', 'Reporting'],
//           setActiveDropdown: (dropdown) {
//             setState(() {
//               activeDropdown = dropdown;
//             });
//           },
//           config: configuration(
//             isActive: activeDropdown == 'Configuration',
//             onOpen: () => setActiveDropdown('Configuration'),
//             onClose: () => setActiveDropdown(null),
//             titles: const ['', 'Job Positions', 'Applications', 'Employees', 'Activities'],
//             options: const [
//               ['Setting'],
//               ['Employment Types'],
//               ['Refuse Reasons'],
//               ['Departments', 'Skill Types'],
//               ['Activities Types', 'Activity Plans'],
//             ],
//             navigators: [
//               [
//                 () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
//               ],
//               [
//                 () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
//               ],
//               [
//                 () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
//               ],
//               [
//                 () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
//                 () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
//               ],
//               [
//                 () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
//                 () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
//               ],
//             ],
//           ),
//         ),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(50),
//           child: Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     togglePayslipForm();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: textColor,
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
//                     if (showPayslipForm)
//                       IconButton(
//                         icon: const Icon(Icons.clear),
//                         color: Colors.white,
//                         iconSize: 24,
//                         tooltip: "Discard all changes",
//                         onPressed: () {
//                           clearPayslipForm();
//                         },
//                     ),
//                   ],
//                 ),
//               ),
//               const Spacer(),
//               if (!showPayslipForm)
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
//                   ],)
//                 ),
//               const Spacer(),
//             ],
//           ),
//         ),
//         backgroundColor: snackBarColor,
//       ),
//       body: showPayslipForm
//           ? PayslipForm()
//           : PayslipDataTable(),
//     );
//   }
// }

