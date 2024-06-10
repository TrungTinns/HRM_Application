import 'package:flutter/material.dart';
import 'package:hrm_application/widgets/colors.dart';

class ContractForm extends StatefulWidget {
  @override
  _ContractFormState createState() => _ContractFormState();
}

class _ContractFormState extends State<ContractForm> with SingleTickerProviderStateMixin {
  TextEditingController nameController = TextEditingController();
  TextEditingController jobPositionController = TextEditingController();
  TextEditingController workMobileController = TextEditingController();
  TextEditingController workPhoneController = TextEditingController();
  TextEditingController workEmailController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController managerController = TextEditingController();

  TabController? tabController;

  bool _isSidebarOpen = true;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    nameController.dispose();
    jobPositionController.dispose();
    workMobileController.dispose();
    workPhoneController.dispose();
    workEmailController.dispose();
    departmentController.dispose();
    positionController.dispose();
    managerController.dispose();
    tabController?.dispose();
    super.dispose();
  }

  Future<void> _selectImage() async {
    
  }

  Widget buildTextFieldRow(String label, TextEditingController controller) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(color: textColor),
          ),
        ),
        Expanded(
          child: TextField(
            controller: controller,
            style: TextStyle(color: textColor),
            decoration: InputDecoration(
              filled: true,
              fillColor: snackBarColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDropdownRow(String label, TextEditingController controller, List<String> items) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(color: textColor),
          ),
        ),
        Expanded(
          child: DropdownButtonFormField<String>(
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(color: Colors.black)),
              );
            }).toList(),
            onChanged: (value) {
              controller.text = value!;
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: snackBarColor,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: snackBarColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: nameController,
                        style: TextStyle(color: textColor, fontSize: 30.0),
                        decoration: InputDecoration(
                          hintText: "Contract Reference",
                          hintStyle: TextStyle(color: termTextColor, fontSize: 30.0), 
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      buildDropdownRow('Employee', departmentController, ['Department 1', 'Department 2', 'Department 3']),
                      SizedBox(height: 10),
                      buildDropdownRow('Contract Start Date', departmentController, ['Department 1', 'Department 2', 'Department 3']),
                      SizedBox(height: 10),
                      buildDropdownRow('Contract End Date', departmentController, ['Department 1', 'Department 2', 'Department 3']),
                      SizedBox(height: 10),
                      buildDropdownRow('Working Schedule', departmentController, ['Department 1', 'Department 2', 'Department 3']),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    children: [
                      buildDropdownRow('Salary Structure Type', departmentController, ['Department 1', 'Department 2', 'Department 3']),
                      SizedBox(height: 10),
                      buildDropdownRow('Department', departmentController, ['Department 1', 'Department 2', 'Department 3']),
                      SizedBox(height: 10),
                      buildDropdownRow('Job Position', departmentController, ['Department 1', 'Department 2', 'Department 3']),
                      SizedBox(height: 10),
                      buildDropdownRow('Contract Type', departmentController, ['Department 1', 'Department 2', 'Department 3']),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TabBar(
              controller: tabController,
              tabs: [
                Tab(text: 'Salary Information'),
                Tab(text: 'Contract Details'),
              ],
            ),
            Container(
              height: 200, 
              child: TabBarView(
                controller: tabController,
                children: [
                  Center(child: Text('Content for Tab 1')),
                  Center(child: Text('Content for Tab 2')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
