class EmployeeInf {
  final String name;
  final String role;
  final String mail;
  final String mobile;
  final String department;
  final String manager;
  final bool isManager;

  EmployeeInf({
    required this.name,
    required this.role,
    required this.mail,
    required this.mobile,
    required this.department,
    required this.manager,
    required this.isManager,
  });
}

int countEmployeesInDepartment(List<EmployeeInf> employees, String department) {
  return employees.where((employee) => employee.department == department).length;
}

List<String> getManagers(List<EmployeeInf> employees) {
  return employees.where((employee) => employee.isManager).map((e) => e.name).toList();
}

final List<EmployeeInf> employees = [
  //Administration
  EmployeeInf(
    name: 'Son Tung MTP',
    role: 'Director',
    mail: 'sontung@gmail.com',
    mobile: '123-456-7890',
    department: 'Administration',
    manager: 'Phuong Hang',
    isManager: true,
  ),
  EmployeeInf(
    name: 'Phuong Hang',
    role: 'CEO',
    mail: 'phuonghang@gmail.com',
    mobile: '890-123-4567',
    department: 'Administration',
    manager: 'Phuong Hang',
    isManager: true,
  ),
  EmployeeInf(
    name: 'Dat G',
    role: 'Secretary',
    mail: 'vosu@gmail.com',
    mobile: '123-456-7890',
    department: 'Administration',
    manager: 'Son Tung MTP',
    isManager: false,  
  ),
  EmployeeInf(
    name: 'HieuThuHai',
    role: 'Database Administrator',
    mail: 'babyboo@gmail.com',
    mobile: '123-456-7890',
    department: 'Administration',
    manager: 'Son Tung MTP',
    isManager: false,  
  ),
  //Research & Development
  EmployeeInf(
    name: 'Jack J97',
    role: 'Project Manager',
    mail: '5tr@gmail.com',
    mobile: '234-567-8901',
    department: 'Research & Development',
    manager: 'Son Tung MTP',
    isManager: true,  
  ),
  EmployeeInf(
    name: 'Huong Tit',
    role: 'Dev',
    mail: 'kth@gmail.com',
    mobile: '345-678-9012',
    department: 'Research & Development',
    manager: 'Jack J97',
    isManager: false,  
  ),
  EmployeeInf(
    name: 'Hieu PC',
    role: 'Dev',
    mail: 'hieupc@gmail.com',
    mobile: '456-789-0123',
    department: 'Research & Development',
    manager: 'Jack J97',
    isManager: false,  
  ),
  EmployeeInf(
    name: 'Andree RH',
    role: 'Designer',
    mail: 'lefthand@gmail.com',
    mobile: '123-456-7890',
    department: 'Research & Development',
    manager: 'Jack J97',
    isManager: false,  
  ),
  EmployeeInf(
    name: 'Decao CG',
    role: 'Actuary',
    mail: 'lamminh@gmail.com',
    mobile: '123-456-7890',
    department: 'Research & Development',
    manager: 'Jack J97',
    isManager: false,  
  ),
  EmployeeInf(
    name: 'Minh Tien',
    role: 'Collaborator',
    mail: 'tandien@gmail.com',
    mobile: '123-456-7890',
    department: 'Research & Development',
    manager: 'Jack J97',
    isManager: false,  
  ),
  //HR
  EmployeeInf(
    name: 'Chau Bui',
    role: 'HR',
    mail: 'chaubui@gmail.com',
    mobile: '678-901-2345',
    department: 'Human Resources',
    manager: 'Son Tung MTP',
    isManager: true,  
  ),
  EmployeeInf(
    name: 'Dam Tong',
    role: 'HR',
    mail: 'ngoclinh@gmail.com',
    mobile: '789-012-3456',
    department: 'Human Resources',
    manager: 'Chau Bui',
    isManager: false,  
  ),
  //Sales
  EmployeeInf(
    name: 'Tran Thanh',
    role: 'Content Creator',
    mail: 'mrcry@gmail.com',
    mobile: '901-234-5678',
    department: 'Sales',
    manager: 'Son Tung MTP',
    isManager: true,  
  ),
  EmployeeInf(
    name: 'Chi Pu',
    role: 'Content Creator',
    mail: 'cbc@gmail.com',
    mobile: '012-345-6789',
    department: 'Sales',
    manager: 'Tran Thanh',
    isManager: false,  
  ),
  EmployeeInf(
    name: 'Trung Tin',
    role: 'Collaborator',
    mail: 'trungtin@gmail.com',
    mobile: '123-456-7890',
    department: 'Sales',
    manager: 'Tran Thanh',
    isManager: false,  
  ),
  EmployeeInf(
    name: 'Thang Ngot',
    role: 'Sales',
    mail: 'nhactamda@gmail.com',
    mobile: '123-456-7890',
    department: 'Sales',
    manager: 'Tran Thanh',
    isManager: false,  
  ),
  EmployeeInf(
    name: 'Truong Giang',
    role: 'Sales',
    mail: 'hetai@gmail.com',
    mobile: '123-456-7890',
    department: 'Sales',
    manager: 'Tran Thanh',
    isManager: false,  
  ),
  //Accounting
  EmployeeInf(
    name: 'Chi Long',
    role: 'Accountant',
    mail: 'mck@gmail.com',
    mobile: '123-456-7890',
    department: 'Accounting',
    manager: 'Son Tung MTP',
    isManager: true,  
  ),
  //Quality
  EmployeeInf(
    name: 'Thinh Noo',
    role: 'Quality Assurance',
    mail: 'noo@gmail.com',
    mobile: '234-567-8901',
    department: 'Quality',
    manager: 'Son Tung MTP',
    isManager: true,  
  ),
  EmployeeInf(
    name: 'Ngoc Thy',
    role: 'Tester',
    mail: 'victoria@gmail.com',
    mobile: '567-890-1234',
    department: 'Quality',
    manager: 'Thinh Noo',
    isManager: false,  
  ),
  //Financial
  EmployeeInf(
    name: 'Obito',
    role: 'Business Analysis',
    mail: 'vstra@gmail.com',
    mobile: '123-456-7890',
    department: 'Financial',
    manager: 'Son Tung MTP',
    isManager: true,  
  ),
];
