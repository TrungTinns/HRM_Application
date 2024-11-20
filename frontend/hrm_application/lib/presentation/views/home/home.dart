import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_application/core/utils/theme/colors.dart';
import 'package:hrm_application/presentation/controllers/auth/auth_controller.dart';
import 'package:hrm_application/presentation/views/services/employeeServices/Employee/employees.dart';
import 'package:hrm_application/presentation/views/services/recruitmentServices/job_position/recruitment.dart';
import 'package:hrm_application/presentation/widgets/button/button.dart';
import 'package:hrm_application/presentation/widgets/iconic/icon.dart';
import 'package:hrm_application/presentation/widgets/sidebar/sidebar.dart';

import 'package:sidebarx/sidebarx.dart';

class Home extends StatelessWidget {
  final _controller = SidebarXController(selectedIndex: 0, extended: true);

  @override
  Widget build(BuildContext context) {
    // Sử dụng AuthController để quản lý người dùng
    final authController = Get.find<AuthController>();
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: isSmallScreen
          ? AppBar(
              title: appIcon(),
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu, color: textColor),
              ),
            )
          : null,
      drawer: CustomSidebar(
        controller: _controller,
        onLogout: authController.signOut, // Sử dụng hàm signOut từ AuthController
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
        child: Row(
          children: [
            if (!isSmallScreen)
              CustomSidebar(
                controller: _controller,
                onLogout: authController.signOut,
              ),
            Expanded(
              child: Center(
                child: Obx(
                  () {
                    if (authController.isProcessing.value) {
                      // Hiển thị loading khi đang xử lý (ví dụ đăng xuất)
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (!isSmallScreen) appIcon(),
                        const Spacer(),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            int crossAxisCount;
                            if (constraints.maxWidth >= 1200) {
                              crossAxisCount = 4; // Desktop
                            } else if (constraints.maxWidth >= 800) {
                              crossAxisCount = 3; // Tablet
                            } else {
                              crossAxisCount = 2; // Mobile
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
                        const Spacer(),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
