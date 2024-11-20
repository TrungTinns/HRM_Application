import 'package:flutter/material.dart';
import 'package:hrm_application/core/utils/theme/colors.dart';
import 'package:hrm_application/presentation/views/services/employeeServices/contract/DataTable/contract_datatable.dart';
import 'package:hrm_application/presentation/views/services/employeeServices/Department/department.dart';
import 'package:hrm_application/presentation/views/services/employeeServices/Employee/employees.dart';
import 'package:hrm_application/presentation/views/services/employeeServices/OrgChart/orgchart.dart';
import 'package:hrm_application/presentation/widgets/appbar/custom_title_appbar.dart';
import 'package:hrm_application/presentation/widgets/filterSearch/filter_search.dart';
import 'package:hrm_application/presentation/widgets/search/searchBox.dart';
import 'package:pluto_grid/pluto_grid.dart';

class Contracts extends StatefulWidget {
  final String? name;
  final String? role;
  final String? department;
  final String? salaryStructureController;
  final String? contractTypeController;

  Contracts({
    this.name,
    this.role,
    this.department,
    this.salaryStructureController,
    this.contractTypeController,
  });
  @override
  _ContractsState createState() => _ContractsState();
}

class _ContractsState extends State<Contracts> {
  String pageName = 'Contracts';
  TextEditingController referenceController = TextEditingController();
  String? activeDropdown;
  bool showContractForm = false;
    List<PlutoRow> rows = [];

  void setActiveDropdown(String? dropdown) {
    setState(() {
      activeDropdown = dropdown;
    });
  }

  void toggleContractForm() {
    if (showContractForm) {
      if (referenceController.text.isEmpty) {
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
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        setState(() {
          referenceController.clear();
        });
      }
    } else {
      setState(() {
        showContractForm = true;
      });
    }
  }

  void clearContractForm() {
    setState(() {
      showContractForm = false;
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
          titles: const ['Employees', 'Department'],
          options: const [
            ['Employees', 'Contracts', 'Org Chart'],
            ['Department', 'Position']
          ],
          optionNavigations: [
            [
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => EmployeeManage())),
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Contracts())),
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => OrgChartManage())),
            ],
            [
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Department())),
              () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => EmployeeManage())),
              // () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => PositionManage())),
            ],
          ],
          activeDropdowns: const ['Employees', 'Reporting'],
          setActiveDropdown: (dropdown) {
            setState(() {
              activeDropdown = dropdown;
            });
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    toggleContractForm();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: textColor,
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
                    if (showContractForm)
                      IconButton(
                        icon: const Icon(Icons.clear),
                        color: Colors.white,
                        iconSize: 24,
                        tooltip: "Discard all changes",
                        onPressed: () {
                          clearContractForm();
                        },
                    ),
                  ],
                ),
              ),
              const Spacer(),
              if (!showContractForm)
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
                  ],)
                ),
              const Spacer(),
            ],
          ),
        ),
        backgroundColor: snackBarColor,
      ),
      body: 
      // widget.name != null
      //       // widget.role != null ||
      //       // widget.department != null ||
      //       // widget.contractTypeController != null ||
      //       // widget.salaryStructureController != null
      // ? ContractForm(
      //     name: widget.name,
      //     // role: widget.role,
      //     // department: widget.department,
      //     // contractTypeController: widget.contractTypeController,
      //     // salaryStructureController: widget.salaryStructureController
      //   )
      // : showContractForm
      //     ? ContractForm()
      //     : 
          ContractDataTable(),
    );
  }
}
