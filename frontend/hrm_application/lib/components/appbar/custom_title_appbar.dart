import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrm_application/views/home/home.dart';
import 'package:hrm_application/widgets/colors.dart';

class CustomTitleAppbar extends StatelessWidget {
  final BuildContext ctx;
  final String service;
  final List<String> titles;
  final List<List<String>> options;
  final List<List<Function>> optionNavigations;
  final List<String> activeDropdowns;
  final Function(String) setActiveDropdown;
  final Widget config;

  CustomTitleAppbar({
    required this.ctx,
    required this.service,
    required this.titles,
    required this.options,
    required this.optionNavigations,
    required this.activeDropdowns,
    required this.setActiveDropdown,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: textColor,
          iconSize: 25,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
          },
        ),
        Text(
          service,
          style: GoogleFonts.philosopher(
            fontSize: 25,
            color: secondaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 10),
        for (int i = 0; i < titles.length; i++) ...[
          CustomDropdownButton(
            title: titles[i],
            options: options[i],
            onSelect: (option) {
              setActiveDropdown(titles[i]);
              int optionIndex = options[i].indexOf(option);
              optionNavigations[i][optionIndex]();
            },
            isActive: activeDropdowns.contains(titles[i]),
            onOpen: () => setActiveDropdown(titles[i]),
            onClose: () => setActiveDropdown(''),
          ),
          SizedBox(width: 10),
        ],
        config,  
        Spacer(),
        IconButton(
          icon: Icon(Icons.wechat),
          color: textColor,
          iconSize: 30,
          onPressed: () {
          
          },
        ),
        IconButton(
          icon: Icon(Icons.settings),
          color: textColor,
          iconSize: 30,
          onPressed: () {
          
          },
        ),
      ],
    );
  }
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
                  width: size.width,
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