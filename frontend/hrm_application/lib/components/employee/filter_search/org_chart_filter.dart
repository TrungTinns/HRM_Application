import 'package:flutter/material.dart';
import 'package:hrm_application/widgets/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class filterOrgChart extends StatefulWidget {
  @override
  _FilterOrgChartState createState() => _FilterOrgChartState();
}

class _FilterOrgChartState extends State<filterOrgChart> {
  final GlobalKey _key = GlobalKey();
  OverlayEntry? _overlayEntry;
  bool _isDropdownOpen = false;

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    final renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = _createOverlayEntry(size, offset);
    Overlay.of(context)?.insert(_overlayEntry!);
    setState(() {
      _isDropdownOpen = true;
    });
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isDropdownOpen = false;
    });
  }

  OverlayEntry _createOverlayEntry(Size size, Offset offset) {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width*4, 
        left: offset.dx - (size.width*3),
        top: offset.dy + size.height + 8,
        child: Material(
          color: snackBarColor,
          elevation: 4.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildColumn(
                    context,
                    'Filter',
                    Icons.filter_alt,
                    ['My Team', 'My Department', 'Newly Hired', 'Achieved'],
                    primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<PopupMenuEntry<String>> _buildColumn(BuildContext context, String title, IconData icon, List<String> options, Color iconColor) {
    List<PopupMenuEntry<String>> entries = [];
    entries.add(
      PopupMenuItem<String>(
        enabled: false,
        child: Row(
          children: [
            Icon(icon, color: iconColor),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
    
    // Add the options
    entries.addAll(
      options.map((String option) {
        return PopupMenuItem<String>(
          value: option,
          child: ListTile(
            title: Text(option, style: TextStyle(color: textColor)),
            onTap: () {
              _handleSelection(context, option);
              _closeDropdown();
            },
          ),
        );
      }).toList(),
    );

    return entries;
  }


  void _handleSelection(BuildContext context, String option) {
    // Handle selection
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
      default:
        
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _key,
      onTap: _toggleDropdown,
      child: MouseRegion(
        onEnter: (_) {
          setState(() {});
        },
        onExit: (_) {
          setState(() {});
        },
        child: Icon(_isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down, color: textColor,),
      ),
    );
  }
}
