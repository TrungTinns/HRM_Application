import 'package:flutter/material.dart';
import 'package:hrm_application/views/home/home.dart';
import 'package:hrm_application/widgets/colors.dart';

class configuration extends StatefulWidget {
  final bool isActive;
  final VoidCallback onOpen;
  final VoidCallback onClose;
  final List<String> titles;
  final List<List<String>> options;
  final List<List<VoidCallback>> navigators;

  configuration({
    required this.isActive,
    required this.onOpen,
    required this.onClose,
    required this.titles,
    required this.options,
    required this.navigators,
  });

  @override
  _configurationState createState() => _configurationState();
}

class _configurationState extends State<configuration> {
  GlobalKey _key = GlobalKey();
  OverlayEntry? _overlayEntry;
  bool _isHovered = false;
  bool _isOpen = false;

  void _toggleDropdown() {
    if (_isOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    RenderBox renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = _createOverlayEntry(size, offset);
    Overlay.of(context)?.insert(_overlayEntry!);
    widget.onOpen();
    _isOpen = true;
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    widget.onClose();
    _isOpen = false;
  }

  OverlayEntry _createOverlayEntry(Size size, Offset offset) {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width*4,
        left: offset.dx,
        top: offset.dy + size.height,
        child: Material(
          color: snackBarColor,
          elevation: 4.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(widget.titles.length, (index) {
              return Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildColumn(
                    context,
                    widget.titles[index],
                    widget.options[index],
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

  List<PopupMenuEntry<String>> _buildColumn(BuildContext context, String title, List<String> options,List<VoidCallback> navigators,) {
    List<PopupMenuEntry<String>> entries = [];
    entries.add(
      PopupMenuItem<String>(
        enabled: false,
        child: Column(
          children: [
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
    entries.addAll(
      options.map((String option) {
        return PopupMenuItem<String>(
          value: option,
          child: ListTile(
            title: Text(option, style: TextStyle(color: termTextColor)),
            onTap: () {
              int index = options.indexOf(option);
              if (index != -1) {
                navigators[index]();
              }
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
          setState(() {
            _isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            _isHovered = false;
          });
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _isHovered ? Colors.grey : snackBarColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Text(
                'Configuration',
                style: TextStyle(color: textColor, fontSize: 16),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
