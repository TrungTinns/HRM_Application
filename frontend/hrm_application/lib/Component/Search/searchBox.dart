import 'package:flutter/material.dart';
import 'package:hrm_application/widgets/colors.dart';

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
                  style: const TextStyle(color: textColor, fontSize: 16.0),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: const TextStyle(color: termTextColor),
                    prefixIcon: const Icon(Icons.search, color: textColor),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          child: Container(
            width: 40.0,
            height: 40.0,
            decoration: const BoxDecoration(
              color: termTextColor,
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
                prefixIcon: const Icon(Icons.search),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}