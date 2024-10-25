import 'package:flutter/material.dart';
import 'package:hrm_application/Views/Services/RecruitmentProcessManage/CandidateApplication/application_manage.dart';
import 'package:hrm_application/Views/Services/RecruitmentProcessManage/CandidateApplication/Data/cadidate_data.dart';
import 'package:hrm_application/Views/Services/RecruitmentProcessManage/JobPosition/Detail/jobposition_detail.dart';
import 'package:hrm_application/Widgets/colors.dart';


class JobPositionCard extends StatelessWidget {
  final String id;
  final String name;
  final String department;
  final String mail;
  final String jobLocation;
  final String empType;
  final int target;
  final String recruiterId;
  final String interviewerId;
  final String? details;

  JobPositionCard({
    required this.id,
    required this.department,
    required this.mail,
    required this.jobLocation,
    required this.name,
    required this.empType,
    required this.target,
    required this.recruiterId,
    required this.interviewerId,
    this.details,
  });

  Future<int> countCandidatesInDepartment(String jobPositionId) async {
    List<CandidateData> candidates = await fetchCandidates();
    int count = candidates.where((employee) => employee.jobPositionId == jobPositionId).length;
    print(jobPositionId + " - " + count.toString());
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) =>
                        JobPositionDetail(
                          id: id,
                          name: name,
                          department: department,
                          mail: mail,
                          jobLocation: jobLocation,
                          empType: empType,
                          target: target,
                          recruiterId: recruiterId,
                          interviewerId: interviewerId,
                          details: details,
                       )
                      ));
                    },
                    icon: const Icon(Icons.more_vert)
                  )
                ],
              ),
            ),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => ApplicationManage(
                          initialRole: id,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: textColor,
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: FutureBuilder<int>(
                    future: countCandidatesInDepartment(id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Text(
                          '${snapshot.data} New applications',
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                        );
                      }
                    },
                  ),
                ),
                Text('$target To Recruit', style: const TextStyle(color: primaryColor, fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
