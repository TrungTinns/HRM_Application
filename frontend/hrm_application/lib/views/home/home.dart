import 'package:flutter/material.dart';
import 'package:hrm_application/Component/Iconic/icon.dart';
import 'package:hrm_application/Component/Sidebar/sidebar.dart';
import 'package:hrm_application/Component/button/button.dart';
import 'package:hrm_application/Config/Services/Firebase/Auth/auth.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Employee/employees.dart';
import 'package:hrm_application/Views/Services/RecruitmentProcessManage/JobPosition/recruitment.dart';
import 'package:hrm_application/Views/login/login.dart';
import 'package:hrm_application/widgets/colors.dart';
import 'package:sidebarx/sidebarx.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();
  bool isProcessing = false;

  void _signOut() async {
    setState(() {
      isProcessing = true;
    });
    await signOut().then((result) => print(result));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const AuthScreen(), fullscreenDialog: true));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
      ),
      home: Builder(builder: (context) {
        final isSmallScreen = MediaQuery.of(context).size.width < 600;
        return Container(
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
          child: Scaffold(
            key: _key,
            appBar: isSmallScreen
                ? AppBar(
                    title: appIcon(),
                    backgroundColor: Colors.transparent,
                    automaticallyImplyLeading: false,
                    centerTitle: true,
                    leading: IconButton(
                      onPressed: () {
                        // if (!Platform.isAndroid && !Platform.isIOS) {
                        //   _controller.setExtended(true);
                        // }
                        _key.currentState?.openDrawer();
                      },
                      icon: const Icon(Icons.menu, color: textColor),
                    ),
                  )
                : null,
            drawer: CustomSidebar(controller: _controller, onLogout: _signOut),
            body: Row(
              children: [
                if (!isSmallScreen)
                  CustomSidebar(controller: _controller, onLogout: _signOut),
                Expanded(
                  child: Center(
                    child: AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (!isSmallScreen) appIcon(),
                              Spacer(),
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  int crossAxisCount;
                                  if (constraints.maxWidth >= 1200) {
                                    // Desktop
                                    crossAxisCount = 4;
                                  } else if (constraints.maxWidth >= 800) {
                                    // Tablet
                                    crossAxisCount = 3;
                                  } else {
                                    // Mobile
                                    crossAxisCount = 2;
                                  }
                                  return SizedBox(
                                    width: crossAxisCount * 130.0,
                                    height: (4 / crossAxisCount).ceil() * 130.0,
                                    child: GridView.builder(
                                      padding: const EdgeInsets.all(0),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: crossAxisCount,
                                        crossAxisSpacing: 30.0,
                                        mainAxisSpacing: 8.0,
                                        childAspectRatio: 1,
                                      ),
                                      itemCount: 4,
                                      itemBuilder: (context, index) {
                                        final iconData = [
                                          Icons.people_alt,
                                          Icons.person_search,
                                          Icons.monetization_on,
                                          Icons.timer_outlined,
                                        ][index];
                                        final labels = [
                                          'Employees',
                                          'Recruitment',
                                          'Payroll',
                                          'Timesheets',
                                        ][index];
                                        final pages = [
                                          EmployeeManage(),
                                          RecruitmentManage(),
                                          EmployeeManage(),
                                          RecruitmentManage(),
                                          // PayrollManage(),
                                          // TimeSheet()
                                        ][index];
                                        return serviceButton(
                                            context, iconData, labels, pages);
                                      },
                                    ),
                                  );
                                },
                              ),
                              Spacer()
                            ],
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
