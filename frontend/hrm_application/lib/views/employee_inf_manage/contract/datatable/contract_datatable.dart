import 'package:flutter/material.dart';
import 'package:hrm_application/views/employee_inf_manage/contract/contracts_inf.dart';
import 'package:hrm_application/views/employee_inf_manage/contract/detail/contract_detail.dart';
import 'package:hrm_application/widgets/colors.dart';
import 'package:pluto_grid/pluto_grid.dart';

class ContractDataTable extends StatefulWidget {
  @override
  _ContractDataTableState createState() => _ContractDataTableState();
}

class _ContractDataTableState extends State<ContractDataTable> {
  final List<String> departments = ['Administration', 'Research & Development', 'Quality', 'Human Resources', 'Sales', 'Accounting', 'Financial'];
  final List<String> roles = ['Director', 'CEO', 'Project Manager', 'Dev', 'Tester', 'Quality Assurance', 'HR', 'Content Creator', 'Accountant', 'Business Analysis', 'Designer', 'Actuary', 'Secretary', 'Sales', 'Database Administrator', 'Collaborator'];
  final List<String> schedules = ['Standard 40 hours/week', 'Part-time 25 hours/week'];
  final List<String> salaryStructures = ['Employee', 'Worker'];
  final List<String> contractTypes = ['Permanent', 'Temporary', 'Seasonal', 'Full-time', 'Part-time'];
  final List<String> status = ['Running', 'Expired', 'Cancelled'];

  List<PlutoRow> rows = [];

  @override
  void initState() {
    super.initState();
    rows = getContracts().map((contract) {
      return PlutoRow(cells: {
        'Employee': PlutoCell(value: contract['Employee']),
        'Reference': PlutoCell(value: contract['Reference']),
        'Department': PlutoCell(value: contract['Department']),
        'Position': PlutoCell(value: contract['Position']),
        'Start Date': PlutoCell(value: contract['Start Date']),
        'End Date': PlutoCell(value: contract['End Date']),
        'Salary Structure': PlutoCell(value: contract['Salary Structure']),
        'Contract Type': PlutoCell(value: contract['Contract Type']),
        'Schedule': PlutoCell(value: contract['Schedule']),
        'Status': PlutoCell(value: contract['Status']),
      });
    }).toList();
  }

  void deleteRow(int index) {
  setState(() {
    rows.removeAt(index);
    contracts.removeAt(index); 
  });
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
        type: PlutoColumnType.select(departments),
      ),
      PlutoColumn(
        title: 'Position',
        field: 'Position',
        type: PlutoColumnType.select(roles),
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
        type: PlutoColumnType.select(salaryStructures),
      ),
      PlutoColumn(
        title: 'Contract Type',
        field: 'Contract Type',
        type: PlutoColumnType.select(contractTypes),
      ),
      PlutoColumn(
        title: 'Schedule',
        field: 'Schedule',
        type: PlutoColumnType.select(schedules),
      ),
      PlutoColumn(
        title: 'Status',
        field: 'Status',
        type: PlutoColumnType.select(status),
      ),
    ];

    return PlutoGrid(
      columns: columns,
      rows: rows,
      onChanged: (PlutoGridOnChangedEvent event) {

      },
      onRowDoubleTap: (event) {
        final row = event.row;
    // Lưu index của row
        final index = rows.indexOf(row);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => ContractDetail(
              employeeName: row.cells['Employee']!.value,
              reference: row.cells['Reference']!.value,
              department: row.cells['Department']!.value,
              position: row.cells['Position']!.value,
              startDate: row.cells['Start Date']!.value,
              endDate: row.cells['End Date']!.value,
              salaryStructure: row.cells['Salary Structure']!.value,
              contractType: row.cells['Contract Type']!.value,
              schedule: row.cells['Schedule']!.value,
              status: row.cells['Status']!.value,
              onDelete: () {
                deleteRow(index);
              },
            ),
          ),
        );
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
  }
}