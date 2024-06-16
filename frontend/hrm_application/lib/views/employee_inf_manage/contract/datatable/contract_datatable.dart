import 'package:flutter/material.dart';

class ContractDataTable extends StatefulWidget {
  @override
  _ContractDataTableState createState() => _ContractDataTableState();
}

class _ContractDataTableState extends State<ContractDataTable> {
  final List<Map<String, String>> contracts = [
    {
      "Employee": "John Doe",
      "Reference": "REF123",
      "Department": "Administration",
      "Position": "Director",
      "Start Date": "2022-01-01",
      "End Date": "2023-01-01",
      "Contract Type": "Permanent",
      "Schedule": "Full-time",
      "Status": "Running",
    },
    {
      "Employee": "Alice Johnson",
      "Reference": "REF124",
      "Department": "Research & Development",
      "Position": "Project Manager",
      "Start Date": "2021-06-15",
      "End Date": "2022-06-15",
      "Contract Type": "Temporary",
      "Schedule": "Part-time",
      "Status": "Expired",
    },
    {
      "Employee": "Bob Smith",
      "Reference": "REF125",
      "Department": "Marketing",
      "Position": "Coordinator",
      "Start Date": "2022-03-01",
      "End Date": "2023-03-01",
      "Contract Type": "Full-time",
      "Schedule": "Full-time",
      "Status": "Cancelled",
    },
  ];

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int? _sortColumnIndex;
  bool _sortAscending = true;
  final Set<int> _selectedRows = {};

  void _sort<T>(Comparable<T> Function(Map<String, String> d) getField, int columnIndex, bool ascending) {
    contracts.sort((a, b) {
      if (!ascending) {
        final Map<String, String> c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  void _editCell(int rowIndex, String columnName, String newValue) {
    setState(() {
      contracts[rowIndex][columnName] = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: PaginatedDataTable(
        showCheckboxColumn: true,
        rowsPerPage: _rowsPerPage,
        onRowsPerPageChanged: (value) {
          setState(() {
            _rowsPerPage = value!;
          });
        },
        sortColumnIndex: _sortColumnIndex,
        sortAscending: _sortAscending,
        columns: [
          DataColumn(
            label: Text('Employee', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            onSort: (columnIndex, ascending) => _sort<String>((d) => d['Employee']!, columnIndex, ascending),
          ),
          DataColumn(
            label: Text('Reference', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            onSort: (columnIndex, ascending) => _sort<String>((d) => d['Reference']!, columnIndex, ascending),
          ),
          DataColumn(
            label: Text('Department', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            onSort: (columnIndex, ascending) => _sort<String>((d) => d['Department']!, columnIndex, ascending),
          ),
          DataColumn(
            label: Text('Position', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            onSort: (columnIndex, ascending) => _sort<String>((d) => d['Position']!, columnIndex, ascending),
          ),
          DataColumn(
            label: Text('Start Date', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            onSort: (columnIndex, ascending) => _sort<String>((d) => d['Start Date']!, columnIndex, ascending),
          ),
          DataColumn(
            label: Text('End Date', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            onSort: (columnIndex, ascending) => _sort<String>((d) => d['End Date']!, columnIndex, ascending),
          ),
          DataColumn(
            label: Text('Contract Type', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            onSort: (columnIndex, ascending) => _sort<String>((d) => d['Contract Type']!, columnIndex, ascending),
          ),
          DataColumn(
            label: Text('Schedule', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            onSort: (columnIndex, ascending) => _sort<String>((d) => d['Schedule']!, columnIndex, ascending),
          ),
          DataColumn(
            label: Text('Status', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            onSort: (columnIndex, ascending) => _sort<String>((d) => d['Status']!, columnIndex, ascending),
          ),
        ],
        source: ContractDataSource(
          contracts,
          _selectedRows,
          (bool value, int index) {
            setState(() {
              if (value) {
                _selectedRows.add(index);
              } else {
                _selectedRows.remove(index);
              }
            });
          },
          _editCell,
        ),
      ),
    );
  }
}

class ContractDataSource extends DataTableSource {
  final List<Map<String, String>> contracts;
  final Set<int> selectedRows;
  final Function(bool, int) onSelected;
  final Function(int, String, String) editCell;

  ContractDataSource(this.contracts, this.selectedRows, this.onSelected, this.editCell);

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= contracts.length) return null;
    final contract = contracts[index];
    final isSelected = selectedRows.contains(index);

    // Example dropdown items for Contract Type
    List<String> contractTypes = ['Permanent', 'Temporary', 'Full-time', 'Part-time'];

    return DataRow.byIndex(
      index: index,
      selected: isSelected,
      onSelectChanged: (value) => onSelected(value!, index),
      cells: [
        DataCell(
          DropdownButtonFormField<String>(
            value: contract['Employee'],
            onChanged: (value) => editCell(index, 'Employee', value!),
            items: ['John Doe', 'Alice Johnson', 'Bob Smith']
                .map((String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ))
                .toList(),
          ),
          showEditIcon: true,
        ),
        DataCell(
          DropdownButtonFormField<String>(
            value: contract['Reference'],
            onChanged: (value) => editCell(index, 'Reference', value!),
            items: ['REF123', 'REF124', 'REF125']
                .map((String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ))
                .toList(),
          ),
          showEditIcon: true,
        ),
        DataCell(
          DropdownButtonFormField<String>(
            value: contract['Department'],
            onChanged: (value) => editCell(index, 'Department', value!),
            items: ['Administration', 'Research & Development', 'Marketing']
                .map((String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ))
                .toList(),
          ),
          showEditIcon: true,
        ),
        DataCell(
          DropdownButtonFormField<String>(
            value: contract['Position'],
            onChanged: (value) => editCell(index, 'Position', value!),
            items: ['Director', 'Project Manager', 'Coordinator']
                .map((String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ))
                .toList(),
          ),
          showEditIcon: true,
        ),
        DataCell(
          TextFormField(
            initialValue: contract['Start Date'],
            onChanged: (value) => editCell(index, 'Start Date', value),
          ),
          showEditIcon: true,
        ),
        DataCell(
          TextFormField(
            initialValue: contract['End Date'],
            onChanged: (value) => editCell(index, 'End Date', value),
          ),
          showEditIcon: true,
        ),
        DataCell(
          DropdownButtonFormField<String>(
            value: contract['Contract Type'],
            onChanged: (value) => editCell(index, 'Contract Type', value!),
            items: contractTypes
                .map((String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ))
                .toList(),
          ),
          showEditIcon: true,
        ),
        DataCell(
          DropdownButtonFormField<String>(
            value: contract['Schedule'],
            onChanged: (value) => editCell(index, 'Schedule', value!),
            items: ['Full-time', 'Part-time']
                .map((String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ))
                .toList(),
          ),
          showEditIcon: true,
        ),
        DataCell(
          DropdownButtonFormField<String>(
            value: contract['Status'],
            onChanged: (value) => editCell(index, 'Status', value!),
            items: ['Running', 'Expired', 'Cancelled']
                .map((String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ))
                .toList(),
          ),
          showEditIcon: true,
        ),
      ],
    );
  }

  @override
  int get rowCount => contracts.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedRows.length;
}