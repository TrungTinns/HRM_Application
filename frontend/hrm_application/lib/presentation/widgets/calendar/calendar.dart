import 'package:flutter/material.dart';
import 'package:hrm_application/core/utils/theme/colors.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  final CalendarFormat calendarFormat;

  Calendar({required this.calendarFormat});

  final DateTime _selectedDate = DateTime.now();
  final Map<DateTime, List<dynamic>> _events = {};

  void _onDaySelected(BuildContext context, DateTime day, List<dynamic> events) {

  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime(2000),
      lastDay: DateTime(2100),
      focusedDay: _selectedDate,
      calendarFormat: calendarFormat,
      onFormatChanged: (format) {
      },
      eventLoader: (day) {
        return _events[day] ?? [];
      },
      onDaySelected: (selectedDay, focusedDay) {
        _onDaySelected(context, selectedDay, _events[selectedDay] ?? []);
      },
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Color.fromARGB(255, 209, 58, 12),
          shape: BoxShape.circle,
        ),
        todayTextStyle: TextStyle(color: textColor),
        defaultTextStyle: TextStyle(color: textColor),
        markerDecoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
      ),
      headerStyle: const HeaderStyle(
        titleTextStyle: TextStyle(
          fontSize: 20,
          color: textColor,
        ),
        leftChevronIcon: Icon(
          Icons.chevron_left,
          color: textColor,
        ),
        rightChevronIcon: Icon(
          Icons.chevron_right,
          color: textColor,
        ),
      ),
    );
  }
}

class CalendarFrame extends StatelessWidget {
  const CalendarFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
      
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9, 
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey), 
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Calendar(calendarFormat: CalendarFormat.week),
            Positioned(
              bottom: 40,
              child: IconButton(
                iconSize: 100,
                icon: const Icon(Icons.calendar_month),
                color: textColor,
                onPressed: () {
            
                },
              ),
            ),
            const Positioned(
              bottom: 20,
              child: Text(
                    'Work Harder!!!', 
                    style: TextStyle(
                      fontSize: 20,
                      color: textColor
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

