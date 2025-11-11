import 'dart:io';

import 'package:chips_choice/chips_choice.dart';
import 'package:dio/dio.dart' as dio;
import 'package:espitaliaa_doctors/getx/auth_controller.dart';
import 'package:espitaliaa_doctors/getx/general_data_controller.dart';
import 'package:espitaliaa_doctors/getx/org/auth_org_controller.dart';
import 'package:espitaliaa_doctors/models/general_model.dart';
import 'package:espitaliaa_doctors/models/pointer.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/app_utils.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/utils/dialogs.dart';
import 'package:espitaliaa_doctors/utils/patterns.dart';
import 'package:espitaliaa_doctors/widgets/add_phone_list.dart';
import 'package:espitaliaa_doctors/widgets/chips_choice_item.dart';
import 'package:espitaliaa_doctors/widgets/my_button.dart';
import 'package:espitaliaa_doctors/widgets/my_text_form_field.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:place_picker/place_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  List<dynamic> _selectedSpecialize = [];

  //  1 => male   ||  2 => female
  int _selectedGender = 1;

  bool _hidePassword = true;
  bool _hideConfirmPassword = true;

  int _selectedType = 0;
  int _selectedDoctorTitle = 0;

  ImagePicker _picker;
  File profilePic;

  final AuthController _authController = Get.put(AuthController());
  final _authOrgController = Get.put(AuthOrgController());

  TextEditingController _nameArController = TextEditingController();
  TextEditingController _nameEnController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String _firebaseToken = "";
  bool hidePassword = true;
  List<Widget> phoneWidgetsList = [];
  final textFieldFocusNode = FocusNode();
  List<TextEditingController> phoneControllers = []; //the controllers list
  int _count = 0;
  Size size;
  final _formKey = GlobalKey<FormState>();
  String lang;

  void _genderChangeCallback(int value) {
    _selectedGender = value;
    setState(() {});
  }

  File _selectedFile;

  /// to get general Data  (specialization - city - area - titles )
  final GeneralDataController _generalDataController = Get.find();

  void _typeChangeCallback(int value) {
    _selectedDoctorTitle = value;
    setState(() {});
  }

  void _placeTypeChangeCallback(int value) {
    _selectedType = value;
    Pointer.placeType = _selectedType;
    _authController.selectedPlaceType.value = value;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    textFieldFocusNode.unfocus();
    textFieldFocusNode.dispose();
  }

  @override
  void initState() {
    getLanguage();
    super.initState();
    getFirebaseToken();
    TextEditingController controller = TextEditingController();
    phoneControllers.add(controller);
    Future.delayed(Duration(seconds: 0))
        .then((value) => phoneWidgetsList = List.from(phoneWidgetsList)
          ..add(MyTextFormField(
            textFieldFocusNode: textFieldFocusNode,
            prefixIcon: Icons.phone,
            keyboardType: TextInputType.phone,
            swifixIcon: IconButton(
              onPressed: () {
                _addPhone();
              },
              icon: Icon(Icons.add),
            ),
            controller: controller,
            validator: (String input) {
              if (input.isEmpty) {
                return AppLocalizations.of(context).translate('required');
              } else {
                return null;
              }
            },
            hint: AppLocalizations.of(context).translate('phone'),
          )));
  }

  void getFirebaseToken() async {
    _firebaseToken = await _firebaseMessaging.getToken();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
        body: SingleChildScrollView(
      physics: bouncingScroll,
      child: Form(
        key: _formKey,
        child: Obx(
          () => Column(
            children: [
              SizedBox(
                height: size.height * .05,
              ),
              ListTile(
                title: Text(
                  AppLocalizations.of(context).translate('create_new_account'),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    wordSpacing: 2,
                    fontSize: 22,
                  ),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    AppLocalizations.of(context)
                        .translate('register_new_account_and_book'),
                    style: TextStyle(
                      wordSpacing: 2,
                      color: Colors.black38,
                      fontSize: 16,
                    ),
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
              SizedBox(
                height: size.height * .03,
              ),
              _buildImagePart(size),
              SizedBox(
                height: size.height * .05,
              ),
              MyTextFormField(
                prefixIcon: Icons.person,
                textInputAction: TextInputAction.next,
                controller: _nameArController,
                hint: AppLocalizations.of(context).translate('name_in_arabic'),
              ),
              divider(size),
              MyTextFormField(
                prefixIcon: Icons.person,
                controller: _nameEnController,
                textInputAction: TextInputAction.next,
                validator: (String input) {
                  if (input.isEmpty) {
                    return AppLocalizations.of(context).translate('required');
                  } else {
                    return null;
                  }
                },
                hint: AppLocalizations.of(context).translate('name_in_english'),
              ),
              divider(size),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(16),
                  ),
                  child: Text(
                    AppLocalizations.of(context).translate('place_type'),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              _buildPlaceType(),
              Visibility(
                visible: _authController.selectedPlaceType.value == 0,
                child: ChipsChoiceItem(
                  list: _generalDataController.doctorsTitleList,
                  onChanged: _typeChangeCallback,
                  selectedType: _selectedDoctorTitle,
                ),
              ),
              divider(size),
              Visibility(
                visible: _authController.selectedPlaceType.value == 0,
                child: Padding(
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
                                    AppLocalizations.of(context)
                                        .translate('male'),
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
                                    AppLocalizations.of(context)
                                        .translate('female'),
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
              ),
              divider(size),
              MyTextFormField(
                prefixIcon: Icons.email,
                textInputAction: TextInputAction.next,
                hint: AppLocalizations.of(context).translate('email'),
                controller: _emailController,
                validator: (String input) {
                  if (input.isEmpty) {
                    return AppLocalizations.of(context).translate('required');
                  } else if (!MyPatterns.emailIsValid(input.trimRight())) {
                    return AppLocalizations.of(context)
                        .translate('enter_valid_email');
                  } else {
                    return null;
                  }
                },
              ),
              divider(size),
              _authController.selectedPlaceType.value == 0
                  ? MyTextFormField(
                      prefixIcon: Icons.phone,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      controller: _mobileController,
                      validator: (String input) {
                        if (input.isEmpty) {
                          return AppLocalizations.of(context)
                              .translate('required');
                        } else {
                          return null;
                        }
                      },
                      hint: AppLocalizations.of(context).translate('phone'),
                    )
                  : AddPhonesLists(childern: phoneWidgetsList),
              divider(size),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(16),
                ),
                child: MultiSelectFormField(
                  fillColor: mainColor.withOpacity(.08),
                  border: InputBorder.none,
                  leading: Image.asset('assets/images/clinic.png'),
                  chipLabelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  dialogTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  checkBoxActiveColor: Colors.white,
                  checkBoxCheckColor: mainColor,
                  dialogShapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                  title: Text(
                    AppLocalizations.of(context).translate('specialties'),
                    style: TextStyle(fontSize: 16),
                  ),
                  dataSource: _generalDataController.specializationListJson,
                  textField: 'name',
                  valueField: 'id',
                  okButtonLabel: AppLocalizations.of(context).translate('ok'),
                  cancelButtonLabel:
                      AppLocalizations.of(context).translate('cancel'),
                  hintWidget: Text(
                    AppLocalizations.of(context)
                        .translate('special_select_one_or_more'),
                  ),
                  initialValue: _selectedSpecialize,
                  onSaved: (value) {
                    if (value == null) return;
                    setState(() {
                      _selectedSpecialize = value;
                    });
                  },
                ),
              ),
              divider(size),
              MyTextFormField(
                controller: _passwordController,
                prefixIcon: Icons.lock,
                textInputAction: TextInputAction.done,
                obscureText: _hidePassword,
                validator: (String input) {
                  if (input.isEmpty) {
                    return AppLocalizations.of(context).translate('required');
                  } else if (input.length < 6) {
                    return AppLocalizations.of(context)
                        .translate('password_length_msg');
                  } else {
                    return null;
                  }
                },
                swifixIcon: IconButton(
                  icon: Icon(
                      _hidePassword ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    _hidePassword = !_hidePassword;
                    setState(() {});
                  },
                ),
                hint: AppLocalizations.of(context).translate('password'),
              ),
              divider(size),
              MyTextFormField(
                prefixIcon: Icons.lock,
                controller: _passwordConfirmController,
                textInputAction: TextInputAction.done,
                obscureText: _hideConfirmPassword,
                validator: (String input) {
                  if (input.isEmpty) {
                    return AppLocalizations.of(context).translate('required');
                  } else if (input.length < 6) {
                    return AppLocalizations.of(context)
                        .translate('password_length_msg');
                  } else if (_passwordController.text !=
                      _passwordConfirmController.text)
                    return AppLocalizations.of(context)
                        .translate('confirm_pass_error');
                  else {
                    return null;
                  }
                },
                swifixIcon: IconButton(
                  icon: Icon(_hideConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    _hideConfirmPassword = !_hideConfirmPassword;
                    setState(() {});
                  },
                ),
                hint:
                    AppLocalizations.of(context).translate('password_confirm'),
              ),
              SizedBox(
                height: size.height * .035,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(18),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyButton(
                      borderRadius: 12,
                      width: ScreenUtil().setWidth(120),
                      text: AppLocalizations.of(context).translate('next'),
                      onTap: () {
                        validateForm();
                        /*    Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => SetPasswordPage(),
                          ),
                        );*/

                        // Get.to(GeneralDataPage1());
                        //validateForm2();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * .065,
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void _addPhone() {
    // Unfocus all focus nodes
    textFieldFocusNode.unfocus();

    // Disable text field's focus node request
    textFieldFocusNode.canRequestFocus = false;

    //Enable the text field's focus node request after some delay
    Future.delayed(Duration(milliseconds: 100), () {
      textFieldFocusNode.canRequestFocus = true;
    });

    TextEditingController controller = TextEditingController();
    phoneControllers = List.from(phoneControllers)
      ..add(controller); //adding the current controller to the list

    phoneWidgetsList = List.from(phoneWidgetsList)
      ..add(Column(
        children: [
          divider(size),
          MyTextFormField(
            prefixIcon: Icons.phone,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            controller: controller,
            swifixIcon: IconButton(
              onPressed: () {
                removePhone(controller);
              },
              icon: Icon(Icons.remove),
            ),
            validator: (String input) {
              if (input.isEmpty) {
                return AppLocalizations.of(context).translate('required');
              } else {
                return null;
              }
            },
            hint: AppLocalizations.of(context).translate('phone'),
          ),
        ],
      ));
    setState(() => _count++);
  }

  void removePhone(
    controller,
  ) {
    textFieldFocusNode.unfocus();

    // Disable text field's focus node request
    textFieldFocusNode.canRequestFocus = false;

    //Enable the text field's focus node request after some delay
    Future.delayed(Duration(milliseconds: 100), () {
      textFieldFocusNode.canRequestFocus = true;
    });

    phoneWidgetsList = List.from(phoneWidgetsList)..removeAt(_count);
    phoneControllers = List.from(phoneControllers)..removeAt(_count);

    setState(() {
      _count--;
    });
  }

  Widget divider(Size size) {
    return SizedBox(
      height: size.height * .02,
    );
  }

  Widget _buildPlaceType() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(16),
      ),
      child: ChipsChoice<int>.single(
        itemConfig: ChipsChoiceItemConfig(
          selectedBorderOpacity: 1,
          elevation: 5,
          selectedColor: mainColor,
        ),
        value: _selectedType,
        options: ChipsChoiceOption.listFrom<int, GeneralData>(
          source: lang == "ar" ? orgListAr : orgListEn,
          value: (i, v) => int.parse(v.id),
          label: (i, v) => v.name,
        ),
        onChanged: _placeTypeChangeCallback,
      ),
    );
  }

  Widget _buildImagePart(Size size) {
    return InkWell(
      onTap: () => showModalBottomSheet(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25),
            ),
          ),
          elevation: 3,
          context: context,
          backgroundColor: Colors.white,
          builder: (ctx) => Container(
                child: _buildPictureOptions(
                  context,
                ),
              )),
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
                child: TextButton(
                  onPressed: () => showModalBottomSheet(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25),
                        ),
                      ),
                      elevation: 3,
                      context: context,
                      backgroundColor: Colors.white,
                      builder: (ctx) => Container(
                            child: _buildPictureOptions(context),
                          )),
                  child: Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: mainColor.withOpacity(.8),
                      backgroundImage: profilePic == null
                          ? null
                          : FileImage(profilePic, scale: 1),
                      child: profilePic == null
                          ? const Center(
                              child: Icon(
                                Icons.image,
                                color: Colors.white,
                                size: 38,
                              ),
                            )
                          : const SizedBox(),
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
                          child: TextButton(
                            onPressed: () {},
                            child: const Center(
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

  _buildPictureOptions(
    BuildContext context,
  ) {
    return Container(
      margin: EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(6.0),
            width: MediaQuery.of(context).size.width * 0.35,
            height: 6,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          ListView(
            padding: EdgeInsets.all(0.0),
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text(AppLocalizations.of(context).translate('camera')),
                subtitle: Text(
                    AppLocalizations.of(context).translate('pickup_camera')),
                onTap: () {
                  getImage(
                    ImageSource.camera,
                  );
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.image),
                title: Text(AppLocalizations.of(context).translate('gallery')),
                subtitle: Text(
                    AppLocalizations.of(context).translate('pickup_gallery')),
                onTap: () {
                  getImage(
                    ImageSource.gallery,
                  );
                  Navigator.pop(context);
                },
              ),
              if (_picker != null) ...[
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text(AppLocalizations.of(context).translate('delete')),
                  subtitle: Text(AppLocalizations.of(context)
                      .translate('delete_current_image')),
                  onTap: () {
                    Dialogs().deleteDialog(
                        context: context,
                        content: AppLocalizations.of(context)
                            .translate('delete_confirm'),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          _picker = null;
                          _selectedFile = null;
                          profilePic = null;
                          if (mounted) setState(() {});
                        });
                  },
                )
              ],
            ],
          ),
        ],
      ),
    );
  }

  Future<void> getImage(ImageSource source) async {
    _picker = ImagePicker();
    XFile pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      if (mounted) {
        setState(() {
          profilePic = File(pickedFile.path);
        });
      }
    }
  }

  Future<void> validateForm() async {
    AppUtils.hideKeyboard(context);
    if (_formKey.currentState.validate()) {
      if (profilePic == null) {
        AppUtils.showToast(
            msg: AppLocalizations.of(context).translate('chose_pic'));
        return;
      }

      if (_selectedType == 0) {
        String titleId = _selectedDoctorTitle.toString();
        String genderName = _selectedGender == 1 ? "male" : "female";

        var body = {
          "email": "${_emailController.text}",
          "name_en": "${_nameEnController.text}",
          "name_ar": "${_nameArController.text}",
          "password": "${_passwordController.text}",
          "password_confirmation": "${_passwordConfirmController.text}",
          "fcm_token": "$_firebaseToken",
          "title_id": "$titleId",
          "mobile": "${_mobileController.text}",
          "gender": "$genderName",
          "specialize_id[]": _selectedSpecialize
        };
        var data = dio.FormData.fromMap(body);

        dio.MultipartFile file = await dio.MultipartFile.fromFile(
            profilePic.path,
            filename: 'upload.png');
        data.files.add(MapEntry('profile_pic', file));

        _authController.register(body: data);
      } else {
        var body = {
          "email": "${_emailController.text}",
          "name_en": "${_nameEnController.text}",
          "name_ar": "${_nameArController.text}",
          "password": "${_passwordController.text}",
          "password_confirmation": "${_passwordConfirmController.text}",
          "fcm_token": "$_firebaseToken",
          "organization_type_id": "$_selectedType",
          "logo": await dio.MultipartFile.fromFile(profilePic.path,
              filename: "upload.png"),
          "specialize_id[]": _selectedSpecialize,
          "phones[]": {phoneControllers.map((e) => e.text).toList()}
        };

        var data = dio.FormData.fromMap(body);

        _authOrgController.register(
          body: data,
        );
      }
    }
  }

  void getLanguage() async {
    await SharedPreferences.getInstance().then((pref) {
      lang = pref.getString('lang');
    });
    if (mounted) setState(() {});
  }
}
