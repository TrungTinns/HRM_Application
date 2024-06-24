class EmployeeInf {
  final String name;
  final String role;
  final String mail;
  final String mobile;
  final String department;
  final String manager;

  EmployeeInf({
    required this.name,
    required this.role,
    required this.mail,
    required this.mobile,
    required this.department,
    required this.manager,
  });
}

int countEmployeesInDepartment(List<EmployeeInf> employees, String department) {
  return employees.where((employee) => employee.department == department).length;
}

final List<EmployeeInf> employees = [
  EmployeeInf(
    name: 'John Doe',
    role: 'Director',
    mail: 'johndoe@example.com',
    mobile: '123-456-7890',
    department: 'Administration',
    manager: 'Gordon Ramsay',
  ),
  EmployeeInf(
    name: 'Alice Johnson',
    role: 'Project Manager',
    mail: 'alice.johnson@example.com',
    mobile: '234-567-8901',
    department: 'Research & Development',
    manager: 'John Doe',
  ),
  EmployeeInf(
    name: 'Bob Smith',
    role: 'Dev',
    mail: 'bob.smith@example.com',
    mobile: '345-678-9012',
    department: 'Research & Development',
    manager: 'John Doe',
  ),
  EmployeeInf(
    name: 'Charlie Brown',
    role: 'Dev',
    mail: 'charlie.brown@example.com',
    mobile: '456-789-0123',
    department: 'Research & Development',
    manager: 'John Doe',
  ),
  EmployeeInf(
    name: 'Daisy Ridley',
    role: 'Tester',
    mail: 'daisy.ridley@example.com',
    mobile: '567-890-1234',
    department: 'Quality',
    manager: 'John Doe',
  ),
  EmployeeInf(
    name: 'Edward Norton',
    role: 'HR',
    mail: 'edward.norton@example.com',
    mobile: '678-901-2345',
    department: 'Human Resources',
    manager: 'John Doe',
  ),
  EmployeeInf(
    name: 'Fiona Gallagher',
    role: 'HR',
    mail: 'fiona.gallagher@example.com',
    mobile: '789-012-3456',
    department: 'Human Resources',
    manager: 'John Doe',
  ),
  EmployeeInf(
    name: 'Gordon Ramsay',
    role: 'CEO',
    mail: 'gordon.ramsay@example.com',
    mobile: '890-123-4567',
    department: 'Administration',
    manager: '',
  ),
  EmployeeInf(
    name: 'Hannah Montana',
    role: 'Content Creator',
    mail: 'hannah.montana@example.com',
    mobile: '901-234-5678',
    department: 'Sales',
    manager: 'John Doe',
  ),
  EmployeeInf(
    name: 'Igor Stravinsky',
    role: 'Content Creator',
    mail: 'igor.stravinsky@example.com',
    mobile: '012-345-6789',
    department: 'Sales',
    manager: 'John Doe',
  ),
  EmployeeInf(
    name: 'Huynh Hau',
    role: 'Accountant',
    mail: 'johndoe@example.com',
    mobile: '123-456-7890',
    department: 'Accounting',
    manager: 'John Doe',
  ),
  EmployeeInf(
    name: 'Nhat Hao',
    role: 'Quality Assurance',
    mail: 'alice.johnson@example.com',
    mobile: '234-567-8901',
    department: 'Quality',
    manager: 'John Doe',
  ),
  EmployeeInf(
    name: 'Chanh Tin',
    role: 'Business Analysis',
    mail: 'johndoe@example.com',
    mobile: '123-456-7890',
    department: 'Financial',
    manager: 'John Doe',
  ),
  EmployeeInf(
    name: 'Tuan An',
    role: 'Designer',
    mail: 'johndoe@example.com',
    mobile: '123-456-7890',
    department: 'Research & Development',
    manager: 'John Doe',
  ),
  EmployeeInf(
    name: 'Hoang Kien',
    role: 'Actuary',
    mail: 'johndoe@example.com',
    mobile: '123-456-7890',
    department: 'Research & Development',
    manager: 'John Doe',
  ),
  EmployeeInf(
    name: 'Huu Khanh',
    role: 'Secretary',
    mail: 'johndoe@example.com',
    mobile: '123-456-7890',
    department: 'Administration',
    manager: 'John Doe',
  ),
  EmployeeInf(
    name: 'Gia Khang',
    role: 'Sales',
    mail: 'johndoe@example.com',
    mobile: '123-456-7890',
    department: 'Sales',
    manager: 'John Doe',
  ),
  EmployeeInf(
    name: 'Trieu Vy',
    role: 'Sales',
    mail: 'johndoe@example.com',
    mobile: '123-456-7890',
    department: 'Sales',
    manager: 'John Doe',
  ),
  EmployeeInf(
    name: 'Gia Bao',
    role: 'Database Administrator',
    mail: 'johndoe@example.com',
    mobile: '123-456-7890',
    department: 'Administration',
    manager: 'John Doe',
  ),
  EmployeeInf(
    name: 'Minh Tien',
    role: 'Collaborator',
    mail: 'johndoe@example.com',
    mobile: '123-456-7890',
    department: 'Research & Development',
    manager: 'John Doe',
  ),
  EmployeeInf(
    name: 'Trung Tin',
    role: 'Collaborator',
    mail: 'tfwq@example.com',
    mobile: '123-456-7890',
    department: 'Sales',
    manager: 'John Doe',
  ),
];
