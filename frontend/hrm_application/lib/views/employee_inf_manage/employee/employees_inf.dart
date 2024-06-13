class Employee {
  final String name;
  final String role;
  final String email;
  final String phone;
  final String department;
  final String manager;

  Employee({
    required this.name,
    required this.role,
    required this.email,
    required this.phone,
    required this.department,
    required this.manager,
  });
}

final List<Employee> employees = [
  Employee(
    name: 'John Doe',
role: 'Position 1',
    email: 'johndoe@example.com',
    phone: '123-456-7890',
    department: 'Department 1',
    manager: 'Manager 1',
  ),
  Employee(
    name: 'Alice Johnson',
role: 'Position 1',
    email: 'alice.johnson@example.com',
    phone: '234-567-8901',
    department: 'Department 1',
    manager: 'Manager 1',
  ),
  Employee(
    name: 'Bob Smith',
role: 'Position 1',
    email: 'bob.smith@example.com',
    phone: '345-678-9012',
    department: 'Department 1',
    manager: 'Manager 1',
  ),
  Employee(
    name: 'Charlie Brown',
role: 'Position 1',
    email: 'charlie.brown@example.com',
    phone: '456-789-0123',
    department: 'Department 1',
    manager: 'Manager 1',
  ),
  Employee(
    name: 'Daisy Ridley',
role: 'Position 1',
    email: 'daisy.ridley@example.com',
    phone: '567-890-1234',
    department: 'Department 1',
    manager: 'Manager 1',
  ),
  Employee(
    name: 'Edward Norton',
role: 'Position 1',
    email: 'edward.norton@example.com',
    phone: '678-901-2345',
    department: 'Department 1',
    manager: 'Manager 1',
  ),
  Employee(
    name: 'Fiona Gallagher',
role: 'Position 1',
    email: 'fiona.gallagher@example.com',
    phone: '789-012-3456',
    department: 'Department 1',
    manager: 'Manager 1',
  ),
  Employee(
    name: 'Gordon Ramsay',
role: 'Position 1',
    email: 'gordon.ramsay@example.com',
    phone: '890-123-4567',
    department: 'Department 1',
    manager: 'Manager 1',
  ),
  Employee(
    name: 'Hannah Montana',
role: 'Position 1',
    email: 'hannah.montana@example.com',
    phone: '901-234-5678',
    department: 'Department 1',
    manager: 'Manager 1',
  ),
  Employee(
    name: 'Igor Stravinsky',
    role: 'Position 1',
    email: 'igor.stravinsky@example.com',
    phone: '012-345-6789',
    department: 'Department 1',
    manager: 'Manager 1',
  ),
];
