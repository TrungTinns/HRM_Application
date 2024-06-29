import 'package:flutter/material.dart';
import 'package:hrm_application/components/appbar/custom_title_appbar.dart';
import 'package:hrm_application/components/configuration/configurtion.dart';
import 'package:hrm_application/components/filter_search/filter_search.dart';
import 'package:hrm_application/components/search/searchBox.dart';
import 'package:hrm_application/views/employee_inf_manage/contract/contracts.dart';
import 'package:hrm_application/views/home/home.dart';
import 'package:hrm_application/views/recruitment_process_manage/candidate_application/application/candidate_application.dart';
import 'package:hrm_application/views/recruitment_process_manage/candidate_application/card/candidate_card.dart';
import 'package:hrm_application/views/recruitment_process_manage/candidate_application/cadidate_inf.dart';
import 'package:hrm_application/views/recruitment_process_manage/jobPosition/jobposition_inf.dart';
import 'package:hrm_application/views/recruitment_process_manage/jobPosition/recruitment.dart';
import 'package:hrm_application/widgets/colors.dart';

class ApplicationManage extends StatefulWidget {
  @override
  _ApplicationManageState createState() => _ApplicationManageState();
}

class _ApplicationManageState extends State<ApplicationManage> {
  TextEditingController introRoleController = TextEditingController();
  String pageName = 'Applications';
  bool showCandidateApplication = false;
  String? activeDropdown;

  void setActiveDropdown(String? dropdown) {
    setState(() {
      activeDropdown = dropdown;
    });
  }

  void toggleCandidateApplication() {
    if (showCandidateApplication) {
      if(introRoleController.text.isEmpty) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Incomplete Form'),
              content: const Text('Information is missing.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        setState(() {
          introRoleController.clear();
        });
      }
    } else {
      setState(() {
        showCandidateApplication = true;
      });
    }
  }
  
  void clearCandidateApplication() {
    setState(() {
      showCandidateApplication = false;
    });
  }

  void deleteApplication(String role) {
    setState(() {
      candidates.removeWhere((jobPosition) => jobPosition.role == role);
    });
  }

  void handleUpdate(CandidateInf updatedApplication) {
    setState(() {
      final index =
          candidates.indexWhere((app) => app.role == updatedApplication.role);
      if (index != -1) {
        candidates[index] = updatedApplication;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: 
        CustomTitleAppbar(
          ctx: context,
          service: 'Recruitment',
          titles: const ['Applications', 'Reporting'],
          options: const [
            ['By Job Positions', 'All Applications'],
            ['Recruitment Analysis', 'Source Analysis', 'Time In Stage  Analysis', 'Team Performance']
          ],
          optionNavigations: [
            [
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => RecruitmentManage())),
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
            ],
            [
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Contracts())),
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Contracts())),
            ],
          ],
          activeDropdowns: const ['Applications', 'Reporting'],
          setActiveDropdown: (dropdown) {
            setState(() {
              activeDropdown = dropdown;
            });
          }, 
          config: configuration(
            isActive: activeDropdown == 'Configuration',
            onOpen: () => setActiveDropdown('Configuration'),
            onClose: () => setActiveDropdown(null),
            titles: const ['', 'Job Positons', 'Applications', 'Employees', 'Activities'],
            options: const [
              ['Setting'],
              ['Employment Types'],
              ['Refuse Reasons'],
              ['Departments', 'Skill Types'],
              ['Activities Types', 'Activity Plans'],
            ],
            navigators: [
              [
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
              ],
              [
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
              ],
              [
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
              ],
              [
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
              ],
              [
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
              ],
            ],
          )
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    toggleCandidateApplication();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, 
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5), 
                    ),
                  ),
                  child: const Text('New', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      pageName,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    IconButton(
                      icon: const Icon(Icons.upload),
                      color: Colors.white,
                      onPressed: () {},
                      tooltip: "Import records",
                    ),
                    if (showCandidateApplication)
                      IconButton(
                        icon: const Icon(Icons.clear),
                        color: Colors.white,
                        iconSize: 24,
                        tooltip: "Discard all changes",
                        onPressed: () {
                          clearCandidateApplication();
                        },
                    ),
                  ],
                ),
              ),
              const Spacer(),
              if (!showCandidateApplication)
                searchBoxWithFilterTable(context, 'Search...', filter(
                  titles: const ['Filter', 'Group By', 'Favorites'],
                  icons: const [Icons.filter_alt, Icons.groups, Icons.star_rounded],
                  iconColors: const [primaryColor, Colors.greenAccent, Colors.yellow],
                  options: const [
                    ['My Team', 'My Department', 'Newly Hired', 'Achieved'],
                    ['Manager', 'Department', 'Job', 'Skill', 'Start Date', 'Tags'],
                    ['Save Current Search']
                  ],
                  navigators: [
                    [
                      () => Navigator.pushNamed(context, '/my_team'), 
                      () => Navigator.pushNamed(context, '/my_department'), 
                      () => Navigator.pushNamed(context, '/newly_hired'), 
                      () => Navigator.pushNamed(context, '/achieved')],
                    [
                      () => Navigator.pushNamed(context, '/manager'), 
                      () => Navigator.pushNamed(context, '/department'), 
                      () => Navigator.pushNamed(context, '/job'), 
                      () => Navigator.pushNamed(context, '/skill'), 
                      () => Navigator.pushNamed(context, '/start_date'), 
                      () => Navigator.pushNamed(context, '/tags')],
                    [() => print('Save Current Search')],
                  ],
                )
              ),
              const Spacer(),
            ],
          ),
        ),
        backgroundColor: snackBarColor,
      ),
      body: showCandidateApplication
          ? CandidateApplication()
          : Expanded(
            child: LayoutBuilder(
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
                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2.5,
                  ),
                  itemCount: candidates.length,
                  itemBuilder: (context, index) {
                    final application = candidates[index];
                    return ApplicationCard(
                          introRole: application.introRole,
                          role: application.role,
                          department: application.department,
                          name: application.name,
                          mail: application.mail,
                          mobile: application.mobile,
                          profile: application.profile,
                          degree: application.degree,
                          interviewer: application.interviewer,
                          recruiter: application.recruiter,
                          elevation: application.elevation,
                          availability: application.availability,
                          expectedSalary: application.expectedSalary,
                          proposedSalary: application.proposedSalary,
                          summary: application.summary,
                          onDelete: () => deleteApplication(application.role),
                      onUpdate: handleUpdate, 
                    );
                  },
                );
              },
            ),
          ),
        );
  }
}

