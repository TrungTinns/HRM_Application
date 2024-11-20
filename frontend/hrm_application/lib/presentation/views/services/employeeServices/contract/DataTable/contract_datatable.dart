import 'package:flutter/material.dart';
import 'package:hrm_application/core/utils/theme/colors.dart';
import 'package:hrm_application/presentation/views/services/employeeServices/contract/Data/contracts_data.dart';
import 'package:hrm_application/presentation/views/services/employeeServices/Department/Data/department_data.dart';
import 'package:hrm_application/presentation/views/services/employeeServices/Employee/Data/employees_data.dart';
import 'package:hrm_application/presentation/views/services/recruitmentServices/job_position/Data/jobposition_data.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContractDataTable extends StatefulWidget {
  @override
  _ContractDataTableState createState() => _ContractDataTableState();
}

class _ContractDataTableState extends State<ContractDataTable> {
  List<DepartmentData> departments = [];
  List<String> departmentNames = [];
  List<JobPositionData> jobPositions = [];
  List<String> roleNames = [];
  List<PlutoRow> rows = [];
  List<String> employees = [];

  @override
  void initState() {
    super.initState();
    // rows = getContracts().map((contract) {
    //   return PlutoRow(cells: {
    //     'Employee': PlutoCell(value: contract['Employee']),
    //     'Reference': PlutoCell(value: contract['Reference']),
    //     'Department': PlutoCell(value: contract['Department']),
    //     'Position': PlutoCell(value: contract['Position']),
    //     'Start Date': PlutoCell(value: contract['Start Date'].toString()),
    //     'End Date': PlutoCell(value: contract['End Date'].toString()),
    //     'Salary Structure': PlutoCell(value: contract['Salary Structure']),
    //     'Contract Type': PlutoCell(value: contract['Contract Type']),
    //     'Schedule': PlutoCell(value: contract['Schedule']),
    //     'Status': PlutoCell(value: contract['Status']),
    //     'Salary': PlutoCell(value: contract['Salary']),
    //     'Note': PlutoCell(value: contract['Note']),
    //     'Wage Type': PlutoCell(value: contract['Wage Type']),
    //     'Schedule Pay': PlutoCell(value: contract['Schedule Pay']),
    //   });
    // }).toList();
    fetchAndSetDepartments();
    fetchEmps();
    fetchAndSetjobPositions();
  }

  Future<void> fetchEmps() async {
    try {
      List<EmployeeData> employeesData = await fetchEmployees();
      setState(() {
        employees = employeesData.map((employee) => employee.name).toList();
      });
    } catch (e) {
      print('Error fetching employees: $e');
    }
  }

  List<String> getEmployees() {
    return employees;
  }
  
  Future<void> fetchAndSetDepartments() async {
    try {
      departments = await fetchDepartments();
      setState(() {
        departmentNames = departments.map((dept) => dept.department).toList();
        departmentNames.sort((a, b) => a.compareTo(b));
      });
    } catch (e) {
      print('Error fetching departments: $e');
    }
  }

  Future<void> fetchAndSetjobPositions() async {
    try {
      jobPositions = await fetchJobPositions();
      setState(() {
        roleNames = jobPositions.map((dept) => dept.name).toList();
        roleNames.sort((a, b) => a.compareTo(b));
      });
    } catch (e) {
      print('Error fetching departments: $e');
    }
  }

  // void deleteRow(int index) {
  //   setState(() {
  //     rows.removeAt(index);
  //     contracts.removeAt(index);
  //   });
  // }

  void updateContract(int index, ContractData updatedContract) {
    setState(() {
      rows[index] = PlutoRow(cells: {
        'Employee': PlutoCell(value: updatedContract.empName),
        'Reference': PlutoCell(value: updatedContract.reference),
        'Department': PlutoCell(value: updatedContract.department),
        'Position': PlutoCell(value: updatedContract.position),
        'Start Date': PlutoCell(value: updatedContract.startDate.toString()),
        'End Date': PlutoCell(value: updatedContract.endDate.toString()),
        'Salary Structure': PlutoCell(value: updatedContract.salaryStructure),
        'Contract Type': PlutoCell(value: updatedContract.contractType),
        'Schedule': PlutoCell(value: updatedContract.schedule),
        'Status': PlutoCell(value: updatedContract.status),
        'Salary': PlutoCell(value: updatedContract.cost),
        'Note': PlutoCell(value: updatedContract.note),
        'Wage Type': PlutoCell(value: updatedContract.wageType),
        'Schedule Pay': PlutoCell(value: updatedContract.schedulePay),
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<PlutoColumn> columns = [
      PlutoColumn(
        title: 'Employee',
        field: 'Employee',
        type: PlutoColumnType.select(employees),
      ),
      PlutoColumn(
        title: 'Reference',
        field: 'Reference',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Department',
        field: 'Department',
        type: PlutoColumnType.select(departmentNames),
      ),
      PlutoColumn(
        title: 'Position',
        field: 'Position',
        type: PlutoColumnType.select(roleNames),
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
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (ctx) => ContractDetail(
        //       name: row.cells['Employee']!.value,
        //       reference: row.cells['Reference']!.value,
        //       department: row.cells['Department']!.value,
        //       position: row.cells['Position']!.value,
        //       startDate: row.cells['Start Date']!.value,
        //       endDate: row.cells['End Date']!.value,
        //       salaryStructure: row.cells['Salary Structure']!.value,
        //       contractType: row.cells['Contract Type']!.value,
        //       schedule: row.cells['Schedule']!.value,
        //       status: row.cells['Status']!.value,
        //       wageType: row.cells['Wage Type']!.value,
        //       schedulePay: row.cells['Schedule Pay']!.value,
        //       onDelete: () {
        //         deleteRow(index);
        //       }, 
        //       onUpdate: (updatedContract) {
        //         final updatedContractMap = updatedContract.toMap();
        //         final updatedContractData = ContractData.fromMap(updatedContractMap);
        //         updateContract(index, updatedContractData);
        //       },
        //       salary: row.cells['Salary']!.value,
        //       note: row.cells['Note']!.value,
        //     ),
        //   ),
        // );
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