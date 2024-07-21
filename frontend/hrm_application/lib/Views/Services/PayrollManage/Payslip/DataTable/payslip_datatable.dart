import 'package:flutter/material.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Employee/employees_inf.dart';
import 'package:hrm_application/Views/Services/PayrollManage/Batch/batches_inf.dart';
import 'package:hrm_application/Views/Services/PayrollManage/Payslip/Detail/payslip_detail.dart';
import 'package:hrm_application/Views/Services/PayrollManage/Payslip/payslips_inf.dart';
import 'package:hrm_application/widgets/colors.dart';
import 'package:pluto_grid/pluto_grid.dart';

class PayslipDataTable extends StatefulWidget {
  @override
  _PayslipDataTableState createState() => _PayslipDataTableState();
}

class _PayslipDataTableState extends State<PayslipDataTable> {
  List<PlutoRow> rows = [];

  @override
  void initState() {
    super.initState();
    rows = getPayslips().map((payslip) {
      return PlutoRow(cells: {
        'Employee': PlutoCell(value: payslip['Employee']),
        'Reference': PlutoCell(value: payslip['Reference']),
        'Contract Reference': PlutoCell(value: payslip['Contract Reference']),
        'Start Date': PlutoCell(value: payslip['Start Date'].toString()),
        'End Date': PlutoCell(value: payslip['End Date'].toString()),
        'Batch': PlutoCell(value: payslip['Batch']),
        'Structure': PlutoCell(value: payslip['Structure']),
        'Others': PlutoCell(value: payslip['Others']),
        'Status': PlutoCell(value: payslip['Status']),
      });
    }).toList();
  }

  void deleteRow(int index) {
    setState(() {
      rows.removeAt(index);
      batches.removeAt(index);
    });
  }

  void updatePayslip(int index, PayslipData updatedPayslip) {
    setState(() {
      rows[index] = PlutoRow(cells: {
        'Employee': PlutoCell(value: updatedPayslip.name),
        'Reference': PlutoCell(value: updatedPayslip.reference),
        'Contract Reference': PlutoCell(value: updatedPayslip.contractRef),
        'Start Date': PlutoCell(value: updatedPayslip.startDate.toString()),
        'End Date': PlutoCell(value: updatedPayslip.endDate.toString()),
        'Batch': PlutoCell(value: updatedPayslip.batch),
        'Structure': PlutoCell(value: updatedPayslip.structure),
        'Others': PlutoCell(value: updatedPayslip.others),
        'Status': PlutoCell(value: updatedPayslip.status),
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<PlutoColumn> columns = [
      PlutoColumn(
        title: 'Reference',
        field: 'Reference',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Employee',
        field: 'Employee',
        type: PlutoColumnType.select(getNameEmp(employees)),
      ),
      PlutoColumn(
        title: 'Batch',
        field: 'Batch',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Status',
        field: 'Status',
        type: PlutoColumnType.select(PayslipData.defaultStatus),
      ),
    ];

    return PlutoGrid(
      columns: columns,
      rows: rows,
      onChanged: (PlutoGridOnChangedEvent event) {
        // Handle changes if necessary
      },
      onRowDoubleTap: (event) {
        final row = event.row;
        final index = rows.indexOf(row);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => PayslipDetail(
              batch: row.cells['Batch']!.value,
              startDate: row.cells['Start Date']!.value,
              endDate: row.cells['End Date']!.value,
              status: row.cells['Status']!.value,
              name: row.cells['Employee']!.value,
              reference: row.cells['Reference']!.value,
              contractRef: row.cells['Contract Reference']!.value,
              structure: row.cells['Structure']!.value,
              others: row.cells['Others']!.value,
              onDelete: () {
                deleteRow(index);
              },
              onUpdate: (updatedPayslip) {
                final updatedPayslipMap = updatedPayslip.toMap();
                final updatedPayslipData = PayslipData.fromMap(updatedPayslipMap);
                updatePayslip(index, updatedPayslipData);
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
