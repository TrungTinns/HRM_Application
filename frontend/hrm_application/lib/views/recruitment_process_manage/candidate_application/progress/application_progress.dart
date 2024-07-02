import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_application/views/recruitment_process_manage/candidate_application/cadidate_inf.dart';
import 'package:hrm_application/views/recruitment_process_manage/candidate_application/detail/candidate_detail.dart';
import 'package:hrm_application/widgets/colors.dart';

class ProgressBoard extends StatefulWidget {
  const ProgressBoard({Key? key}) : super(key: key);

  @override
  State<ProgressBoard> createState() => _ProgressBoardState();
}

class _ProgressBoardState extends State<ProgressBoard> {
  final AppFlowyBoardController controller = AppFlowyBoardController(
    onMoveGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint('Move item from $fromIndex to $toIndex');
    },
    onMoveGroupItem: (groupId, fromIndex, toIndex) {
      debugPrint('Move $groupId:$fromIndex to $groupId:$toIndex');
    },
    onMoveGroupItemToGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint('Move $fromGroupId:$fromIndex to $toGroupId:$toIndex');
    },
  );

  late AppFlowyBoardScrollController boardController;

  @override
  void initState() {
    super.initState();
    boardController = AppFlowyBoardScrollController();
    initializeGroups();
  }

  void initializeGroups() {
    controller.clear(); 
    final stages = CandidateInf.defaultSteps;
    for (var i = 0; i < stages.length; i++) {
      String stageName = stages[i];
      List<CandidateItem> items = candidates
          .where((candidate) => candidate.progress == i + 1)
          .map((candidate) => CandidateItem(candidate))
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
    final config = AppFlowyBoardConfig(
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
                controller: TextEditingController()
                  ..text = columnData.headerData.groupName,
                onSubmitted: (val) {
                  controller
                      .getGroupController(columnData.headerData.groupId)!
                      .updateGroupName(val);
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
        config: config);
  }

  Widget _buildCard(AppFlowyGroupItem item) {
    if (item is CandidateItem) {
      return Align(
        alignment: Alignment.centerLeft,
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
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (ctx) =>
                              CandidateDetail(
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
                                progress: item.candidate.progress,
                              )
                            ));
                          },
                          icon: const Icon(Icons.more_vert)
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
                          item.candidate.elevation = value;
                        },
                        maxRating: 3,
                      ),
                      IconButton(
                        onPressed: (){
                      
                        },
                        icon: const Icon(Icons.attachment),
                      ),
                    ]
                  )
                ],
          ),
        ),
      );
    }
    throw UnimplementedError();
  }
}

class CandidateItem extends AppFlowyGroupItem {
  final CandidateInf candidate;

  CandidateItem(this.candidate);

  @override
  String get id => candidate.name;
}