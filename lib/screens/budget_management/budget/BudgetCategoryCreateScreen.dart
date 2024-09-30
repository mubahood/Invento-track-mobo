import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_ui/data/my_colors.dart';
import 'package:flutter_ui/model/BudgetProgramModel.dart';
import 'package:flutter_ui/model/LoggedInUser.dart';
import 'package:flutter_ui/model/ResponseModel.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../../model/BudgetItemCategoryModel.dart';
import '../../../model/Utils.dart';

class BudgetCategoryCreateScreen extends StatefulWidget {
  Map<String, dynamic> params = {};

  BudgetCategoryCreateScreen(this.params);

  @override
  State<BudgetCategoryCreateScreen> createState() =>
      _BudgetCategoryCreateScreenState();
}

class _BudgetCategoryCreateScreenState
    extends State<BudgetCategoryCreateScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  bool isEdit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.params.containsKey('category')) {
      item = widget.params['category'];
    }
    if (widget.params.containsKey('program')) {
      program = widget.params['program'];
    }

    if (item.id != 0) {
      isEdit = true;
    } else {
      isEdit = false;
    }
    if (!isEdit) {
      if (program.id < 1) {
        Get.snackbar(
          "Error",
          "Please select a budget program first",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        Navigator.pop(context);
        return;
      }
    }
    item.budget_program_text = program.name;
    item.budget_program_id = program.id.toString();
    item.company_id = program.company_id;
    item.company_text = program.company_text;
    myIit();
  }

  LoggedInUser u = LoggedInUser();
  BudgetItemCategoryModel item = BudgetItemCategoryModel();
  BudgetProgramModel program = BudgetProgramModel();

  myIit() async {
    u = await LoggedInUser.getUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${isEdit ? 'Updating' : 'Creating new'} Budget Category"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                FormBuilderTextField(
                  name: 'budget_program_text',
                  initialValue: item.budget_program_text,
                  enableSuggestions: true,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Budget program',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 0,
                    ),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),

                SizedBox(
                  height: 15,
                ),
                FormBuilderTextField(
                  name: 'name',
                  initialValue: item.name,
                  enableSuggestions: true,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.done,
                  onChanged: (val) {
                    item.name = val.toString();
                  },
                  decoration: InputDecoration(
                    labelText: 'Category Name',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 0,
                    ),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),

                SizedBox(
                  height: 15,
                ),

                //error
                error.isNotEmpty
                    ? Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        child: Text(
                          error,
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      )
                    : Container(),

                SizedBox(
                  height: 5,
                ),
                //submit button
                ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      doSubmit();
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.primary,
                      minimumSize: Size(double.infinity, 50),
                      padding: EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 15,
                      ),
                    )),
                //field for description
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String error = '';

  void doSubmit() async {
    Utils.showLoader(false);
    setState(() {
      error = '';
    });

    LoggedInUser user = await LoggedInUser.getUser();
    Map<String, dynamic> data = item.toJson();
    data['user_id'] = user.id.toString();
    data['company_id'] = user.company_id.toString();
    if (!isEdit) {
      data['budget_program_id'] = program.id.toString();
    }

    ResponseModel resp = ResponseModel(
      await Utils.http_post('api/${BudgetItemCategoryModel.end_point}', data),
    );

    Utils.hideLoader();

    if (resp.code != 1) {
      setState(() {
        error = resp.message;
      });
      //toast
      Get.snackbar(
        "Error",
        resp.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    BudgetItemCategoryModel _item = BudgetItemCategoryModel.fromJson(resp.data);
    if (_item.id > 0) {
      item = _item;
      await item.save();
      setState(() {});
    }
    //success
    Get.snackbar(
      "Success",
      resp.message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    Navigator.pop(context);
  }

  String image_path = "";

  do_pick_image(String source) async {}

  void show_image_picker_bottom_sheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Colors.white),
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Select image from',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  do_pick_image("camera");
                },
                child: Text('Camera'),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  do_pick_image("gallery");
                },
                child: Text('Gallery'),
              ),
            ],
          ),
        );
      },
    );
  }
}
