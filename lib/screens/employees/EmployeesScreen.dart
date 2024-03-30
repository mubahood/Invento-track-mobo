import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/FinancialPeriodModel.dart';
import '../../widget/widgets.dart';
import 'FinancialPeriodCreateScreen.dart';

class FinancialPeriodsScreen extends StatefulWidget {
  const FinancialPeriodsScreen();

  @override
  State<FinancialPeriodsScreen> createState() => _FinancialPeriodsScreenState();
}

class _FinancialPeriodsScreenState extends State<FinancialPeriodsScreen> {
  List<FinancialPeriodModel> items = [];

  @override
  void initState() {
    super.initState();
    myInit();
  }

  myInit() async {
    items = await FinancialPeriodModel.get_items();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Financial Periods"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => FinancialPeriodCreateScreen(FinancialPeriodModel()));
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
                        onPressed: () {
                          Get.to(
                              () => FinancialPeriodCreateScreen(items[index]));
                        },
                      ),
                    );
                  },
                ),
              ));
  }
}
