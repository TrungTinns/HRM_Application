import 'package:flutter/material.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';

class ApplicationCard extends StatelessWidget {
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
  final String? jobPositionId;
  final int stage;
  final bool isHired;
  final bool isOffered;
  final int progress;

  ApplicationCard({
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
    this.evaluation = 0.0,
    this.expectedSalary,
    this.proposedSalary,
    this.applicationSummary,
    this.jobPositionId,
    required this.stage,
    required this.isHired,
    required this.isOffered,
    required this.progress,
  });

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
                      // Navigator.push(context, MaterialPageRoute(builder: (ctx) =>
                      //   CandidateDetail(
                      //     introRole: introRole,
                      //     role: role,
                      //     name: name,
                      //     mail: mail,
                      //     mobile: mobile,
                      //     department: department,
                      //     profile: profile,
                      //     degree: degree,
                      //     interviewer: interviewer,
                      //     recruiter: recruiter,
                      //     availability: availability,
                      //     expectedSalary: expectedSalary,
                      //     proposedSalary: proposedSalary,
                      //     summary: summary,
                      //     elevation: elevation,
                      //     onDelete: onDelete,
                      //     onUpdate: onUpdate,
                      //     progress: progress,
                      //   )
                      // ));
                    },
                    icon: const Icon(Icons.more_vert)
                  )
                ],
              ),
            ),
            Text(jobPositionId!),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RatingBar(
                  filledIcon: Icons.star, 
                  emptyIcon: Icons.star_border,
                  initialRating: evaluation,
                  onRatingChanged: (value) {
                    evaluation = value;
                    // onUpdate(
                    //   CandidateInf(
                    //     introRole: introRole,
                    //     role: role,
                    //     name: name,
                    //     mail: mail,
                    //     mobile: mobile,
                    //     department: department,
                    //     profile: profile,
                    //     degree: degree,
                    //     interviewer: interviewer,
                    //     recruiter: recruiter,
                    //     availability: availability,
                    //     expectedSalary: expectedSalary,
                    //     proposedSalary: proposedSalary,
                    //     summary: summary,
                    //     elevation: elevation,
                    //     progress: progress
                    //   ),
                    // );
                  },
                  maxRating: 3,
                ),
                IconButton(
                  onPressed: (){
                
                  },
                  icon: const Icon(Icons.attachment),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}