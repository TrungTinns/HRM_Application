import 'package:flutter/material.dart';
import 'package:hrm_application/Component/Appbar/custom_title_appbar.dart';
import 'package:hrm_application/Component/Configuration/configuration.dart';
import 'package:hrm_application/Views/Services/PayrollManage/Payslip/payslips.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Contract/contracts.dart';
import 'package:hrm_application/Views/Services/PayrollManage/Batch/batch.dart';
import 'package:hrm_application/Views/home/home.dart';
import 'package:hrm_application/widgets/colors.dart';


class PayrollManage extends StatefulWidget {
  @override
  _PayrollManageState createState() => _PayrollManageState();
}

class _PayrollManageState extends State<PayrollManage> {
  TextEditingController roleController = TextEditingController();
  String pageName = '';
  bool showJobPositionForm = false;
  bool showAllJobPositions = true;
  String? activeDropdown;
  String? selectedDepartment;

  @override
  void initState() {
    super.initState();
  }

  void setActiveDropdown(String? dropdown) {
    setState(() {
      activeDropdown = dropdown;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomTitleAppbar(
          ctx: context,
          service: 'Payroll',
          titles: const ['Dashboard', 'Contracts', 'Work Entries', 'Payslips', 'Reporting'],
          options: const [
            [],
            ['Contracts', 'Salary Attachments'],
            ['Work Entries', 'Time Off'],
            ['All Payslips', 'Batches'],
            ['By Job Positions', 'All Applications'],
            ['Recruitment Analysis', 'Source Analysis', 'Time In Stage Analysis', 'Team Performance']
          ],
          optionNavigations: [
            [  
            ],
            [
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Contracts
                  ())),
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Home())),
            ],
            [
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Home())),
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Home())),
            ],
            [
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => PayslipManage())),
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => BatchManage())),
            ],
            [
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => PayrollManage())),
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Home())),
            ],
            [
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Home())),
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Home())),
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Home())),
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Home())),
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
            titles: const ['', 'Job Positions', 'Applications', 'Employees', 'Activities'],
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
          ),
        ),
        backgroundColor: snackBarColor,
      ),
      body:
      Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.blueGrey[100],
              child: Center(child: Text('Large View on the Left')),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.grey[200],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.grey[300],
                    child: Center(child: Text('Bottom Right View')),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
