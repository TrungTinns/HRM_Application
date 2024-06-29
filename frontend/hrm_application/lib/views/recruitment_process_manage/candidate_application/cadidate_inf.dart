class CandidateInf {
  final String introRole;
  final String role;
  final String name;
  final String mail;
  final String mobile;
  final String department;
  final String? profile;
  final String? degree;
  final String? interviewer;
  final String? recruiter;
  final double? elevation;
  final String? availability;
  final double? expectedSalary;
  final double? proposedSalary;
  final String? summary;

  CandidateInf({
    required this.introRole,
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
    this.summary,
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
    introRole: 'Software Developer',
    role: 'Business Analysis',
    name: 'Alice Smith',
    mail: 'alice@example.com',
    mobile: '1234567890',
    department: 'Research & Development',
    profile: 'Experienced in Flutter and Dart',
    degree: 'Graduated',
    interviewer: 'Chau Bui',
    recruiter: 'Jack J97',
    elevation: 2.0,
    availability: '01-01-2023',
    expectedSalary: 60000,
    proposedSalary: 55000,
    summary: 'Promising candidate with solid skills in mobile development.',
  ),
  CandidateInf(
    introRole: 'QC 1 years experience',
    role: 'Quality Control',
    name: 'Negav',
    mail: 'pB9pH@example.com',
    mobile: '1234567890',
    department: 'Quality',
    profile: 'https://example.com/profile.jpg',
    degree: 'Graduated',
    interviewer: 'Thinh Noo',
    recruiter: 'Dam Tong',
    elevation: 2.0,
    availability: '02-10-2022',
    expectedSalary: 5000.0,
    proposedSalary: 4000.0,
  ),
  CandidateInf(
    introRole: 'HR without experience',
    role: 'Collaborator',
    name: 'Tage',
    mail: 'pB9pH@example.com',
    mobile: '1234567890',
    department: 'Human Resource',
    profile: 'https://example.com/profile.jpg',
    degree: 'Graduated',
    interviewer: 'Dam Tong',
    recruiter: 'Chau Bui',
    elevation: 2.0,
    availability: '02-10-2022',
    expectedSalary: 5000.0,
    proposedSalary: 4000.0,
  ),
  CandidateInf(
    introRole: 'HR 1 years experience',
    role: 'Collaborator',
    name: 'Karik',
    mail: 'pB9pH@example.com',
    mobile: '1234567890',
    department: 'Human Resource',
    profile: 'https://example.com/profile.jpg',
    degree: 'Master',
    interviewer: 'Dam Tong',
    recruiter: 'Chau Bui',
    elevation: 2.0,
    availability: '02-10-2022',
    expectedSalary: 5000.0,
    proposedSalary: 4000.0,
  ),
  CandidateInf(
    introRole: 'BA 2 years experience ',
    role: 'Business Analysis',
    name: 'Tlinh',
    mail: 'john.doe@example.com',
    mobile: '1234567890',
    department: 'Financial',
    profile: 'https://example.com/profile1.jpg',
    degree: 'Master',
    interviewer: 'Obito',
    recruiter: 'Chau Bui',
    elevation: 2.0,
    availability: '02-10-2022',
    expectedSalary: 5000.0,
    proposedSalary: 4000.0,
  ),
  CandidateInf(
    introRole: 'QC 3 years experience',
    role: 'Quality Control',
    name: 'Binz',
    mail: 'jane.smith@example.com',
    mobile: '0987654321',
    department: 'Quality',
    profile: 'https://example.com/profile2.jpg',
    degree: 'Bachelor',
    interviewer: 'Thinh Noo',
    recruiter: 'Dam Tong',
    elevation: 2.0,
    availability: '02-10-2022',
    expectedSalary: 6000.0,
    proposedSalary: 5000.0,
  ),
  CandidateInf(
    introRole: 'HR 2 years experience',
    role: 'Collaborator',
    name: 'Dick',
    mail: 'bob.johnson@example.com',
    mobile: '5555555555',
    department: 'Human Resource',
    profile: 'https://example.com/profile3.jpg',
    degree: 'Master',
    interviewer: 'Dam Tong',
    recruiter: 'Chau Bui',
    elevation: 2.0,
    availability: '02-10-2022',
    expectedSalary: 5500.0,
    proposedSalary: 5000.0,
  ),
  CandidateInf(
    introRole: 'CC 2 years experience',
    role: 'Content Creator',
    name: 'Tofu',
    mail: 'alice.brown@example.com',
    mobile: '6666666666',
    department: 'Sales',
    profile: 'https://example.com/profile4.jpg',
    degree: 'Bachelor',
    interviewer: 'Obito',
    recruiter: 'Chau Bui',
    elevation: 2.0,
    availability: '02-10-2022',
    expectedSalary: 6000.0,
    proposedSalary: 5500.0,
  ),
  CandidateInf(
    introRole: 'DM 1.5 years experience',
    role: 'Digital Marketing',
    name: 'Ricky',
    mail: 'david.lee@example.com',
    mobile: '7777777777',
    department: 'Sales',
    profile: 'https://example.com/profile5.jpg',
    degree: 'Master',
    interviewer: 'Obito',
    recruiter: 'Chau Bui',
    elevation: 2.0,
    availability: '02-10-2022',
    expectedSalary: 6500.0,
    proposedSalary: 6000.0,
  ),
  CandidateInf(
    introRole: 'Tester 3 years experience',
    role: 'Tester',
    name: 'Atus',
    mail: 'emily.wilson@example.com',
    mobile: '8888888888',
    department: 'Research & Development',
    profile: 'https://example.com/profile6.jpg',
    degree: 'Bachelor',
    interviewer: 'Decao CG',
    recruiter: 'Dat G',
    elevation: 2.0,
    availability: '02-10-2022',
    expectedSalary: 7000.0,
    proposedSalary: 6500.0,
  ),
];
