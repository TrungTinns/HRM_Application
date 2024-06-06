// Widget cho khung nút dropdown
import 'package:flutter/material.dart';
import 'package:hrm_application/widgets/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class filterEmployee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<PopupMenuEntry<String>>(
      icon: Icon(Icons.filter_list),
      itemBuilder: (BuildContext context) {
        return [
          ..._buildColumn(context, [
            'My Team',
            'My Department',
            'Newly Hired',
            'Achieved',
          ]),
          ..._buildColumn(context, [
            'Manager',
            'Department',
            'Job',
            'Skill',
            'Start Date',
            'Tags',
          ]),
          ..._buildColumn(context, [
            'Save Current Search',
          ]),
        ];
      },
    );
  }

  List<PopupMenuEntry<PopupMenuEntry<String>>> _buildColumn(BuildContext context, List<String> options) {
    List<PopupMenuEntry<PopupMenuEntry<String>>> entries = [];
    for (String option in options) {
      entries.add(
        PopupMenuItem<PopupMenuEntry<String>>(
          value: PopupMenuItem<String>(
            value: option,
            child: ListTile(
              title: Text(option),
              onTap: () {
                _handleSelection(context, option);
                Navigator.pop(context); // Đóng menu dropdown
              },
            ),
          ), child: null,
        ),
      );
    }
    return entries;
  }

  void _handleSelection(BuildContext context, String option) {
    // Xử lý khi lựa chọn được thực hiện
    switch (option) {
      case 'My Team':
        Navigator.pushNamed(context, '/my_team');
        break;
      case 'My Department':
        Navigator.pushNamed(context, '/my_department');
        break;
      case 'Newly Hired':
        Navigator.pushNamed(context, '/newly_hired');
        break;
      case 'Achieved':
        Navigator.pushNamed(context, '/achieved');
        break;
      case 'Manager':
        Navigator.pushNamed(context, '/manager');
        break;
      case 'Department':
        Navigator.pushNamed(context, '/department');
        break;
      case 'Job':
        Navigator.pushNamed(context, '/job');
        break;
      case 'Skill':
        Navigator.pushNamed(context, '/skill');
        break;
      case 'Start Date':
        Navigator.pushNamed(context, '/start_date');
        break;
      case 'Tags':
        Navigator.pushNamed(context, '/tags');
        break;
      case 'Save Current Search':
        // Thực hiện lưu tìm kiếm hiện tại
        break;
      default:
        // Xử lý cho trường hợp không xác định
        break;
    }
  }
}