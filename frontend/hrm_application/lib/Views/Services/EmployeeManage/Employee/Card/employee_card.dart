import 'package:flutter/material.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Employee/Detail/employee_detail.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Employee/Data/employees_data.dart';

class EmployeeCard extends StatelessWidget {
  final String id;
  final String name;
  final String? role;
  final String mail;
  final String mobile;
  final String department;
  final String managerId;
  final bool? isManager;
  final String? workLocation;
  final String? schedule;
  final String? salaryStructure;
  final String? contractType;
  final double? cost;
  final String? personalAddress;
  final String? personalMail;
  final String? personalMobile;
  final String? relativeName;
  final String? relativeMobile;
  final String? certification;
  final String? school;
  final String? maritalStatus;
  final int? child;
  final String? nationality;
  final String? idNum;
  final String? ssNum;
  final String? passport;
  final String? sex;
  final DateTime? birthDate;
  final String? birthPlace;
  final String? idContract; 

  EmployeeCard({
    required this.id,
    required this.name,
    required this.role,
    required this.mail,
    required this.mobile,
    required this.department,
    required this.managerId,
    this.isManager,
    this.workLocation,
    this.schedule,
    this.salaryStructure,
    this.contractType,
    this.cost,
    this.personalAddress,
    this.personalMail,
    this.personalMobile,
    this.relativeName,
    this.relativeMobile,
    this.certification,
    this.school,
    this.maritalStatus,
    this.child,
    this.nationality,
    this.idNum,
    this.ssNum,
    this.passport,
    this.sex,
    this.birthDate,
    this.birthPlace,
    this.idContract,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EmployeeDetail(
              id: id,
              name: name,
              role: role,
              mail: mail,
              mobile: mobile,
              department: department,
              managerId: managerId,
              isManager: isManager ?? false,
              workLocation: workLocation ?? '',
              schedule: schedule ?? '',
              salaryStructure: salaryStructure ?? '',
              contractType: contractType ?? '',
              cost: double.tryParse(cost.toString()) ?? 0.0,
              personalAddress: personalAddress ?? '',
              personalMail: personalMail ?? '',
              personalMobile: personalMobile ?? '',
              relativeName: relativeName ?? '',
              relativeMobile: relativeMobile ?? '',
              certification: certification ?? '',
              school: school ?? '',
              maritalStatus: maritalStatus ?? '',
              child: int.tryParse(child.toString()) ?? 0,
              nationality: nationality ?? '',
              idNum: idNum ?? '',
              ssNum: ssNum ?? '',
              passport: passport ?? '',
              sex: sex ?? '',
              birthDate: birthDate?.toString() ?? '',
              birthPlace: birthPlace ?? '',
              idContract: idContract,
            ),
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.purple,
                child: Text(
                  name.isNotEmpty ? name[0].toUpperCase() : '',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (role != null) Text(role!),
                    Text(mail),
                    Text(mobile),
                    Text(department),
                    // Text(isManager.toString()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}