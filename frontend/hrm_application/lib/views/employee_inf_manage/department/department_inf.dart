class DepartmentInf {
  final String department;
  final String manager;
  final String superior;

  DepartmentInf({
    required this.department,
    required this.manager,
    required this.superior,
  });
}

List<String> getDepartments() {
  return departments.map((department) => department.department).toSet().toList();
}

final List<DepartmentInf> departments = [
  DepartmentInf(
    department: 'Administration',
    manager: 'Son Tung MTP',
    superior: '',
  ),
  DepartmentInf(
    department: 'Research & Development',
    manager: 'Jack J97',
    superior: 'Administration',
  ),
  DepartmentInf(
    department: 'Accounting',
    manager: 'Chi Long',
    superior: 'Administration',
  ),
  DepartmentInf(
    department: 'Sales',
    manager: 'Tran Thanh',
    superior: 'Administration',
  ),
  DepartmentInf(
    department: 'Human Resources',
    manager: 'Chau Bui',
    superior: 'Administration',
  ),
  DepartmentInf(
    department: 'Quality',
    manager: 'Thinh Noo',
    superior: 'Research & Development',
  ),
  DepartmentInf(
    department: 'Financial',
    manager: 'Obito',
    superior: 'Administration',
  ),
];
