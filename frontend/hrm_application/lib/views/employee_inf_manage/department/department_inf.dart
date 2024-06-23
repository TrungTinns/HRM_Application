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

final List<DepartmentInf> departments = [
  DepartmentInf(
    department: 'Administration',
    manager: 'John Doe',
    superior: '',
  ),
  DepartmentInf(
    department: 'Research & Development',
    manager: 'Tuan An',
    superior: 'Administration',
  ),
  DepartmentInf(
    department: 'Accounting',
    manager: 'Huynh Hau',
    superior: 'Administration',
  ),
  DepartmentInf(
    department: 'Sales',
    manager: 'Gia Khang',
    superior: 'Administration',
  ),
  DepartmentInf(
    department: 'Human Resources',
    manager: 'Fiona Gallagher',
    superior: 'Administration',
  ),
  DepartmentInf(
    department: 'Quality',
    manager: 'Hannah Montana',
    superior: 'Research & Development',
  ),
  DepartmentInf(
    department: 'Financial',
    manager: 'Chanh Tin',
    superior: 'Administration',
  ),
];
