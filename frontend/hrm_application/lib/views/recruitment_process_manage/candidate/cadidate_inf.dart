class CandidateInf {
  final String role;
  final String name;
  final String mail;
  final String mobile;
  final String department;
  final String? profile;
  final String? degree;
  final String? interviewer;
  final String? recruiter;
  final String? elevation;
  final double? availability;
  final double? expectedSalary;
  final double? proposedSalary;
  static final List<String> defaultDegrees = ['Graduate', 'Bachelor Degree', 'Master Degree', 'Doctoral Degree'];
  static final List<String> defaultCertifications = ['Graduated', 'Bachelor', 'Master', 'Doctor'];

  CandidateInf({
    required this.role,
    required this.name,
    required this.mail,
    required this.mobile,
    required this.department,
    this.profile,
    this.degree,
    this.interviewer,
    this.recruiter,
    this.elevation,
    this.availability,
    this.expectedSalary,
    this.proposedSalary,
  });
}

int countCandidatesByRole(String role) {
  int count = 0;
  for (var candidate in candidates) {
    if (candidate.role == role) {
      count++;
    }
  }
  return count;
}

final List<CandidateInf> candidates = [
  CandidateInf(
    role: 'Business Analysis',
    name: 'G Ducky',
    mail: 'pB9pH@example.com',
    mobile: '1234567890',
    department: 'Financial',
    profile: 'https://example.com/profile.jpg',
    degree: 'Bachelor Degree',
    interviewer: 'Obito',
    recruiter: 'Chau Bui',
    // elevation: '5.0',
    availability: 0.8,
    expectedSalary: 5000.0,
    proposedSalary: 4000.0,
  ),
  CandidateInf(
    role: 'Quality Control',
    name: 'Negav',
    mail: 'pB9pH@example.com',
    mobile: '1234567890',
    department: 'Quality',
    profile: 'https://example.com/profile.jpg',
    degree: 'Graduate',
    interviewer: 'Thinh Noo',
    recruiter: 'Dam Tong',
    // elevation: '5.0',
    availability: 0.8,
    expectedSalary: 5000.0,
    proposedSalary: 4000.0,
  ),
  CandidateInf(
    role: 'Collaborator',
    name: 'Tage',
    mail: 'pB9pH@example.com',
    mobile: '1234567890',
    department: 'Human Resource',
    profile: 'https://example.com/profile.jpg',
    degree: 'Graduate',
    interviewer: 'Dam Tong',
    recruiter: 'Chau Bui',
    // elevation: '5.0',
    availability: 0.8,
    expectedSalary: 5000.0,
    proposedSalary: 4000.0,
  ),
  CandidateInf(
    role: 'Collaborator',
    name: 'Karik',
    mail: 'pB9pH@example.com',
    mobile: '1234567890',
    department: 'Human Resource',
    profile: 'https://example.com/profile.jpg',
    degree: 'Master Degree',
    interviewer: 'Dam Tong',
    recruiter: 'Chau Bui',
    // elevation: '5.0',
    availability: 0.8,
    expectedSalary: 5000.0,
    proposedSalary: 4000.0,
  ),
  CandidateInf(
    role: 'Business Analysis',
    name: 'John Doe',
    mail: 'john.doe@example.com',
    mobile: '1234567890',
    department: 'Financial',
    profile: 'https://example.com/profile1.jpg',
    degree: 'Master Degree',
    interviewer: 'Obito',
    recruiter: 'Chau Bui',
    availability: 0.7,
    expectedSalary: 5000.0,
    proposedSalary: 4000.0,
  ),
  CandidateInf(
    role: 'Quality Control',
    name: 'Jane Smith',
    mail: 'jane.smith@example.com',
    mobile: '0987654321',
    department: 'Quality',
    profile: 'https://example.com/profile2.jpg',
    degree: 'Bachelor Degree',
    interviewer: 'Thinh Noo',
    recruiter: 'Dam Tong',
    availability: 0.9,
    expectedSalary: 6000.0,
    proposedSalary: 5000.0,
  ),
  CandidateInf(
    role: 'Collaborator',
    name: 'Bob Johnson',
    mail: 'bob.johnson@example.com',
    mobile: '5555555555',
    department: 'Human Resource',
    profile: 'https://example.com/profile3.jpg',
    degree: 'Master Degree',
    interviewer: 'Dam Tong',
    recruiter: 'Chau Bui',
    availability: 0.8,
    expectedSalary: 5500.0,
    proposedSalary: 5000.0,
  ),
  CandidateInf(
    role: 'Content Creator',
    name: 'Alice Brown',
    mail: 'alice.brown@example.com',
    mobile: '6666666666',
    department: 'Sales',
    profile: 'https://example.com/profile4.jpg',
    degree: 'Bachelor Degree',
    interviewer: 'Obito',
    recruiter: 'Chau Bui',
    availability: 0.9,
    expectedSalary: 6000.0,
    proposedSalary: 5500.0,
  ),
  CandidateInf(
    role: 'Digital Marketing',
    name: 'David Lee',
    mail: 'david.lee@example.com',
    mobile: '7777777777',
    department: 'Sales',
    profile: 'https://example.com/profile5.jpg',
    degree: 'Master Degree',
    interviewer: 'Obito',
    recruiter: 'Chau Bui',
    availability: 0.8,
    expectedSalary: 6500.0,
    proposedSalary: 6000.0,
  ),
  CandidateInf(
    role: 'Tester',
    name: 'Emily Wilson',
    mail: 'emily.wilson@example.com',
    mobile: '8888888888',
    department: 'Research & Development',
    profile: 'https://example.com/profile6.jpg',
    degree: 'Bachelor Degree',
    interviewer: 'Decao CG',
    recruiter: 'Dat G',
    availability: 0.9,
    expectedSalary: 7000.0,
    proposedSalary: 6500.0,
  ),
];
