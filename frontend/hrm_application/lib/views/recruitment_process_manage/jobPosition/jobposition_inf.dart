class JobPositionInf {
  final String role;
  final String department;
  final String mail;
  final String jobLocation;
  final String type;
  final int target;
  final bool isPublished;
  final String recruiter;
  final String interviewer;
  final String? details;
  static final List<String> defaultJobLocations = ['HRMapp', 'Abroad', 'Remote'];

  JobPositionInf({
    required this.department,
    required this.mail,
    required this.jobLocation,
    required this.role,
    required this.type,
    required this.target,
    required this.isPublished,
    required this.recruiter,
    required this.interviewer,
    this.details,
  });
}

int countJobPositionsInDepartment(List<JobPositionInf> jobPositions, String department) {
  return jobPositions.where((jobPosition) => jobPosition.department == department).length;
}

List<String> getJobPositions(List<JobPositionInf> jobPositions) {
  return jobPositions.map((jobPosition) => jobPosition.role).toSet().toList()..sort((a, b) => a.compareTo(b));
}

List<String> getRolesInDepartment(List<JobPositionInf> jobPositions, String department) {
  return jobPositions
    .where((jobPosition) => jobPosition.department == department)
    .map((jobPosition) => jobPosition.role)
    .toSet()
    .toList()
    ..sort((a, b) => a.compareTo(b));
}

