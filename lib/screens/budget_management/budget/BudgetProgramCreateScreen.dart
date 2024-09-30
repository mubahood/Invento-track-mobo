import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_ui/data/my_colors.dart';
import 'package:flutter_ui/model/BudgetProgramModel.dart';
import 'package:flutter_ui/model/ResponseModel.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../../model/LoggedInUser.dart';
import '../../../model/Utils.dart';

class BudgetProgramCreateScreen extends StatefulWidget {
  BudgetProgramModel item;

  BudgetProgramCreateScreen(this.item);

  @override
  State<BudgetProgramCreateScreen> createState() =>
      _BudgetProgramCreateScreenState();
}

class _BudgetProgramCreateScreenState extends State<BudgetProgramCreateScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("${widget.item.id == 0 ? 'Create' : 'Edit'} Budget Program"),
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
                  name: 'name',
                  initialValue: widget.item.name,
                  onChanged: (String? val) {
                    widget.item.name = val!;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Budget Program Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(3),
                    FormBuilderValidators.maxLength(100),
                  ]),
                ),
                SizedBox(
                  height: 15,
                ),

                FormBuilderTextField(
                  name: 'title',
                  initialValue: widget.item.title,
                  onChanged: (String? val) {
                    widget.item.title = val!;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Budget Document Title',
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(3),
                    FormBuilderValidators.maxLength(100),
                  ]),
                ),
                SizedBox(
                  height: 15,
                ),
                //radio picker for status
                FormBuilderRadioGroup(
                  name: 'status',
                  initialValue: widget.item.status,
                  onChanged: (String? val) {
                    widget.item.status = val!;
                  },
                  options: [
                    FormBuilderFieldOption(
                      value: 'Active',
                    ),
                    FormBuilderFieldOption(
                      value: 'Inactive',
                    ),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Budget Status',
                    contentPadding: EdgeInsets.all(5),
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),

                SizedBox(
                  height: 15,
                ),
                //radio picker for status
                FormBuilderRadioGroup(
                  name: 'is_default',
                  initialValue: widget.item.is_default,
                  onChanged: (String? val) {
                    widget.item.is_default = val!;
                  },
                  options: [
                    FormBuilderFieldOption(
                      value: 'Yes',
                    ),
                    FormBuilderFieldOption(
                      value: 'No',
                    ),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Is Default Budget Program',
                    contentPadding: EdgeInsets.all(5),
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),

                SizedBox(
                  height: 15,
                ),

                FormBuilderDateTimePicker(
                  name: 'deadline',
                  initialValue: widget.item.deadline.isNotEmpty
                      ? DateTime.parse(widget.item.deadline)
                      : null,
                  onChanged: (DateTime? val) {
                    widget.item.deadline = val.toString();
                  },
                  inputType: InputType.date,
                  decoration: InputDecoration(
                    labelText: 'Final Date',
                    border: OutlineInputBorder(),
                  ),
                ),

                //field for description
                SizedBox(
                  height: 15,
                ),
                // text
                FormBuilderTextField(
                  name: 'bottom',
                  initialValue: widget.item.bottom,
                  onChanged: (String? val) {
                    widget.item.bottom = val!;
                  },
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    labelText: 'Budget file Bottom Text',
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(3),
                    FormBuilderValidators.maxLength(1000),
                  ]),
                  //newline
                  maxLines: 3,
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
                  height: 25,
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
    Map<String, dynamic> data = widget.item.toJson();
    data['user_id'] = user.id.toString();
    data['company_id'] = user.company_id.toString();
    ResponseModel resp = ResponseModel(
      await Utils.http_post('api/${BudgetProgramModel.end_point}', data),
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
    BudgetProgramModel _item = BudgetProgramModel.fromJson(resp.data);
    if (_item.id > 0) {
      widget.item = _item;
      await widget.item.save();
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
}
