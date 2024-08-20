import 'package:hrm_application/API/api.dart';

class CandidateData{
  final String id;
  final String name;
  final String subject;
  final String mail;
  final String mobile;
  final String? profileAddress;
  final String? degree;
  final String? interviewerId;
  final String? recruiterId;
  final String? appliedJob;
  final String? department;
  final String? source;
  final String? medium;
  final DateTime? availability;
  double evaluation;
  final double? expectedSalary;
  final double? proposedSalary;
  final String? applicationSummary;
  final String jobPositionId;
  final int? stage;
  final bool isHired;
  final bool isOffered;
  static final List<String> defaultStages = ['New', 'Initial Qualification', 'First Interview', 'Second Interview', 'Contract Proposal', 'Contract Signed'];

  CandidateData({
    required this.id,
    required this.name,
    required this.subject,
    required this.mail,
    required this.mobile,
    this.profileAddress,
    this.degree,
    this.interviewerId,
    this.recruiterId,
    this.appliedJob,
    this.department,
    this.source,
    this.medium,
    this.availability,
    required this.evaluation,
    this.expectedSalary,
    this.proposedSalary,
    this.applicationSummary,
    required this.jobPositionId,
    required this.stage,
    required this.isHired,
    required this.isOffered,
  });

  factory CandidateData.fromJson(Map<String, dynamic> json) {
    return CandidateData(
      id: json['id'],
      name: json['name'],
      subject: json['subject'],
      mail: json['mail'],
      mobile: json['mobile'],
      profileAddress: json['profileAddress'],
      degree: json['degree'],
      interviewerId: json['interviewerId'],
      recruiterId: json['recruiterId'],
      appliedJob: json['appliedJob'],
      department: json['department'],
      source: json['source'],
      medium: json['medium'],
      availability: json['availability'] != null ? DateTime.parse(json['availability']) : null,
      evaluation: (json['evaluation'] as num?)?.toDouble() ??0.0,
      expectedSalary: (json['expectedSalary'] as num?)?.toDouble() ?? 0.0,
      proposedSalary: (json['proposedSalary'] as num?)?.toDouble() ?? 0.0,
      applicationSummary: json['applicationSummary'],
      jobPositionId: json['jobPositionId'],
      stage: json['stage'] as int? ?? 0,
      isHired: json['isHired'],
      isOffered: json['isOffered'],
    );
  }
}


Future<List<CandidateData>> fetchCandidates() async {
  try {
 List<CandidateData> candidates = await fetchAPI<CandidateData>(
      apiUrl: 'http://localhost:9002/api/v1/recruitment/candidate',
      fromJson: (json) {
        return CandidateData(
          id: json['id'] ?? " ",
          name: json['name'] ?? " ",
          subject: json['subject'] ?? " ",
          mail: json['mail'] ?? " ",
          mobile: json['mobile'] ?? " ",
          profileAddress: json['profileAddress'] ?? " ",
          degree: json['degree'] ?? " ",
          interviewerId: json['interviewerId'] ?? " ",
          recruiterId: json['recruiterId'] ?? " ",
 appliedJob: json['appliedJob'] ?? " ",
          department: json['department'] ?? " ",
          source: json['source'] ?? " ",
          medium: json['medium'] ?? " ",
          availability: json['availability'] != null ? DateTime.parse(json['availability']) : null,
          evaluation: (json['evaluation'] as num?)?.toDouble() ?? 0.0,
          expectedSalary: (json['expectedSalary'] as num?)?.toDouble() ?? 0.0,
          proposedSalary: (json['proposedSalary'] as num?)?.toDouble() ?? 0.0,
          applicationSummary: json['applicationSummary'] ?? " ",
          jobPositionId: json['jobPositionId'] ?? " ",
          stage: json['stage'] as int? ?? 0,
          isHired: json['isHired'] ?? false,
          isOffered: json['isOffered'] ?? false,
        );
      },
    );

    print('Fetched ${candidates.length} candidates');
    return candidates;
  } catch (e) {
    print('Error fetching candidates: $e');
    return [];
  }
}


// int countCandidatesByRole(String role) {
//   int count = 0;
//   for (var candidate in candidates) {
//     if (candidate.role == role) {
//       count++;
//     }
//   }
//   return count;
// }

// List<CandidateInf> getCandidatesByStage(int stage) {
//   return candidates.where((candidate) => candidate.stage == stage).toList();
// }

// List<CandidateInf> getCandidatesByRole(String role) {
//   return candidates.where((candidate) => candidate.role == role).toList();
// }

