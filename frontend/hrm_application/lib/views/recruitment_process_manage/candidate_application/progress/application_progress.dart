import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_application/views/recruitment_process_manage/candidate_application/cadidate_inf.dart';
import 'package:hrm_application/views/recruitment_process_manage/candidate_application/detail/candidate_detail.dart';
import 'package:hrm_application/widgets/colors.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';

class ProgressBoard extends StatefulWidget {
  final String? initialRole; 

  const ProgressBoard({Key? key, this.initialRole}) : super(key: key);

  @override
  State<ProgressBoard> createState() => _ProgressBoardState();
}

class _ProgressBoardState extends State<ProgressBoard> {
  final AppFlowyBoardController controller = AppFlowyBoardController();
  late AppFlowyBoardScrollController boardController;

  @override
  void initState() {
    super.initState();
    boardController = AppFlowyBoardScrollController();
    initializeGroups();
  }

  void refreshBoard() {
    setState(() {
      controller.clear();
      initializeGroups();
    });
  }

  void initializeGroups() {
    controller.clear();
    final stages = CandidateInf.defaultStages;
    for (var i = 0; i < stages.length; i++) {
      String stageName = stages[i];
      List<CandidateItem> items = getCandidatesByStageAndRole(i + 1, widget.initialRole)
          .map((candidate) => CandidateItem(candidate, onDelete: () {
                setState(() {
                  candidates.remove(candidate);
                });
              }))
          .toList();
      final group = AppFlowyGroupData(
        id: stageName,
        name: stageName,
        items: items,
      );
      controller.addGroup(group);
    }
  }

  @override
  Widget build(BuildContext context) {
    const config = AppFlowyBoardConfig(
      groupBackgroundColor: Colors.transparent,
      stretchGroupHeight: false,
    );
    return AppFlowyBoard(
      controller: controller,
      cardBuilder: (context, group, groupItem) {
        return AppFlowyGroupCard(
          key: ValueKey(groupItem.id),
          child: _buildCard(groupItem),
        );
      },
      boardScrollController: boardController,
      headerBuilder: (context, columnData) {
        return AppFlowyGroupHeader(
          title: SizedBox(
            width: 150,
            child: TextField(
              style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold),
              controller: TextEditingController()..text = columnData.headerData.groupName,
              onSubmitted: (val) {
                controller.getGroupController(columnData.headerData.groupId)!.updateGroupName(val);
              },
            ),
          ),
          addIcon: const Icon(Icons.add, size: 20, color: textColor,),
          moreIcon: const Icon(Icons.more_horiz, size: 20, color: textColor,),
          height: 50,
          margin: config.groupBodyPadding,
        );
      },
      groupConstraints: const BoxConstraints.tightFor(width: 300),
      config: config,
    );
  }

  Widget _buildCard(AppFlowyGroupItem item) {
    if (item is CandidateItem) {
      Color? badgeColor;
      TextSpan? textSpan;

      if (item.candidate.stage == 6) {
        badgeColor = Colors.green;
        textSpan = const TextSpan(
          text: 'Hired',
          style: TextStyle(
            color: textColor,
            fontSize: 12,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
          ),
        );
      } else if (item.candidate.isRefused) {
        badgeColor = Colors.red;
        textSpan = const TextSpan(
          text: 'Refused',
          style: TextStyle(
            color: textColor,
            fontSize: 12,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
          ),
        );
      }

      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            foregroundDecoration: badgeColor != null
                ? RotatedCornerDecoration.withColor(
                    color: badgeColor,
                    spanBaselineShift: 4,
                    badgeSize: Size(64, 64),
                    badgeCornerRadius: Radius.circular(0),
                    badgePosition: BadgePosition.topStart,
                    textSpan: textSpan!,
                  )
                : null,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.candidate.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => CandidateDetail(
                                  introRole: item.candidate.introRole,
                                  role: item.candidate.role,
                                  name: item.candidate.name,
                                  mail: item.candidate.mail,
                                  mobile: item.candidate.mobile,
                                  department: item.candidate.department,
                                  profile: item.candidate.profile,
                                  degree: item.candidate.degree,
                                  interviewer: item.candidate.interviewer,
                                  recruiter: item.candidate.recruiter,
                                  availability: item.candidate.availability,
                                  expectedSalary: item.candidate.expectedSalary,
                                  proposedSalary: item.candidate.proposedSalary,
                                  summary: item.candidate.summary,
                                  elevation: item.candidate.elevation,
                                  stage: item.candidate.stage,
                                  onDelete: item.deleteCandidate,
                                  isRefused: item.candidate.isRefused,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.more_vert),
                        )
                      ],
                    ),
                  ),
                  Text(item.candidate.role),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingBar(
                        filledIcon: Icons.star,
                        emptyIcon: Icons.star_border,
                        initialRating: item.candidate.elevation!,
                        onRatingChanged: (value) {
                          setState(() {
                            item.candidate.elevation = value;
                          });
                        },
                        maxRating: 3,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.attachment),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
    throw UnimplementedError();
  }

}

List<CandidateInf> getCandidatesByStageAndRole(int stage, String? role) {
  if (role == null) {
    return candidates.where((candidate) => candidate.stage == stage).toList();
  } else {
    return candidates.where((candidate) => candidate.stage == stage && candidate.role == role).toList();
  }
}

class CandidateItem extends AppFlowyGroupItem {
  final CandidateInf candidate;
  final VoidCallback onDelete;

  CandidateItem(this.candidate, {required this.onDelete});

  @override
  String get id => candidate.name;

  void deleteCandidate() {
    onDelete();
  }
}
