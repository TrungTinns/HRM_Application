import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_application/Views/Services/PayrollManage/Batch/batch.dart';
import 'package:hrm_application/Views/Services/PayrollManage/Batch/batches_inf.dart';
import 'package:hrm_application/widgets/colors.dart';
import 'package:progress_stepper/progress_stepper.dart';

class BatchForm extends StatefulWidget {
  @override
  _BatchFormState createState() => _BatchFormState();
}

class _BatchFormState extends State<BatchForm> with SingleTickerProviderStateMixin {
  TextEditingController batchController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  int currentStep = 1;
  bool isRefFilled = false;

  @override
  void initState() {
    super.initState();
    batchController.addListener(() {
      setState(() {
        isRefFilled = batchController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    batchController.dispose();
    statusController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        controller.text = picked.toString().substring(0, 10);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: snackBarColor,
      body: Padding(
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
                    });
                  },
                  bluntHead: true,
                  bluntTail: true,
                  color: Colors.transparent,
                  progressColor: Colors.green,
                  stepCount: 4,
                  labels: BatchData.defaultStatus,
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
                  child: GestureDetector(
                    onTap: () {
                      _selectDate(startDateController);
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        controller: startDateController,
                        style: const TextStyle(color: textColor),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: snackBarColor,
                        ),
                      ),
                    ),
                  ),
                ),
                const Text('-', style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 20)),
                Container(
                  width: 120,
                  margin: const EdgeInsets.only(left: 8),
                  child: GestureDetector(
                    onTap: () {
                      _selectDate(endDateController);
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        controller: endDateController,
                        style: const TextStyle(color: textColor),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: snackBarColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: isRefFilled
          ? FloatingActionButton(
            onPressed: () {
              final newBatch = BatchData(
                batch: batchController.text,
                status: statusController.text,
                startDate: DateTime.parse(startDateController.text),
                endDate: DateTime.parse(endDateController.text),
              );
              setState(() {
                batches.add(newBatch);
              });
              Navigator.push(context, MaterialPageRoute(builder: (ctx) => BatchManage()));
            },
            child: const Icon(Icons.create),
          )
          : null,
    );
  }
}