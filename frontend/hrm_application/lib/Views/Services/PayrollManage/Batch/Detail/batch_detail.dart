import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_application/Component/Appbar/custom_title_appbar.dart';
import 'package:hrm_application/Component/Configuration/configuration.dart';
import 'package:hrm_application/Views/Home/home.dart';
import 'package:hrm_application/Views/Services/EmployeeManage/Contract/contracts.dart';
import 'package:hrm_application/Views/Services/PayrollManage/Batch/Form/batch_form.dart';
import 'package:hrm_application/Views/Services/PayrollManage/Batch/batch.dart';
import 'package:hrm_application/Views/Services/PayrollManage/Batch/batches_inf.dart';
import 'package:hrm_application/Views/Services/PayrollManage/Dashboard/payroll_manage.dart';
import 'package:hrm_application/widgets/colors.dart';
import 'package:progress_stepper/progress_stepper.dart';

class BatchDetail extends StatefulWidget {
  final String batch;
  final String startDate;
  final String endDate;
  final String status;
  final VoidCallback onDelete;
  final ValueChanged<BatchData> onUpdate;

  BatchDetail({
    required this.startDate,
    required this.endDate,
    required this.batch,
    required this.status,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  _BatchDetailState createState() => _BatchDetailState();
}

class _BatchDetailState extends State<BatchDetail> with SingleTickerProviderStateMixin {
  late TextEditingController batchController;
  late TextEditingController statusController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  String pageName = 'Payslip Batches';
  bool showBatchForm = false;
  String? activeDropdown;
  bool isChanged = false;
  late int currentStep;

  void setActiveDropdown(String? dropdown) {
    setState(() {
      activeDropdown = dropdown;
    });
  }

  void toggleBatchForm() {
    if (showBatchForm) {
      if (batchController.text.isEmpty) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Incomplete Form'),
              content: const Text('Name field is missing.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        setState(() {
          batchController.clear();
        });
      }
    } else {
      setState(() {
        showBatchForm = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    batchController = TextEditingController(text: widget.batch);
    startDateController = TextEditingController(text: formatDate(DateTime.parse(widget.startDate)));
    endDateController = TextEditingController(text: formatDate(DateTime.parse(widget.endDate)));
    statusController = TextEditingController(text: widget.status);
    currentStep = BatchData.defaultStatus.indexOf(widget.status)+1;
  }

  String formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    batchController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    statusController.dispose();
    super.dispose();
  }

  void clearBatchForm() {
    setState(() {
      showBatchForm = false;
      Navigator.push(context, MaterialPageRoute(builder: (ctx) => BatchManage()));
    });
  }

  void deleteBatch(String batch){
    setState(() {
      batches.removeWhere((batch) => batch.batch == batch );
    });
  }

  void saveChanges() {
    final updatedBatch= BatchData(
      batch: batchController.text,
      startDate: DateTime.parse("${startDateController.text} 00:00:00"),
      endDate: DateTime.parse("${endDateController.text} 00:00:00"),
      status: BatchData.defaultStatus[currentStep-1],
    );
    widget.onUpdate(updatedBatch);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomTitleAppbar(
          ctx: context,
          service: 'Payroll',
          titles: const ['Dashboard', 'Contracts', 'Work Entries', 'Payslips', 'Reporting'],
          options: const [
            [],
            ['Contracts', 'Salary Attachments'],
            ['Work Entries', 'Time Off'],
            ['All Payslips', 'Batches'],
            ['By Job Positions', 'All Applications'],
            ['Recruitment Analysis', 'Source Analysis', 'Time In Stage Analysis', 'Team Performance']
          ],
          optionNavigations: [
            [ () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => PayrollManage())),
            ],
            [
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Contracts())),
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Home())),
            ],
            [
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Home())),
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Home())),
            ],
            [
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Home())),
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => BatchManage())),
            ],
            [
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Home())),
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Home())),
            ],
            [
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Home())),
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Home())),
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Home())),
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => Home())),
            ],
          ],
          activeDropdowns: const ['Applications', 'Reporting'],
          setActiveDropdown: (dropdown) {
            setState(() {
              activeDropdown = dropdown;
            });
          },
          config: configuration(
            isActive: activeDropdown == 'Configuration',
            onOpen: () => setActiveDropdown('Configuration'),
            onClose: () => setActiveDropdown(null),
            titles: const ['', 'Job Positions', 'Applications', 'Employees', 'Activities'],
            options: const [
              ['Setting'],
              ['Employment Types'],
              ['Refuse Reasons'],
              ['Departments', 'Skill Types'],
              ['Activities Types', 'Activity Plans'],
            ],
            navigators: [
              [
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
              ],
              [
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
              ],
              [
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
              ],
              [
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
              ],
              [
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
                () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())),
              ],
            ],
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (isChanged) {
                            saveChanges();
                          } else {
                            toggleBatchForm();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: textColor,
                          backgroundColor: primaryColor ,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          isChanged ? 'Save' : 'New',
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
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
                    IconButton(
                      icon: const Icon(Icons.clear),
                      color: Colors.white,
                      iconSize: 24,
                      tooltip: showBatchForm ? "Discard all changes" : "Delete this department",
                      onPressed: showBatchForm ? clearBatchForm : () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Do you want to delete this department?'),
                              content: const Text(''),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    widget.onDelete();
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: snackBarColor,
      ),
      backgroundColor: snackBarColor,
      body: showBatchForm
          ? BatchForm()
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Batch Name', style: TextStyle(color: textColor, fontSize: 20.0)),
                      TextField(
                        controller: batchController,
                        onChanged: (value) {
                          setState(() {
                            isChanged = true;
                          });
                        },
                        style: const TextStyle(color: textColor, fontSize: 30.0),
                        decoration: const InputDecoration(
                          hintText: "e.g. April 2024",
                          hintStyle: TextStyle(color: termTextColor, fontSize: 30.0),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                ProgressStepper(
                  width: 400,
                  height: 50,
                  padding: 1,
                  currentStep: currentStep,
                  onClick: (index) {
                      setState(() {
                        currentStep = index;
                        statusController.text = BatchData.defaultStatus[index-1];
                        isChanged = true;
                      });
                    },
                  bluntHead: true,
                  bluntTail: true,
                  color: Colors.transparent,
                  progressColor: Colors.green,
                  stepCount: 4,
                  labels: const <String>['New', 'Confirmed', 'Done', 'Paid'],
                  defaultTextStyle: const TextStyle(
                    fontSize: 16,
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                  selectedTextStyle: const TextStyle(
                    fontSize: 16,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 100,
                  child: Text(
                    'Period',
                    style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Container(
                  width: 120,
                  margin: const EdgeInsets.only(right: 8),
                  child: TextField(
                    controller: startDateController,
                    onChanged: (value) {
                      setState(() {
                        isChanged = true;
                      });
                    },
                    style: const TextStyle(color: textColor),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: snackBarColor,
                    ),
                  ),
                ),
                const Text('-', style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 20)),
                Container(
                  width: 120,
                  margin: const EdgeInsets.only(left: 8),
                  child: TextField(
                    controller: endDateController,
                    onChanged: (value) {
                      setState(() {
                        isChanged = true;
                      });
                    },
                    style: const TextStyle(color: textColor),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: snackBarColor,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}