// final List<CandidateInf> candidates = [
//   CandidateInf(
//     introRole: 'Software Developer',
//     role: 'Business Analysis',
//     name: 'Alice Smith',
//     mail: 'alice@example.com',
//     mobile: '1234567890',
//     department: 'Research & Development',
//     profile: 'Experienced in Flutter and Dart',
//     degree: 'Graduated',
//     interviewer: 'Chau Bui',
//     recruiter: 'Jack J97',
//     elevation: 2.0,
//     availability: '01-01-2023',
//     expectedSalary: 60000,
//     proposedSalary: 55000,
//     summary: 'Promising candidate with solid skills in mobile development.',
//     stage: 1,
//   ),
//   CandidateInf(
//     introRole: 'QC 1 years experience',
//     role: 'Quality Control',
//     name: 'Negav',
//     mail: 'pB9pH@example.com',
//     mobile: '1234567890',
//     department: 'Quality',
//     profile: 'https://example.com/profile.jpg',
//     degree: 'Graduated',
//     interviewer: 'Thinh Noo',
//     recruiter: 'Dam Tong',
//     elevation: 2.0,
//     availability: '02-10-2022',
//     expectedSalary: 5000.0,
//     proposedSalary: 4000.0,
//     stage: 5,
//   ),
//   CandidateInf(
//     introRole: 'HR without experience',
//     role: 'Collaborator',
//     name: 'Tage',
//     mail: 'pB9pH@example.com',
//     mobile: '1234567890',
//     department: 'Human Resource',
//     profile: 'https://example.com/profile.jpg',
//     degree: 'Graduated',
//     interviewer: 'Dam Tong',
//     recruiter: 'Chau Bui',
//     elevation: 2.0,
//     availability: '02-10-2022',
//     expectedSalary: 5000.0,
//     proposedSalary: 4000.0,
//     stage: 1,
//   ),
//   CandidateInf(
//     introRole: 'HR 1 years experience',
//     role: 'Collaborator',
//     name: 'Karik',
//     mail: 'pB9pH@example.com',
//     mobile: '1234567890',
//     department: 'Human Resource',
//     profile: 'https://example.com/profile.jpg',
//     degree: 'Master',
//     interviewer: 'Dam Tong',
//     recruiter: 'Chau Bui',
//     elevation: 2.0,
//     availability: '02-10-2022',
//     expectedSalary: 5000.0,
//     proposedSalary: 4000.0,
//     stage: 6,
//   ),
//   CandidateInf(
//     introRole: 'BA 2 years experience ',
//     role: 'Business Analysis',
//     name: 'Tlinh',
//     mail: 'john.doe@example.com',
//     mobile: '1234567890',
//     department: 'Financial',
//     profile: 'https://example.com/profile1.jpg',
//     degree: 'Master',
//     interviewer: 'Obito',
//     recruiter: 'Chau Bui',
//     elevation: 2.0,
//     availability: '02-10-2022',
//     expectedSalary: 5000.0,
//     proposedSalary: 4000.0,
//     stage: 4,
//   ),
//   CandidateInf(
//     introRole: 'QC 3 years experience',
//     role: 'Quality Control',
//     name: 'Binz',
//     mail: 'jane.smith@example.com',
//     mobile: '0987654321',
//     department: 'Quality',
//     profile: 'https://example.com/profile2.jpg',
//     degree: 'Bachelor',
//     interviewer: 'Thinh Noo',
//     recruiter: 'Dam Tong',
//     elevation: 2.0,
//     availability: '02-10-2022',
//     expectedSalary: 6000.0,
//     proposedSalary: 5000.0,
//     stage: 5,
//   ),
//   CandidateInf(
//     introRole: 'HR 2 years experience',
//     role: 'Collaborator',
//     name: 'Dick',
//     mail: 'bob.johnson@example.com',
//     mobile: '5555555555',
//     department: 'Human Resource',
//     profile: 'https://example.com/profile3.jpg',
//     degree: 'Master',
//     interviewer: 'Dam Tong',
//     recruiter: 'Chau Bui',
//     elevation: 2.0,
//     availability: '02-10-2022',
//     expectedSalary: 5500.0,
//     proposedSalary: 5000.0,
//     stage: 3,
//   ),
//   CandidateInf(
//     introRole: 'CC 2 years experience',
//     role: 'Content Creator',
//     name: 'Tofu',
//     mail: 'alice.brown@example.com',
//     mobile: '6666666666',
//     department: 'Sales',
//     profile: 'https://example.com/profile4.jpg',
//     degree: 'Bachelor',
//     interviewer: 'Obito',
//     recruiter: 'Chau Bui',
//     elevation: 2.0,
//     availability: '02-10-2022',
//     expectedSalary: 6000.0,
//     proposedSalary: 5500.0,
//     stage: 2,
//   ),
//   CandidateInf(
//     introRole: 'DM 1.5 years experience',
//     role: 'Digital Marketing',
//     name: 'Ricky',
//     mail: 'david.lee@example.com',
//     mobile: '7777777777',
//     department: 'Sales',
//     profile: 'https://example.com/profile5.jpg',
//     degree: 'Master',
//     interviewer: 'Obito',
//     recruiter: 'Chau Bui',
//     elevation: 2.0,
//     availability: '02-10-2022',
//     expectedSalary: 6500.0,
//     proposedSalary: 6000.0,
//     stage: 3,
//   ),
//   CandidateInf(
//     introRole: 'Tester 3 years experience',
//     role: 'Tester',
//     name: 'Atus',
//     mail: 'emily.wilson@example.com',
//     mobile: '8888888888',
//     department: 'Research & Development',
//     profile: 'https://example.com/profile6.jpg',
//     degree: 'Bachelor',
//     interviewer: 'Decao CG',
//     recruiter: 'Dat G',
//     elevation: 2.0,
//     availability: '02-10-2022',
//     expectedSalary: 7000.0,
//     proposedSalary: 6500.0,
//     stage: 1,
//   ),
// ];