final List<JobPositionInf> jobPositions = [
  JobPositionInf(
    department: 'Financial',
    mail: '5wqQ3@example.com',
    jobLocation: 'HRMapp',
    role: 'Business Analysis',
    type: 'Full-time',
    target: 5,
    isPublished: true,
    recruiter: 'Chau Bui',
    interviewer: 'Obito',
    details: "Time to Answer, 2 open days, Process, 1 Phone Call, 1 Onsite Interview, Days to get an Offer, 4 Days after Interview",  
  ),
  JobPositionInf(
    department: 'Quality',
    mail: '5wqQ3@example.com',
    jobLocation: 'HRMapp',
    role: 'Quality Control',
    type: 'Full-time',
    target: 3,
    isPublished: true,
    recruiter: 'Dam Tong',
    interviewer: 'Thinh Noo',
    details: 'This is a note',
  ),
  JobPositionInf(
    department: 'Quality',
    mail: '5wqQ3@example.com',
    jobLocation: 'HRMapp',
    role: 'Quality Assurance',
    type: 'Full-time',
    target: 2,
    isPublished: true,
    recruiter: 'Dat G',
    interviewer: 'Decao CG',
    details: "Time to Answer, 2 open days, Process, 1 Phone Call, 1 Onsite Interview, Days to get an Offer, 4 Days after Interview",
  ),
  JobPositionInf(
    department: 'Quality',
    mail: '5wqQ3@example.com',
    jobLocation: 'HRMapp',
    role: 'Tester',
    type: 'Full-time',
    target: 2,
    isPublished: true,
    recruiter: 'Dat G',
    interviewer: 'Decao CG',
    details: "Time to Answer, 2 open days, Process, 1 Phone Call, 1 Onsite Interview, Days to get an Offer, 4 Days after Interview",
  ),
  JobPositionInf(
    department: 'Accounting',
    mail: '5wqQ3@example.com',
    jobLocation: 'HRMapp',
    role: 'Accountant',
    type: 'Full-time',
    target: 2,
    isPublished: true,
    recruiter: 'Dat G',
    interviewer: 'Decao CG',
    details: "Time to Answer, 2 open days, Process, 1 Phone Call, 1 Onsite Interview, Days to get an Offer, 4 Days after Interview",
  ),   
  JobPositionInf(
    department: 'Sales',
    mail: '5wqQ3@example.com',
    jobLocation: 'HRMapp',
    role: 'Content Creator',
    type: 'Full-time',
    target: 7,
    isPublished: true,
    recruiter: 'Chau Bui',
    interviewer: 'Obito',
    details: "Time to Answer, 2 open days, Process, 1 Phone Call, 1 Onsite Interview, Days to get an Offer, 4 Days after Interview",
  ),
  JobPositionInf(
    department: 'Sales',
    mail: '5wqQ3@example.com',
    jobLocation: 'HRMapp',
    role: 'Digital Marketing',
    type: 'Full-time',
    target: 3,
    isPublished: false,
    recruiter: 'Chau Bui',
    interviewer: 'Obito',
    details: "Time to Answer, 2 open days, Process, 1 Phone Call, 1 Onsite Interview, Days to get an Offer, 4 Days after Interview",
  ),   
  JobPositionInf(
    department: 'Sales',
    mail: '5wqQ3@example.com',
    jobLocation: 'HRMapp',
    role: 'Sales',
    type: 'Full-time',
    target: 3,
    isPublished: false,
    recruiter: 'Chau Bui',
    interviewer: 'Obito',
    details: "Time to Answer, 2 open days, Process, 1 Phone Call, 1 Onsite Interview, Days to get an Offer, 4 Days after Interview",
  ), 
  JobPositionInf(
    department: 'Human Resource',
    mail: '5wqQ3@example.com',
    jobLocation: 'HRMapp',
    role: 'Collaborator',
    type: 'Permanent',
    target: 5,
    isPublished: false,
    recruiter: 'Chau Bui',
    interviewer: 'Dam Tong',
    details: 'This is a note',
  ),
  JobPositionInf(
    department: 'Human Resource',
    mail: '5wqQ3@example.com',
    jobLocation: 'HRMapp',
    role: 'HR',
    type: 'Permanent',
    target: 4,
    isPublished: true,
    recruiter: 'Chau Bui',
    interviewer: 'Dam Tong',
    details: 'This is a note',
  ),
  JobPositionInf(
    department: 'Research & Development',
    mail: '5wqQ3@example.com',
    jobLocation: 'HRMapp',
    role: 'Actuary',
    type: 'Permanent',
    target: 1,
    isPublished: false,
    recruiter: 'Chau Bui',
    interviewer: 'Dam Tong',
    details: 'This is a note',
  ),
  JobPositionInf(
    department: 'Research & Development',
    mail: '5wqQ3@example.com',
    jobLocation: 'HRMapp',
    role: 'Designer',
    type: 'Permanent',
    target: 2,
    isPublished: false,
    recruiter: 'Chau Bui',
    interviewer: 'Dam Tong',
    details: 'This is a note',
  ),
  JobPositionInf(
    department: 'Research & Development',
    mail: '5wqQ3@example.com',
    jobLocation: 'HRMapp',
    role: 'Dev',
    type: 'Permanent',
    target: 6,
    isPublished: false,
    recruiter: 'Chau Bui',
    interviewer: 'Dam Tong',
    details: 'This is a note',
  ),
  JobPositionInf(
    department: 'Research & Development',
    mail: '5wqQ3@example.com',
    jobLocation: 'HRMapp',
    role: 'Project Manager',
    type: 'Permanent',
    target: 2,
    isPublished: true,
    recruiter: 'Chau Bui',
    interviewer: 'Dam Tong',
    details: 'This is a note',
  ),
  JobPositionInf(
    department: 'Administration',
    mail: '5wqQ3@example.com',
    jobLocation: 'HRMapp',
    role: 'Database Administrator',
    type: 'Permanent',
    target: 2,
    isPublished: false,
    recruiter: 'Chau Bui',
    interviewer: 'Dam Tong',
    details: 'This is a note',
  ),
  JobPositionInf(
    department: 'Administration',
    mail: '5wqQ3@example.com',
    jobLocation: 'HRMapp',
    role: 'Secretary',
    type: 'Permanent',
    target: 2,
    isPublished: false,
    recruiter: 'Chau Bui',
    interviewer: 'Dam Tong',
    details: 'This is a note',
  ),
  JobPositionInf(
    department: 'Administration',
    mail: '5wqQ3@example.com',
    jobLocation: 'HRMapp',
    role: 'CEO',
    type: 'Permanent',
    target: 0,
    isPublished: true,
    recruiter: 'Chau Bui',
    interviewer: 'Dam Tong',
    details: 'This is a note',
  ),
  JobPositionInf(
    department: 'Administration',
    mail: '5wqQ3@example.com',
    jobLocation: 'HRMapp',
    role: 'Director',
    type: 'Permanent',
    target: 0,
    isPublished: true,
    recruiter: 'Chau Bui',
    interviewer: 'Dam Tong',
    details: 'This is a note',
  ),
];
