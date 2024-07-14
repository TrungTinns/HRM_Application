import 'package:flutter/material.dart';
import 'package:hrm_application/Component/Iconic/icon.dart';
import 'package:hrm_application/Component/button/button.dart';
import 'package:hrm_application/views/services/EmployeeManage/employee/employees.dart';
import 'package:hrm_application/views/services/PayrollManage/Dashboard/payroll_manage.dart';
import 'package:hrm_application/views/services/RecruitmentProcessManage/jobPosition/recruitment.dart';
import 'package:hrm_application/widgets/colors.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                authThemeColor,
              Colors.black,
              ],
            ),
          ),
          child: AppBar(
            title: appIcon(context),
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.wechat),
                color: textColor,
                iconSize: 30,
                onPressed: () {
                },
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                color: textColor,
                iconSize: 30,
                onPressed: () {
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              authThemeColor,
              Colors.black,
            ],
          ),
        ),
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount;
              if (constraints.maxWidth >= 1200) {
                // Desktop
                crossAxisCount = 6;
              } else if (constraints.maxWidth >= 800) {
                // Tablet
                crossAxisCount = 3;
              } else {
                // Mobile
                crossAxisCount = 2;
              }
              return SizedBox(
                width: crossAxisCount * 130.0,
                height: (6 / crossAxisCount).ceil() * 130.0,
                child: GridView.builder(
                  padding: const EdgeInsets.all(0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 30.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 1,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    final iconData = [
                      Icons.people_alt,
                      Icons.person_search,
                      Icons.monetization_on,
                      Icons.tips_and_updates,
                      Icons.timer_outlined,
                      Icons.analytics_outlined,
                    ][index];
                    final labels = [
                      'Employees',
                      'Recruitment',
                      'Payroll',
                      'Performance',
                      'Timesheets',
                      'Analytics',
                    ][index];
                    final pages = [
                      EmployeeManage(),
                      RecruitmentManage(),
                      PayrollManage(),
                      EmployeeManage(),
                      EmployeeManage(),
                      EmployeeManage(),
                    ][index];
                    return serviceButton(context, iconData, labels, pages);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
