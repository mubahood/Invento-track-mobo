import 'package:flutter/material.dart';
import 'package:flutter_ui/data/my_colors.dart';
import 'package:flutter_ui/model/LoggedInUser.dart';
import 'package:flutter_ui/screens/Auth/LandingScreen.dart';
import 'package:flutter_ui/screens/stock_categories/StockCategoriesScreen.dart';
import 'package:flutter_ui/screens/stock_categories/StockSubCategoriesScreen.dart';
import 'package:flutter_ui/screens/stock_records/StockRecordsScreen.dart';
import 'package:get/get.dart';

import '../model/Utils.dart';
import 'Common/AboutScreen.dart';
import 'Common/ContactUsScreen.dart';
import 'Common/StatisticsScreen.dart';
import 'employees/EmployeesScreen.dart';
import 'financial_periods/FinancialPeriodsScreen.dart';
import 'stock_items/StockItemsScreen.dart';

class MenuRoute extends StatefulWidget {
  MenuRoute();

  @override
  State<MenuRoute> createState() => _MenuRouteState();
}

class _MenuRouteState extends State<MenuRoute> {
  LoggedInUser user = LoggedInUser();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myInit();
  }

  myInit() async {
    user = await LoggedInUser.getUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: topSection(),
      ),
      body: ListView(
        children: [
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              menuWidget1(
                'My Sales',
                'Manage all your sales in one place.',
                Icons.shopping_cart,
                () {
                  Get.to(() => StockRecordsScreen());
                },
              ),
              SizedBox(
                width: 15,
              ),
              menuWidget1(
                'My Stock',
                'Add, edit and manage your stock items.',
                Icons.archive_outlined,
                () {
                  Get.to(() => StockItemsScreen({}));
                },
              ),
              SizedBox(
                width: 15,
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              menuWidget1(
                'Statistics',
                'View your sales and stock statistics.',
                Icons.pie_chart,
                () {
                  Get.to(() => StatisticsScreen());
                },
              ),
              SizedBox(
                width: 15,
              ),
              menuWidget1(
                'Dashboard',
                'Full access to your account online.',
                Icons.web_outlined,
                () {
                  Utils.urlLauncher(Utils.API_URL.replaceAll('/api', ''));
                },
              ),
              SizedBox(
                width: 15,
              ),
            ],
          ),
          Container(
              padding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 15,
              ),
              child: Text(
                "Store's health",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w900),
              )),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            margin: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Row(
              children: [
                Icon(Icons.check_circle),
                SizedBox(
                  width: 5,
                ),
                Text("No item is running out of stock."),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 15, left: 15),
              child: Text(
                "Account & Settings",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w900),
              )),
          ListTile(
            onTap: () {
              Get.to(() => EmployeesScreen());
            },
            leading: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: MyColors.primary,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Icon(
                Icons.people,
                color: Colors.white,
              ),
            ),
            trailing: Icon(
              Icons.chevron_right,
              size: 30,
              color: MyColors.primary,
            ),
            title: Text(
              "My Employees",
              style: TextStyle(fontSize: 18),
            ),
          ),
          ListTile(
            onTap: () {
              Get.to(() => StockCategoriesScreen({}));
            },
            leading: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: MyColors.primary,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Icon(
                Icons.category,
                color: Colors.white,
              ),
            ),
            trailing: Icon(
              Icons.chevron_right,
              size: 30,
              color: MyColors.primary,
            ),
            title: Text(
              "Stock Categories",
              style: TextStyle(fontSize: 18),
            ),
          ),
          ListTile(
            onTap: () {
              Get.to(() => StockSubCategoriesScreen({}));
            },
            leading: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: MyColors.primary,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Icon(
                Icons.category,
                color: Colors.white,
              ),
            ),
            trailing: Icon(
              Icons.chevron_right,
              size: 30,
              color: MyColors.primary,
            ),
            title: Text(
              "Stock sub-categories",
              style: TextStyle(fontSize: 18),
            ),
          ),
          ListTile(
            onTap: () {
              Get.to(() => FinancialPeriodsScreen({}));
            },
            leading: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: MyColors.primary,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Icon(
                Icons.calendar_month,
                color: Colors.white,
              ),
            ),
            trailing: Icon(
              Icons.chevron_right,
              size: 30,
              color: MyColors.primary,
            ),
            title: Text(
              "Financial periods",
              style: TextStyle(fontSize: 18),
            ),
          ),
          ListTile(
            onTap: () {
              Utils.urlLauncher(Utils.API_URL.replaceAll('/api', ''));
            },
            leading: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: MyColors.primary,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Icon(
                Icons.table_chart_outlined,
                color: Colors.white,
              ),
            ),
            trailing: Icon(
              Icons.chevron_right,
              size: 30,
              color: MyColors.primary,
            ),
            title: Text(
              "Generate reports",
              style: TextStyle(fontSize: 18),
            ),
          ),
          ListTile(
            onTap: () {
              Utils.urlLauncher('https://forms.gle/KyRRfXqKZ5pTAhaq5');
            },
            leading: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: MyColors.primary,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Icon(
                Icons.file_copy,
                color: Colors.white,
              ),
            ),
            trailing: Icon(
              Icons.chevron_right,
              size: 30,
              color: MyColors.primary,
            ),
            title: Text(
              "Download my account and data",
              style: TextStyle(fontSize: 18),
            ),
          ),
          ListTile(
            onTap: () {
              Get.to(() => AboutScreen());
            },
            leading: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: MyColors.primary,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Icon(
                Icons.info,
                color: Colors.white,
              ),
            ),
            trailing: Icon(
              Icons.chevron_right,
              size: 30,
              color: MyColors.primary,
            ),
            title: Text(
              "About the App",
              style: TextStyle(fontSize: 18),
            ),
          ),
          ListTile(
            onTap: () {
              Get.to(() => ContactUsScreen());
            },
            leading: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: MyColors.primary,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Icon(
                Icons.mail,
                color: Colors.white,
              ),
            ),
            trailing: Icon(
              Icons.chevron_right,
              size: 30,
              color: MyColors.primary,
            ),
            title: Text(
              "Contact us",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                //are you sure you want to logout
                Get.defaultDialog(
                  title: 'Logout',
                  middleText: 'Are you sure you want to logout?',
                  textConfirm: 'Yes',
                  textCancel: 'No',
                  confirmTextColor: Colors.white,
                  buttonColor: MyColors.primary,
                  onConfirm: () async {
                    await LoggedInUser.deleteAll();
                    Get.offAll(() => LandingScreen());
                  },
                );
              },
              child: Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }

  topSection() {
    return Row(
      children: [
        Container(
          width: 10,
          height: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: MyColors.primary,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(Utils.APP_NAME,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                  height: 1,
                )),
            Text("${Utils.greet()} ${user.name}.",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
                textAlign: TextAlign.start),
          ],
        ),
      ],
    );
  }

  menuWidget1(String t, String c, IconData icon, Function onTap) {
    return Expanded(
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xFFFBF5F5),
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: MyColors.primary, width: .5)),
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 12,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                child: Icon(
                  icon,
                  size: 25,
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: MyColors.primary,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      t,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          fontSize: 18,
                          height: 1),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      height: 0,
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      c,
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                          height: 1),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
