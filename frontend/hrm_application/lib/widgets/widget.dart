import 'package:flutter/material.dart' hide VoidCallback;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:hrm_application/widgets/colors.dart';
import 'package:google_fonts/google_fonts.dart';

Widget appIcon(BuildContext context) {
  return RichText(
    text: TextSpan(
      children: <TextSpan>[
        TextSpan(
          text: 'HRM ',
          style: GoogleFonts.rockSalt(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: secondaryColor,
          ),
        ),
        TextSpan(
          text: 'app',
          style: GoogleFonts.dancingScript(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 107, 188, 255),
          ),
        ),
      ],
    ),
  );
}

Widget searchBoxWithFilterTable(BuildContext context, String hintText, Widget filter) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Stack(
      children: [
        Container(
          height: 40.0,
          width: 500.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: termTextColor),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(color: textColor),
                    prefixIcon: Icon(Icons.search, color: textColor),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: termTextColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(5.0),
                bottomRight: Radius.circular(5.0),
              ),
            ),
            child: filter,
          ),
        ),
      ],
    ),
  );
}

Widget searchBox(BuildContext context, String hintText) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 40.0,
      width: 500.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: termTextColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14.0),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

AppBar customAppBar(BuildContext context) {
  return AppBar(
    title: appIcon(context),
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black87),
    centerTitle: true,
    elevation: 0.0,
  );
}

Widget customButton(BuildContext context, {IconData? icon, required Widget navigateTo, required String text}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => navigateTo),
      );
    },
    child: Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
            color: textColor,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: textColor,
            ),
          ),
        ],
      ),
    ),
  );
}


class CustomDropdownButton extends StatefulWidget {
  final String title;
  final List<String> options;
  final void Function(String) onSelect;
  final bool isActive;
  final VoidCallback onOpen;
  final VoidCallback onClose;

  CustomDropdownButton({
    required this.title,
    required this.options,
    required this.onSelect,
    required this.isActive,
    required this.onOpen,
    required this.onClose,
  });

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
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
        width: size.width,
        left: offset.dx,
        top: offset.dy + size.height,
        child: Material(
          color: snackBarColor,
          elevation: 4.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.options.map((String option) {
              return InkWell(
                onTap: () {
                  widget.onSelect(option);
                  _closeDropdown();
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(option, style: TextStyle(color: termTextColor, fontSize: 14)), 
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
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
          child: Text(
            widget.title,
            style: TextStyle(color: Colors.white, fontSize: 16), 
          ),
        ),
      ),
    );
  }
}