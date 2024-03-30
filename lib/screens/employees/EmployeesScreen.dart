import 'package:flutter/material.dart';
import 'package:flutter_ui/model/EmployeeModel.dart';
import 'package:flutter_ui/screens/employees/EmployeeCreateScreen.dart';
import 'package:get/get.dart';

import '../../widget/widgets.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen();

  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  List<EmployeeModel> items = [];

  @override
  void initState() {
    super.initState();
    myInit();
  }

  myInit() async {
    items = await EmployeeModel.get_items();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Employees"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Get.to(() => EmployeeCreateScreen(EmployeeModel()));
            myInit();
          },
          child: const Icon(Icons.add),
        ),
        body: items.isEmpty
            ? emptyListWidget("No Financial Periods found.", "Refresh", () {
                myInit();
              })
            : RefreshIndicator(
                onRefresh: () async {
                  myInit();
                },
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(items[index].name),
                      onTap: () {},
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          await Get.to(
                              () => EmployeeCreateScreen(items[index]));
                          myInit();
                        },
                      ),
                    );
                  },
                ),
              ));
  }
}
