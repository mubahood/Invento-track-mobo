import 'package:flutter/material.dart';
import 'package:flutter_ui/model/StockCategoryModel.dart';
import 'package:get/get.dart';

import '../../model/Utils.dart';
import '../../widget/widgets.dart';
import 'StockCategoryCreateScreen.dart';

class StockCategoriesScreen extends StatefulWidget {
  const StockCategoriesScreen();

  @override
  State<StockCategoriesScreen> createState() => _StockCategoriesScreenState();
}

class _StockCategoriesScreenState extends State<StockCategoriesScreen> {
  List<StockCategoryModel> items = [];

  @override
  void initState() {
    super.initState();
    myInit();
  }

  myInit() async {
    items = await StockCategoryModel.get_items();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Stock Categories"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Get.to(() => StockCategoryCreateScreen(StockCategoryModel()));
            myInit();
          },
          child: const Icon(Icons.add),
        ),
        body: items.isEmpty
            ? emptyListWidget("No Stock Categories found.", "Refresh", () {
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
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          Utils.getImageUrl(items[index].image),
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                        ),
                      ),
                      title: Text(items[index].name),
                      onTap: () {},
                      subtitle: Text(
                        items[index].description,
                        maxLines: 1,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          await Get.to(
                              () => StockCategoryCreateScreen(items[index]));
                          myInit();
                        },
                      ),
                    );
                  },
                ),
              ));
  }
}
