import 'package:flutter/material.dart';
import 'package:hrm_application/views/employee_inf_manage/contract/contracts_inf.dart';
import 'package:hrm_application/widgets/colors.dart';
import 'package:pluto_grid/pluto_grid.dart';

class ContractDataTable extends StatelessWidget {
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
        type: PlutoColumnType.select(['Administration', 'Research & Development', 'Quality', 'Human Resources', 'Sales', 'Accounting', 'Financial']),
      ),
      PlutoColumn(
        title: 'Position',
        field: 'Position',
        type: PlutoColumnType.select(['Director', 'CEO', 'Project Manager', 'Dev', 'Tester', 'Quality Assurance', 'HR', 'Content Creator', 'Accountant', 'Business Analysis', 'Designer', 'Actuary', 'Secretary', 'Sales', 'Database Administrator', 'Collaborator']),
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
        title: 'Contract Type',
        field: 'Contract Type',
        type: PlutoColumnType.select(['Permanent', 'Temporary', 'Seasonal', 'Full-time', 'Part-time']),
      ),
      PlutoColumn(
        title: 'Schedule',
        field: 'Schedule',
        type: PlutoColumnType.select(['Full-time', 'Part-time']),
      ),
      PlutoColumn(
        title: 'Status',
        field: 'Status',
        type: PlutoColumnType.select(['Running', 'Expired', 'Cancelled']),
      ),
    ];

    List<PlutoRow> rows = getContracts().map((contract) {
      return PlutoRow(cells: {
        'Employee': PlutoCell(value: contract['Employee']),
        'Reference': PlutoCell(value: contract['Reference']),
        'Department': PlutoCell(value: contract['Department']),
        'Position': PlutoCell(value: contract['Position']),
        'Start Date': PlutoCell(value: contract['Start Date']),
        'End Date': PlutoCell(value: contract['End Date']),
        'Contract Type': PlutoCell(value: contract['Contract Type']),
        'Schedule': PlutoCell(value: contract['Schedule']),
        'Status': PlutoCell(value: contract['Status']),
      });
    }).toList();

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
  }
}