import 'package:flutter/material.dart';
import 'package:flutter_ui/data/my_colors.dart';
import 'package:flutter_ui/model/Utils.dart';
import 'package:flutter_ui/screens/budget_management/budget/BudgetItemCategoriesScreen.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';

import '../../../model/BudgetProgramModel.dart';
import '../../../widget/widgets.dart';
import 'BudgetProgramCreateScreen.dart';

class BudgetProgramsScreen extends StatefulWidget {
  Map<String, dynamic> params = {};

  BudgetProgramsScreen(this.params);

  @override
  State<BudgetProgramsScreen> createState() => _BudgetProgramsScreenState();
}

class _BudgetProgramsScreenState extends State<BudgetProgramsScreen> {
  List<BudgetProgramModel> items = [];

  @override
  void initState() {
    super.initState();
    myInit();
  }

  bool isPicker = false;

  myInit() async {
    if (widget.params.isNotEmpty) {
      if (widget.params.containsKey('isPicker')) {
        if (widget.params['isPicker'] == true) {
          isPicker = true;
        }
      }
    }

    items = await BudgetProgramModel.get_items();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Budget programs"),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: MyColors.primary,
          onPressed: () async {
            await Get.to(() => BudgetProgramCreateScreen(BudgetProgramModel()));
            myInit();
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: items.isEmpty
            ? emptyListWidget("No Financial Periods found.", "Refresh", () {
                myInit();
              })
            : RefreshIndicator(
                onRefresh: () async {
                  myInit();
                },
                backgroundColor: MyColors.primary,
                color: Colors.white,
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(items[index].id.toString() +
                          ". " +
                          items[index].name),
                      onTap: () {
                        if (isPicker) {
                          Get.back(result: items[index]);
                          return;
                        }
                        Get.to(() => BudgetItemCategoriesScreen({
                              'program': items[index],
                            }));
                      },
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              FxText('TOTAL TARGET: '),
                              FxText.bodyMedium(
                                "UGX " +
                                    Utils.moneyFormat(
                                        items[index].budget_total),
                                fontWeight: 900,
                                color: MyColors.primary,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              FxText('TOTAL INVESTMENT: '),
                              FxText.bodyMedium(
                                "UGX " +
                                    Utils.moneyFormat(
                                        items[index].budget_spent),
                                fontWeight: 900,
                                color: MyColors.primary,
                              ),
                            ],
                          ),
                          Divider(
                            height: 1,
                          ),
                          Row(
                            children: [
                              FxText('UNCOVERED BUDGET: '),
                              FxText.bodyMedium(
                                "UGX " +
                                    Utils.moneyFormat(
                                        items[index].budget_balance),
                                fontWeight: 900,
                                color: MyColors.primary,
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: true
                          ? null
                          : IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: MyColors.primary,
                                size: 35,
                              ),
                              onPressed: () async {
                                await Get.to(() =>
                                    BudgetProgramCreateScreen(items[index]));
                                myInit();
                              },
                            ),
                    );
                  },
                ),
              ));
  }
}
