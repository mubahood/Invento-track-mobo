import 'package:flutter/material.dart';
import 'package:flutter_ui/model/BudgetProgramModel.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';

import '../../../data/my_colors.dart';
import '../../../model/BudgetItemCategoryModel.dart';
import '../../../model/Utils.dart';
import '../../../widget/widgets.dart';
import 'BudgetCategoryCreateScreen.dart';
import 'BudgetItemsScreen.dart';
import 'BudgetProgramCreateScreen.dart';

class BudgetItemCategoriesScreen extends StatefulWidget {
  Map<String, dynamic> params = {};

  BudgetItemCategoriesScreen(this.params);

  @override
  State<BudgetItemCategoriesScreen> createState() =>
      _BudgetItemCategoriesScreenState();
}

class _BudgetItemCategoriesScreenState
    extends State<BudgetItemCategoriesScreen> {
  List<BudgetItemCategoryModel> items = [];
  BudgetProgramModel program = BudgetProgramModel();

  bool isPicker = false;
  double box1 = Get.width / 3;
  double box2 = Get.width / 3;

  //target_amount
  int target_amount = 0;

  //balance
  int balance = 0;

  @override
  void initState() {
    super.initState();
    if (widget.params['program'].runtimeType != program.runtimeType) {
      Utils.toast("Budget program not found.");
      Navigator.pop(context);
      return;
    }
    program = widget.params['program'];
    if (widget.params.isNotEmpty) {
      if (widget.params.containsKey('isPicker')) {
        if (widget.params['isPicker'] == true) {
          isPicker = true;
        }
      }
    }
    setState(() {});
    myInit();
  }

  String where = "1";

  myInit() async {
    target_amount = 0;
    //balance
    balance = 0;
    where = " budget_program_id = '${program.id}' ";
    items = await BudgetItemCategoryModel.get_items(where: where);
    totalQuantity = 0;
    items.forEach((element) {
      totalQuantity += Utils.int_parse(element.target_amount);
      target_amount += Utils.int_parse(element.target_amount);
      balance += Utils.int_parse(element.balance);
    });

    setState(() {});
  }

  String filterByType = "";
  String filterText = "";
  int totalQuantity = 0;

  String searchKeyword = "";
  bool searchMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: MyColors.primary,
          onPressed: () async {
            await Get.to(() => BudgetCategoryCreateScreen({
                  'program': program,
                  'category': BudgetItemCategoryModel(),
                }));
            myInit();
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () async {
                await Get.to(() => BudgetProgramCreateScreen(
                      program,
                    ));
                myInit();
              },
            ),
          ],
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                program.name,
                maxLines: 2,
              ),
              FxText.bodySmall(
                "Budget Categories",
                color: Colors.white,
              ),
            ],
          ),
          /*actions: [
            IconButton(
              icon: Icon(
                searchMode ? Icons.close : Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  searchMode = !searchMode;
                });
              },
            ),

            //button for adding new stock item
            IconButton(
              icon: const Icon(
                Icons.add,
                size: 35,
                color: Colors.white,
              ),
              onPressed: () async {
                */ /*await Get.to(() =>
                    ContributionRecordCreateScreen(ContributionRecordModel()));
                myInit();*/ /*
              },
            ),

            PopupMenuButton(
              onSelected: (value) async {
                if (value == 1) {
                  items.sort((a, b) => a.id.compareTo(b.id));
                  setState(() {});
                } else if (value == 2) {
                  items.sort((a, b) => b.id.compareTo(a.id));
                  setState(() {});
                } else if (value == 5) {
                  StockCategoryModel? temp =
                      await Get.to(() => StockCategoriesScreen({
                            'isPicker': true,
                          }));
                  if (temp != null) {
                    filterCategory = temp;
                    myInit();
                    setState(() {});
                  }
                } else if (value == 6) {
                  StockSubCategoryModel? temp =
                      await Get.to(() => StockSubCategoriesScreen({
                            'isPicker': true,
                          }));
                  if (temp != null) {
                    filterSubCategory = temp;
                    myInit();
                    setState(() {});
                  }
                } else if (value == 7) {
                  FinancialPeriodModel? temp =
                      await Get.to(() => FinancialPeriodsScreen({
                            'isPicker': true,
                          }));
                  if (temp != null) {
                    filterCycle = temp;
                    myInit();
                    setState(() {});
                  }
                } else if (value == 8) {
                  setState(() {});
                }
                setState(() {});
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    value: 1,
                    child: Text("Sort by date (ASC)."),
                  ),
                  const PopupMenuItem(
                    value: 2,
                    child: Text("Sort by date (DESC)."),
                  ),
                  const PopupMenuItem(
                    value: 3,
                    child: Text("Sort by quantity (ASC)."),
                  ),
                  const PopupMenuItem(
                    value: 4,
                    child: Text("Sort by quantity (DESC)"),
                  ),
                  //by category
                  const PopupMenuItem(
                    value: 5,
                    child: Text("Filter by category"),
                  ),
                  //by sub category
                  const PopupMenuItem(
                    value: 6,
                    child: Text("Filter by sub category"),
                  ),
                  //filter by cycle
                  const PopupMenuItem(
                    value: 7,
                    child: Text("Filter by cycle"),
                  ),
                ];
              },
            ),
            SizedBox(
              width: 15,
            ),
          ],*/
        ),
        body: items.isEmpty
            ? emptyListWidget("No Stock Categories found.", "Refresh", () {
                myInit();
              })
            : RefreshIndicator(
                onRefresh: () async {
                  myInit();
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        FxContainer(
                          child: FxText.bodySmall(
                            "Category",
                            color: Colors.black,
                            fontWeight: 900,
                          ),
                          color: Colors.grey.shade300,
                          borderRadiusAll: 0,
                          width: box1,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                        ),
                        FxContainer(
                          child: FxText.bodySmall(
                            "Target Amount",
                            color: Colors.black,
                            fontWeight: 900,
                          ),
                          color: Colors.grey.shade300,
                          borderRadiusAll: 0,
                          width: box2,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 5),
                        ),
                        FxContainer(
                          child: FxText.bodySmall(
                            "Balance",
                            color: Colors.black,
                            fontWeight: 900,
                          ),
                          color: Colors.grey.shade300,
                          borderRadiusAll: 0,
                          width: Get.width - (box1 + box2),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                        ),
                      ],
                    ),
                    Expanded(
                      child: true
                          ? CustomScrollView(
                              slivers: [
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          if (isPicker) {
                                            Get.back(result: items[index]);
                                            return;
                                          }
                                          Get.to(() => BudgetItemsScreen(
                                                {
                                                  'category': items[index],
                                                },
                                              ));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 5,
                                          ),
                                          color: index % 2 == 1
                                              ? Colors.grey.shade200
                                              : Colors.white,
                                          child: Row(
                                            children: [
                                              FxContainer(
                                                child: FxText(
                                                    items[index].name + " : "),
                                                padding: EdgeInsets.only(
                                                  left: 5,
                                                ),
                                                width: box1,
                                              ),
                                              Container(
                                                width: box2,
                                                child: FxText(
                                                  Utils.moneyFormat(items[index]
                                                      .target_amount),
                                                  color: MyColors.primary,
                                                  fontWeight: 700,
                                                ),
                                              ),
                                              Container(
                                                width:
                                                    Get.width - (box1 + box2),
                                                child: FxText(
                                                  Utils.moneyFormat(
                                                      items[index].balance),
                                                  color: MyColors.primary,
                                                  fontWeight: 700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    childCount: items.length, // 1000 list items
                                  ),
                                ),
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                      return Container(
                                        color: MyColors.primary,
                                        child: Row(
                                          children: [
                                            FxContainer(
                                              child: FxText(
                                                "Totals : ",
                                                color: Colors.white,
                                              ),
                                              padding: EdgeInsets.only(
                                                left: 5,
                                              ),
                                              width: box1,
                                            ),
                                            Container(
                                              width: box2,
                                              child: FxText(
                                                Utils.moneyFormat(
                                                    target_amount.toString()),
                                                color: Colors.white,
                                                fontWeight: 700,
                                              ),
                                            ),
                                            Container(
                                              width: Get.width - (box1 + box2),
                                              child: FxText(
                                                Utils.moneyFormat(
                                                    balance.toString()),
                                                color: Colors.white,
                                                fontWeight: 700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    childCount: 1, // 1000 list items
                                  ),
                                ),
                              ],
                            )
                          : ListView.builder(
                              itemCount: items.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  color: index % 2 == 1
                                      ? Colors.grey.shade200
                                      : Colors.white,
                                  child: Row(
                                    children: [
                                      FxContainer(
                                        child:
                                            FxText(items[index].name + " : "),
                                        padding: EdgeInsets.only(
                                          left: 5,
                                        ),
                                        width: box1,
                                      ),
                                      Container(
                                        width: box2,
                                        child: FxText(
                                          Utils.moneyFormat(
                                              items[index].target_amount),
                                          color: MyColors.primary,
                                          fontWeight: 700,
                                        ),
                                      ),
                                      Container(
                                        width: Get.width - (box1 + box2),
                                        child: FxText(
                                          Utils.moneyFormat(
                                              items[index].balance),
                                          color: MyColors.primary,
                                          fontWeight: 700,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                                //return stockItemTile(items[index], isPicker);
                              },
                            ),
                    ),
                    FxContainer(
                      padding: EdgeInsets.only(left: 15, bottom: 20, right: 90),
                      child: FxButton.block(
                          padding: EdgeInsets.symmetric(
                            vertical: 20,
                          ),
                          backgroundColor: MyColors.primary,
                          child: FxText.titleMedium(
                            "DOWNLOAD BUDGET PDF",
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            //pop
                            Navigator.pop(context);

                            Utils.urlLauncher(
                              Utils.BASE_URL +
                                  "budget-program-print?id=${program.id}",
                            );
                          }),
                    ),
                  ],
                ),
              ));
  }
}
