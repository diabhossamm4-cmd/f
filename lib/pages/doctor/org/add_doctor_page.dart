import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:espitaliaa_doctors/getx/general_data_controller.dart';
import 'package:espitaliaa_doctors/getx/org/auth_org_controller.dart';
import 'package:espitaliaa_doctors/getx/org/home_org_controllers.dart';
import 'package:espitaliaa_doctors/models/general_model.dart';
import 'package:espitaliaa_doctors/models/pointer.dart';
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
import 'package:image_picker/image_picker.dart';

class AddDoctorPage extends StatefulWidget {
  @override
  _AddDoctorPageState createState() => _AddDoctorPageState();
}

class _AddDoctorPageState extends State<AddDoctorPage> {
  TextEditingController _priceController = TextEditingController();
  TextEditingController nameArController = TextEditingController();
  TextEditingController nameEnController = TextEditingController();
  TextEditingController detailsArController = TextEditingController();
  TextEditingController detailsEnController = TextEditingController();
  TextEditingController priceController2 = TextEditingController();

  GeneralDataController _generalDataController = Get.find();
  HomeOrgController _homeOrgController = Get.put(HomeOrgController());

  AuthOrgController _authController = Get.find();
  bool _acceptEmergency = false;
  bool _isActive = false;
  //  1 => male   ||  2 => female
  int _selectedGender = 1;

  File storedImage;
  File _selectedFile;

  void _isEmergencyChangeCallback(bool value) {
    _acceptEmergency = value;
    setState(() {});
  }

  void _isActiveChangeCallback(bool value) {
    _isActive = value;
    setState(() {});
  }

  void _genderChangeCallback(int value) {
    _selectedGender = value;
    setState(() {});
  }

  String _selectedSpecialize;
  String _selectedTitle;

