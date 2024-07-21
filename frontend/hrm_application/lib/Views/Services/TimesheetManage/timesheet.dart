import 'package:flutter/material.dart';
import 'package:hrm_application/Component/Appbar/custom_title_appbar.dart';
import 'package:hrm_application/Component/Configuration/configuration.dart';
import 'package:hrm_application/Component/FilterSearch/filter_search.dart';
import 'package:hrm_application/Component/Search/searchBox.dart';
import 'package:hrm_application/Views/Home/home.dart';
import 'package:hrm_application/Widgets/colors.dart';
import 'package:intl/intl.dart';

class TimeSheet extends StatefulWidget {
  @override
  _TimeSheetState createState() => _TimeSheetState();
}

class _TimeSheetState extends State<TimeSheet> {
  String pageName = 'Attendances';
  TextEditingController nameController= TextEditingController();
  String? activeDropdown;
  bool showCheckinForm = false;
  DateTime currentMonth = DateTime.now();
  List<String> employees = ['hậu', 'minh tiến', 'nrgtinns'];
  Map<String, List<AttendanceData>> attendance = {};

  void setActiveDropdown(String? dropdown) {
    setState(() {
      activeDropdown = dropdown;
    });
  }

  void toggleCheckinForm() {
    if (showCheckinForm) {
      if(nameController.text.isEmpty) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Incomplete Form'),
              content: const Text('Information is missing.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        setState(() {
          nameController.clear();
        });
      }
    } else {
      setState(() {
        showCheckinForm = true;
      });
    }
  }

  void clearCheckinForm() {
    setState(() {
      showCheckinForm = false;
    });
  }

  // void deleteRecord(String name) {
  //   setState(() {
  //     departments.removeWhere((department) => department.department == department);
  //   });
  // }

  // void handleUpdate(DepartmentInf updatedDepartment) {
  //   setState(() {
  //     final index = departments.indexWhere((dpm) => dpm.department == updatedDepartment.department);
  //     if (index != -1) {
  //       departments[index] = updatedDepartment;
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
    initializeAttendance();
  }

  void initializeAttendance() {
    for (var employee in employees) {
      attendance[employee] = List.generate(31, (index) => AttendanceData());
    }
  }

  void changeMonth(int monthsToAdd) {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + monthsToAdd);
      initializeAttendance();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomTitleAppbar(
          ctx: context,
          service: 'Attendances',
          titles: const ['Overview', 'Kiosk Mode'],
          options: const [
            ['Attendance', 'Time Off'],
            []
          ],
          optionNavigations: [
            [
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => TimeSheet())),
              // () => Navigator.push(
              //     context, MaterialPageRoute(builder: (ctx) => TimeOff())),
            ],
            [ 
              // () => Navigator.push(
              //     context, MaterialPageRoute(builder: (ctx) => Department())),
            ],
          ],
          activeDropdowns: const ['Employees', 'Reporting'],
          setActiveDropdown: (dropdown) {
          }, 
          config: configuration(
            isActive: activeDropdown == 'Configuration',
            onOpen: () => setActiveDropdown('Configuration'),
            onClose: () => setActiveDropdown(null),
            titles: const ['Setting', 'Employee', 'Recruitment'],
            options: const [
              ['Setting', 'Activity Plan'],
              ['Departments', 'Work Locations', 'Working Schedules', 'Departure Reasons', 'Skill Types'],
              ['Job Positions', 'Employment Types']
            ],
            navigators: [
              [
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
              ],
              [
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
              ],
              [
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
              ],
            ],
          )
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    toggleCheckinForm();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: textColor,
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text('New', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      pageName,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    IconButton(
                      icon: const Icon(Icons.upload),
                      color: Colors.white,
                      onPressed: () {},
                      tooltip: "Import records",
                    ),
                    if (showCheckinForm)
                      IconButton(
                        icon: const Icon(Icons.clear),
                        color: Colors.white,
                        iconSize: 24,
                        tooltip: "Discard all changes",
                        onPressed: () {
                          clearCheckinForm();
                        },
                    ),
                  ],
                ),
              ),
              const Spacer(),
              if (!showCheckinForm)
                searchBoxWithFilterTable(context, 'Search...', filter(
                  titles: const ['Filter', 'Group By', 'Favorites'],
                  icons: const [Icons.filter_alt, Icons.groups, Icons.star_rounded],
                  iconColors: const [primaryColor, Colors.greenAccent, Colors.yellow],
                  options: const [
                    ['My Team', 'My Department', 'Newly Hired', 'Achieved'],
                    ['Manager', 'Department', 'Job', 'Skill', 'Start Date', 'Tags'],
                    ['Save Current Search']
                  ],
                  navigators: [
                    [
                      () => Navigator.pushNamed(context, '/my_team'), 
                      () => Navigator.pushNamed(context, '/my_department'), 
                      () => Navigator.pushNamed(context, '/newly_hired'), 
                      () => Navigator.pushNamed(context, '/achieved')],
                    [
                      () => Navigator.pushNamed(context, '/manager'), 
                      () => Navigator.pushNamed(context, '/department'), 
                      () => Navigator.pushNamed(context, '/job'), 
                      () => Navigator.pushNamed(context, '/skill'), 
                      () => Navigator.pushNamed(context, '/start_date'), 
                      () => Navigator.pushNamed(context, '/tags')],
                    [() => print('Save Current Search')],
                  ],)
                ),
              const Spacer(),
            ],
          ),
        ),
        backgroundColor: snackBarColor,
      ),
      backgroundColor: snackBarColor,
      body: Column(
        children: [
          buildMonthController(),
          buildCalendarHeader(),
          Expanded(child: buildCalendarBody()),
        ],
      ),
    );
  }

  Widget buildMonthController() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          color: dropdownColor,
          alignment: Alignment.center,
          child: IconButton(
            icon: Icon(Icons.chevron_left, size: 30, color: textColor),
            onPressed: () => changeMonth(-1),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          width: 160,
          height: 40,
          color: dropdownColor,
          alignment: Alignment.center,
          child: Text(DateFormat('MMMM yyyy').format(currentMonth), style: TextStyle(fontSize: 20, color: textColor))),
        Container(
          width: 40,
          height: 40,
          color: dropdownColor,
          alignment: Alignment.center,
          child: IconButton(
            icon: Icon(Icons.chevron_right, size: 30, color: textColor),
            onPressed: () => changeMonth(1),
          ),
        ),
      ],
    );
  }

  Widget buildCalendarHeader() {
    return Row(
      children: [
        Container(width: 100, child: Text('Employee', style: TextStyle(fontSize: 20, color: textColor))),
        ...List.generate(
          getDaysInMonth(currentMonth),
          (index) => Expanded(child: Text('${index + 1}', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: textColor))),
        ),
      ],
    );
  }

  Widget buildCalendarBody() {
    return ListView.builder(
      itemCount: employees.length,
      itemBuilder: (context, index) {
        String employee = employees[index];
        return Row(
          children: [
            Container(width: 100, child: Text(employee, style: TextStyle(fontSize: 20, color: textColor))),
            ...List.generate(
              getDaysInMonth(currentMonth),
              (dayIndex) => Expanded(
                child: GestureDetector(
                  onTap: () => _showAttendanceForm(employee, dayIndex),
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: attendance[employee]![dayIndex].isPresent ? Colors.green : null,
                    ),
                    child: Icon(
                      attendance[employee]![dayIndex].isPresent ? Icons.check : Icons.add,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  int getDaysInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }

  void _showAttendanceForm(String employee, int dayIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        AttendanceData data = attendance[employee]![dayIndex];
        return AlertDialog(
          title: Text('Attendance Form'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Employee: $employee'),
                Text('Date: ${DateFormat('dd/MM/yyyy').format(DateTime(currentMonth.year, currentMonth.month, dayIndex + 1))}'),
                SizedBox(height: 10),
                _buildTimeField('Check-in', data.checkIn, (time) => data.checkIn = time),
                _buildTimeField('Check-out', data.checkOut, (time) => data.checkOut = time),
                TextField(
                  decoration: InputDecoration(labelText: 'Overtime (hours)'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => data.overtime = double.tryParse(value) ?? 0,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  data.isPresent = true;
                  attendance[employee]![dayIndex] = data;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildTimeField(String label, TimeOfDay? initialTime, Function(TimeOfDay) onChanged) {
    return Row(
      children: [
        Text('$label: '),
        TextButton(
          child: Text(initialTime?.format(context) ?? 'Select time'),
          onPressed: () async {
            TimeOfDay? time = await showTimePicker(
              context: context,
              initialTime: initialTime ?? TimeOfDay.now(),
            );
            if (time != null) {
              onChanged(time);
            }
          },
        ),
      ],
    );
  }
}

class AttendanceData {
  bool isPresent = false;
  TimeOfDay? checkIn;
  TimeOfDay? checkOut;
  double overtime = 0;

  Duration get workDuration {
    if (checkIn == null || checkOut == null) return Duration.zero;
    return Duration(hours: checkOut!.hour - checkIn!.hour, minutes: checkOut!.minute - checkIn!.minute);
  }
}