import 'package:flutter/material.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Contract/Data/contracts_data.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Department/Data/department_data.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Employee/Data/employees_data.dart';
import 'package:hrm_application/Views/Services/RecruitmentProcessManage/JobPosition/Data/jobposition_data.dart';
import 'package:hrm_application/widgets/colors.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContractDataTable extends StatefulWidget {
  @override
  _ContractDataTableState createState() => _ContractDataTableState();
}

class _ContractDataTableState extends State<ContractDataTable> {
  List<PlutoRow> rows = [];
  late Future<List<ContractData>> datas;

  @override
  void initState() {
    super.initState();
    datas = fetchContracts();
  }

  List<PlutoRow> loadContracts(List<ContractData> datas) {
    return datas.map((contract) {
      return PlutoRow(cells: {
        'Employee': PlutoCell(value: contract.empName),
        'Reference': PlutoCell(value: contract.reference),
        'Department': PlutoCell(value: contract.department),
        'Position': PlutoCell(value: contract.position),
        'Start Date': PlutoCell(value: contract.startDate.toString()),
        'End Date': PlutoCell(value: contract.endDate.toString()),
        'Salary Structure': PlutoCell(value: contract.salaryStructure),
        'Contract Type': PlutoCell(value: contract.contractType),
        'Schedule': PlutoCell(value: contract.schedule),
        'Status': PlutoCell(value: contract.status),
        'Salary': PlutoCell(value: contract.schedulePay),
        'Note': PlutoCell(value: contract.note),
        'Wage Type': PlutoCell(value: contract.wageType),
        'Schedule Pay': PlutoCell(value: contract.schedulePay),
      });
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<PlutoColumn> columns = [
      PlutoColumn(
        title: 'Employee',
        field: 'Employee',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Reference',
        field: 'Reference',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Department',
        field: 'Department',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Position',
        field: 'Position',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Start Date',
        field: 'Start Date',
        type: PlutoColumnType.date(),
      ),
      PlutoColumn(
        title: 'End Date',
        field: 'End Date',
        type: PlutoColumnType.date(),
      ),
      PlutoColumn(
        title: 'Salary Structure',
        field: 'Salary Structure',
        type: PlutoColumnType.select(ContractData.defaultSalaryStructures),
      ),
      PlutoColumn(
        title: 'Contract Type',
        field: 'Contract Type',
        type: PlutoColumnType.select(ContractData.defaultContractTypes),
      ),
      PlutoColumn(
        title: 'Schedule',
        field: 'Schedule',
        type: PlutoColumnType.select(ContractData.defaultSchedules),
      ),
      PlutoColumn(
        title: 'Status',
        field: 'Status',
        type: PlutoColumnType.select(ContractData.defaultStatus),
      ),
    ];


    return FutureBuilder<List<ContractData>>(
      future: datas,
      builder: (BuildContext context, AsyncSnapshot<List<ContractData>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          rows = loadContracts(snapshot.data!);
        }

        return PlutoGrid(
          columns: columns,
          rows: rows,
          onChanged: (PlutoGridOnChangedEvent event) {
          },
          configuration: const PlutoGridConfiguration(
            style: PlutoGridStyleConfig(
              gridBorderColor: textColor,
              menuBackgroundColor: snackBarColor,
              iconColor: textColor,
              cellColorInEditState: snackBarColor,
              gridBackgroundColor: snackBarColor,
              cellTextStyle: TextStyle(color: textColor),
              columnTextStyle: TextStyle(color: textColor),
              rowColor: dropdownColor,
              activatedColor: Color.fromRGBO(38, 42, 54, 1),
              activatedBorderColor: textColor,
            ),
          ),
        );
      },
    );
  }
}
