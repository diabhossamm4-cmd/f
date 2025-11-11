import 'package:espitaliaa_doctors/getx/org/auth_org_controller.dart';
import 'package:espitaliaa_doctors/getx/org/home_org_controllers.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/app_utils.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/widgets/my_button.dart';
import 'package:espitaliaa_doctors/widgets/my_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AddServicePage extends StatefulWidget {
  @override
  _AddServicePageState createState() => _AddServicePageState();
}

class _AddServicePageState extends State<AddServicePage> {
  TextEditingController _priceController = TextEditingController();
  TextEditingController nameArController = TextEditingController();
  TextEditingController nameEnController = TextEditingController();
  TextEditingController detailsArController = TextEditingController();
  TextEditingController detailsEnController = TextEditingController();
  TextEditingController priceController2 = TextEditingController();

  HomeOrgController _homeOrgController = Get.put(HomeOrgController());

  AuthOrgController _authController = Get.find();

  bool _isActive = false;

  final _formKey = GlobalKey<FormState>();

  void _isActiveChangeCallback(bool value) {
    _isActive = value;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        physics: bouncingScroll,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: size.height * .05,
              ),
              ListTile(
                title: Text(
                  AppLocalizations.of(context).translate('add_new_service'),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    wordSpacing: 2,
                    fontSize: 22,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.black,
                  ),
                ),
              ),
              divider(size),
              MyTextFormField(
                prefixIcon: FontAwesomeIcons.file,
                maxLines: 1,
                textInputAction: TextInputAction.next,
                controller: nameArController,
                hint: AppLocalizations.of(context).translate(
                  'name_in_arabic',
                ),
                validator: (String input) {
                  if (input.isEmpty) {
                    return AppLocalizations.of(context).translate('required');
                  } else if (input.length < 2) {
                    return AppLocalizations.of(context).translate('enter_valid_name');
                  } else {
                    return null;
                  }
                },
              ),
              divider(size),
              MyTextFormField(
                prefixIcon: FontAwesomeIcons.file,
                textInputAction: TextInputAction.next,
                maxLines: 1,
                controller: nameEnController,
                validator: (String input) {
                  if (input.isEmpty) {
                    return AppLocalizations.of(context).translate('required');
                  } else if (input.length < 2) {
                    return AppLocalizations.of(context).translate('enter_valid_name');
                  } else {
                    return null;
                  }
                },
                hint: AppLocalizations.of(context).translate(
                  'name_in_english',
                ),
              ),
              divider(size),
              MyTextFormField(
                iconSize: 20,
                prefixIcon: FontAwesomeIcons.fileMedical,
                textInputAction: TextInputAction.next,
                controller: detailsArController,
                validator: (String input) {
                  if (input.isEmpty) {
                    return AppLocalizations.of(context).translate('required');
                  } else {
                    return null;
                  }
                },
                hint: AppLocalizations.of(context).translate('desc_ar_text'),
                maxLines: 5,
                height: 100,
              ),
              divider(size),
              MyTextFormField(
                iconSize: 20,
                prefixIcon: FontAwesomeIcons.fileMedical,
                textInputAction: TextInputAction.next,
                controller: detailsEnController,
                validator: (String input) {
                  if (input.isEmpty) {
                    return AppLocalizations.of(context).translate('required');
                  } else {
                    return null;
                  }
                },
                hint: AppLocalizations.of(context).translate('desc_en_text'),
                maxLines: 5,
                height: 100,
              ),
              divider(size),
              MyTextFormField(
                prefixIcon: FontAwesomeIcons.moneyBillWave,
                textInputAction: TextInputAction.next,
                hint: AppLocalizations.of(context).translate('detection_price'),
                controller: _priceController,
                validator: (String input) {
                  if (input.isEmpty) {
                    return AppLocalizations.of(context).translate('required');
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.number,
              ),
              divider(size),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          AppLocalizations.of(context).translate('active'),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              child: Row(
                                children: [
                                  Text(
                                    AppLocalizations.of(context).translate('yes'),
                                  ),
                                  Radio(
                                    value: true,
                                    activeColor: mainColor,
                                    groupValue: _isActive,
                                    onChanged: _isActiveChangeCallback,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              child: Row(
                                children: [
                                  Text(
                                    AppLocalizations.of(context).translate('no'),
                                  ),
                                  Radio(
                                    value: false,
                                    activeColor: mainColor,
                                    groupValue: _isActive,
                                    onChanged: _isActiveChangeCallback,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              divider(size),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(16),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: MyButton(
                    width: ScreenUtil().setWidth(120),
                    onTap: () {
                      validateAndSubmit();
                    },
                    text: AppLocalizations.of(context).translate('next'),
                    borderRadius: 8,
                    textStyle: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              divider(size),
              divider(size),
            ],
          ),
        ),
      ),
    );
  }

  Widget divider(Size size) {
    return SizedBox(
      height: size.height * .02,
    );
  }

  void validateAndSubmit() async {
    AppUtils.hideKeyboard(context);
    if (_formKey.currentState.validate()) {
      var body = {
        "title_ar": "${nameArController.text}",
        "title_en": "${nameEnController.text}",
        "description_ar": "${detailsArController.text}",
        "description_en": "${detailsEnController.text}",
        "price": "${_priceController.text}",
        "active": "${_isActive ? '1' : '0'}",
        "organization_id": "${_authController.activeUser.value.data.id}",
      };

      _homeOrgController.addNewService(
        body: body,
      );
    }
  }
}