  final _formKey = GlobalKey<FormState>();
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
                  "Add Doctor ",
                  style: TextStyle(
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
                  icon: Icon(
                    Icons.clear,
                    color: Colors.black,
                  ),
                ),
              ),
              divider(size),
              _buildImagePart(size),
              divider(size),
              MyTextFormField(
                prefixIcon: FontAwesomeIcons.file,
                maxLines: 1,
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
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      AppLocalizations.of(context).translate('gender'),
                      style: TextStyle(
                        color: mainColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(20),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            child: Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context).translate('male'),
                                ),
                                Radio(
                                  value: 1,
                                  activeColor: mainColor,
                                  groupValue: _selectedGender,
                                  onChanged: _genderChangeCallback,
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            child: Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context).translate('female'),
                                ),
                                Radio(
                                  value: 0,
                                  activeColor: mainColor,
                                  groupValue: _selectedGender,
                                  onChanged: _genderChangeCallback,
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
              divider(size),
              MyTextFormField(
                iconSize: 20,
                prefixIcon: FontAwesomeIcons.fileMedical,
                controller: detailsArController,
                validator: (String input) {
                  if (input.isEmpty) {
                    return AppLocalizations.of(context).translate('required');
                  } else {
                    return null;
                  }
                },
                hint: AppLocalizations.of(context).translate('bio_ar_text'),
                maxLines: 5,
                height: 100,
              ),
              divider(size),
              MyTextFormField(
                iconSize: 20,
                prefixIcon: FontAwesomeIcons.fileMedical,
                controller: detailsEnController,
                validator: (String input) {
                  if (input.isEmpty) {
                    return AppLocalizations.of(context).translate('required');
                  } else {
                    return null;
                  }
                },
                hint: AppLocalizations.of(context).translate('bio_en_text'),
                maxLines: 5,
                height: 100,
              ),
              divider(size),
              MyTextFormField(
                prefixIcon: FontAwesomeIcons.moneyBillWave,
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
                          AppLocalizations.of(context).translate('accept_emergency'),
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
                                    groupValue: _acceptEmergency,
                                    onChanged: _isEmergencyChangeCallback,
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
                                    groupValue: _acceptEmergency,
                                    onChanged: _isEmergencyChangeCallback,
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
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        AppLocalizations.of(context).translate('special'),
                        style: TextStyle(
                          color: mainColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: mainColor.withOpacity(.05),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(AppLocalizations.of(context).translate('choose_a_specialty')),
                            ),
                            isExpanded: false,
                            value: _selectedSpecialize,
                            items: _generalDataController.specializationList.map((GeneralData value) {
                              return DropdownMenuItem<String>(
                                value: value.id,
                                child: Container(
                                  child: Text(value.name),
                                  margin: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(16),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String newSpec) {
                              _selectedSpecialize = newSpec;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              divider(size),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        AppLocalizations.of(context).translate('title'),
                        style: TextStyle(
                          color: mainColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: mainColor.withOpacity(.05),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(AppLocalizations.of(context).translate('title')),
                            ),
                            isExpanded: false,
                            value: _selectedTitle,
                            items: _generalDataController.doctorsTitleList.map((GeneralData value) {
                              return DropdownMenuItem<String>(
                                value: value.id,
                                child: Container(
                                  child: Text(value.name),
                                  margin: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(16),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String newSpec) {
                              _selectedTitle = newSpec;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
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
                      print(Pointer.placeType);
                      validateAndSubmit();
                      /* if (Pointer.placeType == 3) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => AddDoctorPage(),
                          ),
                        );
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => SetDateTimePage(),
                          ),
                        );
                      }*/
                    },
                    text: AppLocalizations.of(context).translate('next'),
                    borderRadius: 8,
                    textStyle: TextStyle(
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
      if (storedImage == null) {
        AppUtils.showToast(msg: AppLocalizations.of(context).translate('chose_pic'));
        return;
      }
      if (_selectedSpecialize == null) {
        AppUtils.showToast(msg: AppLocalizations.of(context).translate('select_specialize'));
        return;
      }
      if (_selectedTitle == null) {
        AppUtils.showToast(msg: AppLocalizations.of(context).translate('select_title'));
        return;
      }
      String genderName = _selectedGender == 1 ? "male" : "female";
      var body = {
        "name_ar": "${nameArController.text}",
        "name_en": "${nameEnController.text}",
        "bio_ar": "${detailsArController.text}",
        "bio_en": "${detailsEnController.text}",
        "price": "${_priceController.text}",
        "is_emergenc": "${_acceptEmergency ? '1' : '0'}",
        "active": "${_isActive ? '1' : '0'}",
        "gender": "$genderName",
        "organization_id": "${_authController.activeUser.value.data.id}",
        "title_id": "$_selectedTitle",
        "specialize_id": "$_selectedSpecialize"
      };
      var data = dio.FormData.fromMap(body);

      dio.MultipartFile file = await dio.MultipartFile.fromFile(storedImage.path, filename: 'upload.png');
      data.files.add(MapEntry('profile_pic', file));

      _homeOrgController.addNewDoctor(
        body: data,
      );
    }
  }

  Widget _buildImagePart(Size size) {
    return InkWell(
      onTap: () => _takePicture(),
      child: Container(
        width: size.width,
        height: ScreenUtil().setHeight(130),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: ScreenUtil().setWidth(120),
              height: ScreenUtil().setHeight(120),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: mainColor.withOpacity(.8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(80),
                child: FlatButton(
                  onPressed: () => _takePicture(),
                  padding: EdgeInsets.all(0),
                  child: Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: mainColor.withOpacity(.8),
                      backgroundImage: storedImage == null ? null : FileImage(storedImage, scale: 1),
                      child: Center(
                        child: Icon(
                          Icons.image,
                          color: Colors.white,
                          size: 38,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: ScreenUtil().setWidth(60),
              height: ScreenUtil().setHeight(15),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  AppLocalizations.of(context).translate('upload'),
                  style: TextStyle(
                    fontSize: 9,
                  ),
                ),
              ),
            ),
            _selectedFile == null
                ? SizedBox.shrink()
                : Positioned(
                    right: ScreenUtil().setWidth(size.width / 2 - 110),
                    top: ScreenUtil().setHeight(10),
                    child: Container(
                        width: ScreenUtil().setWidth(40),
                        height: ScreenUtil().setHeight(40),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: FlatButton(
                            onPressed: () {},
                            padding: EdgeInsets.all(0),
                            child: Center(
                              child: Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        )),
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> _takePicture() async {
    final imageFile = await ImagePicker().getImage(source: ImageSource.camera);

    if (imageFile == null) {
      return;
    }
    setState(() {
      storedImage = File(imageFile.path);
    });
  }
}
