import 'package:flutter/material.dart';
import 'package:hrm_application/Views/Services/PayrollManage/Dashboard/payroll_manage.dart';
import 'package:hrm_application/Views/Services/TimesheetManage/timesheet.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: SignIn(),
      home: TimeSheet(),
    );
  }
}