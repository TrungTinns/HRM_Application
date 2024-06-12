import 'package:flutter/material.dart';
import 'package:hrm_application/widgets/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class filter extends StatefulWidget {
  final List<String> titles;
  final List<IconData> icons;
  final List<Color> iconColors;
  final List<List<String>> options;
  final List<List<VoidCallback>> navigators;

  filter({
    required this.titles,
    required this.icons,
    required this.iconColors,
    required this.options,
    required this.navigators,
  });

  @override
  _filterState createState() => _filterState();
}

class _filterState extends State<filter> {
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
        width: size.width * 12, 
        left: offset.dx - (size.width * 11),
        top: offset.dy + size.height + 8,
        child: Material(
          color: snackBarColor,
          elevation: 4.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(widget.titles.length, (index) {
              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildColumn(
                    context,
                    widget.titles[index],
                    widget.icons[index],
                    widget.options[index],
                    widget.iconColors[index],
                    widget.navigators[index],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  List<PopupMenuEntry<String>> _buildColumn(BuildContext context, String title, IconData icon, List<String> options, Color iconColor, List<VoidCallback> navigators) {
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
    entries.addAll(
      options.asMap().entries.map((entry) {
        int idx = entry.key;
        String option = entry.value;
        return PopupMenuItem<String>(
          value: option,
          child: ListTile(
            title: Text(option, style: TextStyle(color: textColor)),
            onTap: () {
              navigators[idx]();
              _closeDropdown();
            },
          ),
        );
      }).toList(),
    );
    return entries;
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
