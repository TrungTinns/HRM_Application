import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrm_application/components/employee/appbar/custom_title_appbar.dart';
import 'package:hrm_application/components/employee/configuration/emp_configurtion.dart';
import 'package:hrm_application/components/employee/detail/employee_card.dart';
import 'package:hrm_application/components/employee/filter_search/contracts_filter.dart';
import 'package:hrm_application/views/create/contracts/contract_form.dart';
import 'package:hrm_application/views/employee_inf_manage/employees.dart';
import 'package:hrm_application/views/employee_inf_manage/org_chart.dart';
import 'package:hrm_application/views/home/home.dart';
import 'package:hrm_application/widgets/colors.dart';
import 'package:hrm_application/widgets/widget.dart';

class Contracts extends StatefulWidget {
  @override
  _ContractsState createState() => _ContractsState();
}

class _ContractsState extends State<Contracts> {
  String pageName = 'Contracts';
  bool _isHovered = false;
  bool _isSidebarOpen = true;

  String? activeDropdown;
  bool showContractForm = false;

  void setActiveDropdown(String? dropdown) {
    setState(() {
      activeDropdown = dropdown;
    });
  }

  void toggleContractForm() {
    setState(() {
      showContractForm = !showContractForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomTitleAppbar(
          ctx: context,
          service: 'Employees',
          titles: ['Employees', 'Reporting'],
          options: [
            ['Employees', 'Department', 'Org chart', 'Contracts'],
            ['Contracts', 'Skills']
          ],
          optionNavigations: [
            [
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => EmployeeManage())),
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => OrgChart())),
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Contracts())),
            ],
            [
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
            ],
          ],
          activeDropdowns: ['Employees', 'Reporting'],
          setActiveDropdown: (dropdown) {            
          }, 
          config: empConfiguration(
            isActive: activeDropdown == 'Configuration',
            onOpen: () => setActiveDropdown('Configuration'),
            onClose: () => setActiveDropdown(null),
            titles: ['Setting', 'Employee', 'Recruitment'],
            options: [
              ['Setting', 'Activity Plan'],
              ['Departments', 'Work Locations', 'Working Schedules', 'Departure Reasons', 'Skill Types'],
              ['Job Positions', 'Employment Types']
            ],
            navigators: [
              [
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
              ],
              [
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
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
          preferredSize: Size.fromHeight(50),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    toggleContractForm();
                  },
                  child: Text('New', style: TextStyle(color: Colors.white, fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, 
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5), 
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      pageName,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Spacer(),
              searchBoxWithFilterTable(context, 'Search...', filterContracts()),
              Spacer(),
            ],
          ),
        ),
        backgroundColor: snackBarColor,
      ),
      body: Row(
        children: [    
          Expanded(
            child: IndexedStack(
              index: showContractForm ? 1 : 0,
              children: [
                GridView.builder(
                  padding: EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, 
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 10, 
                  itemBuilder: (context, index) {
                    return EmployeeCard(
                      name: 'Employee ${index + 1}',
                      role: 'Role ${index + 1}',
                      email: 'email${index + 1}@example.com',
                    );
                  },
                ),
                ContractForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
