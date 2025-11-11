import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:dio/dio.dart' as dio;
import 'package:espitaliaa_doctors/getx/auth_controller.dart';
import 'package:espitaliaa_doctors/getx/general_data_controller.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class EditAboutDoctorInfoPage extends StatefulWidget {
  const EditAboutDoctorInfoPage({Key key}) : super(key: key);

  @override
  _EditAboutDoctorInfoPageState createState() => _EditAboutDoctorInfoPageState();
}

class _EditAboutDoctorInfoPageState extends State<EditAboutDoctorInfoPage> {
  var _selectedSpecialize = [];

  //  1 => male   ||  2 => female
  int _selectedGender = 1;

  bool _hidePassword = true;
  bool _hideConfirmPassword = true;

  int _selectedType = 0;
  int _selectedDoctorTitle = 0;
  File storedImage;

  final AuthController _authController = Get.put(AuthController());

  TextEditingController _nameArController = TextEditingController();
  TextEditingController _nameEnController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _bioArController = TextEditingController();
  TextEditingController _bioEnController = TextEditingController();

  TextEditingController _mobileController = TextEditingController();
  ImagePicker _picker;

  List<Widget> phoneWidgetsList = [];
  final textFieldFocusNode = FocusNode();

  List<TextEditingController> phoneControllers = []; //the controllers list
  int _count = 0;
  Size size;
  final _formKey = GlobalKey<FormState>();

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
  void initState() {
    super.initState();
    initUserData();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context).translate(
              'information_about',
            ),
          ),
          centerTitle: true,
        ),
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
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        wordSpacing: 2,
                        fontSize: 22,
                      ),
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        AppLocalizations.of(context).translate('register_new_account_and_book'),
                        style: const TextStyle(
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
                      icon: const Icon(
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
                    controller: _nameArController,
                    validator: (String input) {
                      if (input.isEmpty) {
                        return AppLocalizations.of(context).translate('required');
                      } else if (input.length < 2) {
                        return AppLocalizations.of(context).translate('enter_valid_name');
                      } else {
                        return null;
                      }
                    },
                    hint: AppLocalizations.of(context).translate('name_in_arabic'),
                  ),
                  divider(size),
                  MyTextFormField(
                    prefixIcon: Icons.person,
                    controller: _nameEnController,
                    validator: (String input) {
                      if (input.isEmpty) {
                        return AppLocalizations.of(context).translate('required');
                      } else if (input.length < 2) {
                        return AppLocalizations.of(context).translate('enter_valid_name');
                      } else {
                        return null;
                      }
                    },
                    hint: AppLocalizations.of(context).translate('name_in_english'),
                  ),
                  //  divider(size),
                  /*  Align(
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
                  ),*/
                  //  _buildPlaceType(),
                  Visibility(
                    visible: _authController.selectedPlaceType.value == 0,
                    child: ChipsChoiceItem(
                      list: _generalDataController.doctorsTitleList,
                      onChanged: _typeChangeCallback,
                      selectedType: _selectedDoctorTitle,
                    ),
                  ),
                  divider(size),
                  MyTextFormField(
                    prefixIcon: Icons.description,
                    controller: _bioArController,
                    validator: (String input) {
                      if (input.isEmpty) {
                        return AppLocalizations.of(context).translate('required');
                      } else if (input.length < 10) {
                        return AppLocalizations.of(context).translate('enter_valid_bio');
                      } else {
                        return null;
                      }
                    },
                    hint: AppLocalizations.of(context).translate('bio_ar_text'),
                  ),
                  divider(size),
                  MyTextFormField(
                    prefixIcon: Icons.description,
                    controller: _bioEnController,
                    hint: AppLocalizations.of(context).translate('bio_en_text'),
                    validator: (String input) {
                      if (input.isEmpty) {
                        return AppLocalizations.of(context).translate('required');
                      } else if (input.length < 10) {
                        return AppLocalizations.of(context).translate('enter_valid_bio');
                      } else {
                        return null;
                      }
                    },
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
                  ),
                  divider(size),
                  MyTextFormField(
                    prefixIcon: Icons.email,
                    hint: AppLocalizations.of(context).translate('email'),
                    controller: _emailController,
                    validator: (String input) {
                      if (input.isEmpty) {
                        return AppLocalizations.of(context).translate('required');
                      } else if (!MyPatterns.emailIsValid(input)) {
                        return AppLocalizations.of(context).translate('enter_valid_email');
                      } else {
                        return null;
                      }
                    },
                  ),
                  divider(size),
                  _authController.selectedPlaceType.value == 0
                      ? MyTextFormField(
                          prefixIcon: Icons.phone,
                          controller: _mobileController,
                          keyboardType: TextInputType.phone,
                          validator: (String input) {
                            if (input.isEmpty) {
                              return AppLocalizations.of(context).translate('required');
                            } /*else if (!MyPatterns.phoneIsValid(input)) {
                              return AppLocalizations.of(context)
                                  .translate('enter_valid_phone');
                            } */
                            else {
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

                      ///TODO solve problem inital data here
                      initialValue: _selectedSpecialize, //_selectedSpecialize,
                      okButtonLabel: AppLocalizations.of(context).translate('ok'),
                      cancelButtonLabel: AppLocalizations.of(context).translate('cancel'),
                      hintWidget: Text(
                        AppLocalizations.of(context).translate('special_select_one_or_more'),
                      ),
                      onSaved: (value) {
                        if (value == null) return;
                        setState(() {
                          _selectedSpecialize = value;
                        });
                      },
                    ),
                  ),
                  divider(size),
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
                          text: AppLocalizations.of(context).translate('save'),
                          onTap: () {
                            /*    Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => SetPasswordPage(),
                          ),
                        );*/
                            validateForm();
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
    phoneControllers = List.from(phoneControllers)..add(controller); //adding the current controller to the list

    phoneWidgetsList = List.from(phoneWidgetsList)
      ..add(Column(
        children: [
          divider(size),
          MyTextFormField(
            prefixIcon: Icons.phone,
            keyboardType: TextInputType.phone,
            controller: controller,
            swifixIcon: IconButton(
              onPressed: () {
                removePhone();
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

  void removePhone() {
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
        options: ChipsChoiceOption.listFrom<int, String>(
          source: [
            AppLocalizations.of(context).translate('clinic'),
            AppLocalizations.of(context).translate('hospital'),
            AppLocalizations.of(context).translate('lab'),
            AppLocalizations.of(context).translate('center'),
          ],
          value: (i, v) => i,
          label: (i, v) => v,
        ),
        onChanged: _placeTypeChangeCallback,
      ),
    );
  }

  Widget _buildImagePart(Size size) {
    return SizedBox(
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
                onPressed: () {
                  showModalBottomSheet(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: const RoundedRectangleBorder(
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
                          ));
                },
                child: Center(
                  child: CircleAvatar(
                      radius: 60,
                      backgroundColor: mainColor.withOpacity(.8),
                      backgroundImage: storedImage == null
                          ? CachedNetworkImageProvider(ServerVars.IMAGES_PREFIX_LINK + _authController.activeUserData.value.profilePic)
                          : FileImage(storedImage, scale: 1),
                      child:
                          const SizedBox() /*Center(
                      child: Image.network(
                        ServerVars.IMAGES_PREFIX_LINK + _authController.activeUserData.value.profilePic,
                      ),
                    ),*/
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
              ? const SizedBox.shrink()
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
                subtitle: Text(AppLocalizations.of(context).translate('pickup_camera')),
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
                subtitle: Text(AppLocalizations.of(context).translate('pickup_gallery')),
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
                  subtitle: Text(AppLocalizations.of(context).translate('delete_current_image')),
                  onTap: () {
                    Dialogs().deleteDialog(
                        context: context,
                        content: AppLocalizations.of(context).translate('delete_confirm'),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          _picker = null;
                          storedImage = null;
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
          storedImage = File(pickedFile.path);
        });
      }
    }
  }

  Future<void> validateForm() async {
    AppUtils.hideKeyboard(context);

    ///TODO to be edit here .
    /* Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => GeneralDataPage1()));*/

    if (_formKey.currentState.validate() && _selectedSpecialize.length > 0) {
      if (storedImage == null && _authController.activeUserData.value.profilePic == null) {
        AppUtils.showToast(msg: AppLocalizations.of(context).translate('chose_pic'));
        return;
      }
      Map<String, Object> body = {
        "email": "${_emailController.text}",
        "name_en": "${_nameEnController.text}",
        "request_type": "personalInfo",
        "name_ar": "${_nameArController.text}",
        'gender': "${_selectedGender == 1 ? 'male' : "female"}",
        "title_id": "$_selectedDoctorTitle",
        'bio_ar': "${_bioArController.text}",
        'bio_en': "${_bioEnController.text}",
        "mobile": "${_mobileController.text}",
        /*"profile_pic": await dio.MultipartFile.fromFile(storedImage.path,
            filename: "upload.png"),*/
        "specialize[]": _selectedSpecialize
      };
      if (storedImage != null) body['profile_pic'] = await dio.MultipartFile.fromFile(storedImage.path, filename: "upload.png");
      // var data = dio.FormData.fromMap(body);
      var data = dio.FormData.fromMap(body);

      _authController.updateInfo(body: data, isFirstTime: false);
    }
  }

  /* void validateForm2() async {
    AppUtils.hideKeyboard(context);
    if (_formKey.currentState.validate() && _selectedSpecialize.length > 0) {
      if (storedImage == null) {
        AppUtils.showToast(
            msg: AppLocalizations.of(context).translate('chose_pic'));
        return;
      }
      dio.FormData formData = dio.FormData.fromMap({
        "email": "${_emailController.text}",
        "name_en": "${_nameEnController.text}",
        "name_ar": "${_nameArController.text}",
        "password": "${_passwordController.text}",
        "password_confirmation": "${_passwordConfirmController.text}",
        "title_id": "$_selectedDoctorTitle",
        "mobile": "${_mobileController.text}",
        "gender": "${_selectedGender.toString()}",
        "specialize": "${_selectedSpecialize.toString()}",
        "profile_pic": await dio.MultipartFile.fromFile(storedImage.path,
            filename: "upload.png"),
      });
      print(
          '\n\n ---validateForm storedImage.path >>> ${storedImage.path}\n\n\n');
      dio.Dio dioo = new dio.Dio();
      await dioo
          .post('https://espitaliaa.com/api/doctor-register',
              data: formData,
              options: dio.Options(
                  followRedirects: false,
                  validateStatus: (status) {
                    return status < 500;
                  },
                  headers: {
                    "Content-Type": "application/json",
                    "Accept": "application/json, text/plain, /",
                    "X-Requested-With": "XMLHttpRequest",
                  }))
          .then((response) {
        print("RESPONSE== $response");
        Get.back();
        Get.to(() => HomePage());
      });
      // var data = dio.FormData.fromMap(body);
      // AuthController.register(body: data);
    }
  }*/

  Widget buildPhonesForms(size) {
    return Column(
      children: [
        MyTextFormField(
          prefixIcon: Icons.phone,
          controller: _mobileController,
          validator: (String input) {
            if (input.isEmpty) {
              return AppLocalizations.of(context).translate('required');
            } else {
              return null;
            }
          },
          hint: AppLocalizations.of(context).translate('phone'),
        ),
        divider(size),
        MyTextFormField(
          prefixIcon: Icons.phone,
          controller: _mobileController,
          validator: (String input) {
            if (input.isEmpty) {
              return AppLocalizations.of(context).translate('required');
            } else {
              return null;
            }
          },
          hint: AppLocalizations.of(context).translate('phone'),
        ),
        divider(size),
        MyTextFormField(
          prefixIcon: Icons.phone,
          controller: _mobileController,
          validator: (String input) {
            if (input.isEmpty) {
              return AppLocalizations.of(context).translate('required');
            } else {
              return null;
            }
          },
          hint: AppLocalizations.of(context).translate('phone'),
        ),
        divider(size),
        MyTextFormField(
          prefixIcon: Icons.phone,
          controller: _mobileController,
          validator: (String input) {
            if (input.isEmpty) {
              return AppLocalizations.of(context).translate('required');
            } else {
              return null;
            }
          },
          hint: AppLocalizations.of(context).translate('phone'),
        ),
        divider(size),
      ],
    );
  }

  void initUserData() {
    _nameArController.text = _authController.activeUserData.value.nameAr;
    _nameEnController.text = _authController.activeUserData.value.nameEn;
    _emailController.text = _authController.activeUserData.value.email;
    _mobileController.text = _authController.activeUserData.value.mobile;
    _bioArController.text = _authController.activeUserData.value.bioAr;
    _bioEnController.text = _authController.activeUserData.value.bioEn;

    ///TODO to be edit if organization
    _selectedDoctorTitle = int.parse(_authController.activeUserData.value.title.id);
    print("authController.activeUserData.value.gender= ${_authController.activeUserData.value.gender}");
    _selectedGender = _authController.activeUserData.value.gender == "male" ? 1 : 0;
    _selectedSpecialize = _authController.activeUserData.value.specializations.map((e) => e.id).toList();
    print("Our= ${_selectedSpecialize}");
    // _selectedSpecialize = x;

    // _selectedSpecialize = _authController.activeUserData.specializations;
  }
}
