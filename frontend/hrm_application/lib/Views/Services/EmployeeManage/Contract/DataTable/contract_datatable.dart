import 'package:flutter/material.dart';
import 'package:hrm_application/views/services/EmployeeManage/contract/contracts_inf.dart';
import 'package:hrm_application/views/services/EmployeeManage/contract/detail/contract_detail.dart';
import 'package:hrm_application/views/services/EmployeeManage/department/department_inf.dart';
import 'package:hrm_application/views/services/EmployeeManage/employee/employees_inf.dart';
import 'package:hrm_application/views/services/RecruitmentProcessManage/jobPosition/jobposition_inf.dart';
import 'package:hrm_application/widgets/colors.dart';
import 'package:pluto_grid/pluto_grid.dart';

class ContractDataTable extends StatefulWidget {
  @override
  _ContractDataTableState createState() => _ContractDataTableState();
}

class _ContractDataTableState extends State<ContractDataTable> {

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
        'Start Date': PlutoCell(value: contract['Start Date'].toString()), 
        'End Date': PlutoCell(value: contract['End Date'].toString()),   
        'Salary Structure': PlutoCell(value: contract['Salary Structure']),
        'Contract Type': PlutoCell(value: contract['Contract Type']),
        'Schedule': PlutoCell(value: contract['Schedule']),
        'Status': PlutoCell(value: contract['Status']),
        'Salary': PlutoCell(value: contract['Salary']),
        'Wage Type': PlutoCell(value: contract['Wage Type']),
        'Schedule Pay': PlutoCell(value: contract['Schedule Pay']),
        'Note': PlutoCell(value: contract['Note']),
      });
    }).toList();
  }

  void deleteRow(int index) {
    setState(() {
      rows.removeAt(index);
      contracts.removeAt(index); 
    });
  }

  void updateContract(int index, ContractData updatedContract) {
    setState(() {
      rows[index] = PlutoRow(cells: {
        'Employee': PlutoCell(value: updatedContract.name),
        'Reference': PlutoCell(value: updatedContract.reference),
        'Department': PlutoCell(value: updatedContract.department),
        'Position': PlutoCell(value: updatedContract.position),
        'Start Date': PlutoCell(value: updatedContract.startDate.toString()), 
        'End Date': PlutoCell(value: updatedContract.endDate.toString()),    
        'Salary Structure': PlutoCell(value: updatedContract.salaryStructure),
        'Contract Type': PlutoCell(value: updatedContract.contractType),
        'Schedule': PlutoCell(value: updatedContract.schedule),
        'Status': PlutoCell(value: updatedContract.status),
        'Salary': PlutoCell(value: updatedContract.salary),
        'Wage Type': PlutoCell(value: updatedContract.wageType),
        'Schedule Pay': PlutoCell(value: updatedContract.schedulePay),
        'Note': PlutoCell(value: updatedContract.note),
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<PlutoColumn> columns = [
      PlutoColumn(
        title: 'Employee',
        field: 'Employee',
        type: PlutoColumnType.select(getNameEmp(employees)),
      ),
      PlutoColumn(
        title: 'Reference',
        field: 'Reference',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Department',
        field: 'Department',
        type: PlutoColumnType.select(getDepartments()),
      ),
      PlutoColumn(
        title: 'Position',
        field: 'Position',
        type: PlutoColumnType.select(getJobPositions(jobPositions)),
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

    return PlutoGrid(
      columns: columns,
      rows: rows,
      onChanged: (PlutoGridOnChangedEvent event) {

      },
      onRowDoubleTap: (event) {
        final row = event.row;
        final index = rows.indexOf(row);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => ContractDetail(
              name: row.cells['Employee']!.value,
              reference: row.cells['Reference']!.value,
              department: row.cells['Department']!.value,
              position: row.cells['Position']!.value,
              startDate: row.cells['Start Date']!.value,
              endDate: row.cells['End Date']!.value,
              salaryStructure: row.cells['Salary Structure']!.value,
              contractType: row.cells['Contract Type']!.value,
              schedule: row.cells['Schedule']!.value,
              status: row.cells['Status']!.value,
              wageType: row.cells['Wage Type']!.value,
              schedulePay: row.cells['Schedule Pay']!.value,
              onDelete: () {
                deleteRow(index);
              }, 
              onUpdate: (updatedContract) {
                final updatedContractMap = updatedContract.toMap();
                final updatedContractData = ContractData.fromMap(updatedContractMap);
                updateContract(index, updatedContractData);
              },
              salary: row.cells['Salary']!.value,
              note: row.cells['Note']!.value,
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