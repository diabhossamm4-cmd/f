import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dotted_border/dotted_border.dart';
import 'package:espitaliaa_doctors/getx/general_data_controller.dart';
import 'package:espitaliaa_doctors/getx/org/auth_org_controller.dart';
import 'package:espitaliaa_doctors/models/general_model.dart';
import 'package:espitaliaa_doctors/models/pointer.dart';
import 'package:espitaliaa_doctors/pages/offers/add_offer_page.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/app_utils.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/utils/dialogs.dart';
import 'package:espitaliaa_doctors/utils/patterns.dart';
import 'package:espitaliaa_doctors/widgets/my_button.dart';
import 'package:espitaliaa_doctors/widgets/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:place_picker/place_picker.dart';

class EditOrganizationInfo extends StatefulWidget {
  @override
  _EditOrganizationInfoState createState() => _EditOrganizationInfoState();
}

class _EditOrganizationInfoState extends State<EditOrganizationInfo> {
  final TextEditingController _infoArController = TextEditingController();
  final TextEditingController _infoEnController = TextEditingController();
  final TextEditingController _addressArController = TextEditingController();
  final TextEditingController _addressEnController = TextEditingController();
  final TextEditingController _nameArController = TextEditingController();
  final TextEditingController _nameEnController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final AuthOrgController _authController = Get.put(AuthOrgController());
  List<Widget> phoneWidgetsList = [];
  List<TextEditingController> phoneControllers = []; //the controllers list
  final textFieldFocusNode = FocusNode();
  int _count = 0;
  Size size;
  ImagePicker _picker;
  ImagePicker _galleryPicker = ImagePicker();

  File storedImage;
  String _mainImageNetwork;
  List<XFile> galleryList;
  List<String> userPhotos;
  final _formKey = GlobalKey<FormState>();

  LocationResult selectedPlace;
  String selectedLat = "";
  String selectedLng = "";
  String _selectedGovernorates;
  String _selectedArea;

  final _generalDataController = Get.put(GeneralDataController());

  @override
  void initState() {
    super.initState();
    galleryList = [];

    getPhones();

    initUserData();
  }

  void initUserData() {
    _nameArController.text = _authController.activeUserData.value.nameAr;
    _nameEnController.text = _authController.activeUserData.value.nameEn;
    _emailController.text = _authController.activeUserData.value.email;

    _infoEnController.text = _authController.activeUserData.value.descriptionEn;
    _infoArController.text = _authController.activeUserData.value.descriptionAr;
    _addressArController.text = _authController.activeUserData.value.addressAr;
    _addressEnController.text = _authController.activeUserData.value.addressEn;
    _count = _authController.activeUserData.value.phones.length - 1;
    _selectedGovernorates =
        _authController.activeUserData.value.cityId.toString();
    _selectedArea = _authController.activeUserData.value.areaId.toString();
    _generalDataController.getDistrictList(_selectedGovernorates);
    _mainImageNetwork = _authController.activeUserData.value.logo;
    userPhotos = _authController.activeUserData.value.images;

    /*_authController.activeUserData.phones.forEach((e) async {
      TextEditingController controller = TextEditingController();
      controller.text = e;
      phoneControllers.add(controller);
      await Future.delayed(Duration(seconds: 0))
          .then((value) => phoneWidgetsList.add(MyTextFormField(
                textFieldFocusNode: textFieldFocusNode,
                prefixIcon: Icons.phone,
                keyboardType: TextInputType.phone,
                swifixIcon: IconButton(
                  onPressed: () {
                    removePhone();
                  },
                  icon: Icon(Icons.remove),
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
    });

    if (mounted) setState(() {});*/
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

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
                  AppLocalizations.of(context)
                      .translate('enter_your_practical_information'),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    wordSpacing: 2,
                    fontSize: 22,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    '${AppLocalizations.of(context).translate('this_is_the_information_for_your')} ${AppLocalizations.of(context).translate('hospital')}',
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
              divider(size),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)
                          .translate('main_image_display'),
                    ),
                    storedImage == null
                        ? _mainImageNetwork == null
                            ? BuildImageProvider(
                                picker: _picker,
                                deletePickerImage: () {
                                  Dialogs().deleteDialog(
                                      context: context,
                                      content: AppLocalizations.of(context)
                                          .translate('delete_confirm'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        _picker = null;
                                        _mainImageNetwork = null;
                                        storedImage = null;

                                        if (mounted) setState(() {});
                                      });
                                },
                                getImage: getImage,
                                singleImage: true,
                              )
                            : Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: ServerVars.IMAGES_PREFIX_LINK +
                                        _mainImageNetwork,
                                    height: ScreenUtil().setHeight(80.0),
                                    width: ScreenUtil().setWidth(120.0),
                                    errorWidget: (context, _, dynamic) =>
                                        BuildImageProvider(
                                      picker: _picker,
                                      deletePickerImage: () {
                                        Dialogs().deleteDialog(
                                            context: context,
                                            content: AppLocalizations.of(
                                                    context)
                                                .translate('delete_confirm'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              _picker = null;
                                              if (mounted) setState(() {});
                                            });
                                      },
                                      singleImage: true,
                                      getImage: getImage,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      storedImage = null;
                                      _mainImageNetwork = null;
                                      setState(() {});
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(2.0),
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      child: Container(
                                        padding: const EdgeInsets.all(1.0),
                                        decoration: BoxDecoration(
                                            color: mainColor,
                                            shape: BoxShape.circle),
                                        child: const Icon(
                                          Icons.delete_rounded,
                                          color: Colors.white,
                                          size: 12.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                        : Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                  height: ScreenUtil().setHeight(80.0),
                                  width: ScreenUtil().setWidth(120.0),
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  child: BuildProfileImage(
                                      imageFile: storedImage)),
                              GestureDetector(
                                onTap: () {
                                  storedImage = null;
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: Container(
                                    padding: EdgeInsets.all(1.0),
                                    decoration: BoxDecoration(
                                        color: mainColor,
                                        shape: BoxShape.circle),
                                    child: const Icon(
                                      Icons.delete_rounded,
                                      color: Colors.white,
                                      size: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
              divider(size),
              MyTextFormField(
                prefixIcon: Icons.person,
                controller: _nameArController,
                textInputAction: TextInputAction.next,
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
              MyTextFormField(
                prefixIcon: Icons.email,
                hint: AppLocalizations.of(context).translate('email'),
                textInputAction: TextInputAction.next,
                controller: _emailController,
                validator: (String input) {
                  if (input.isEmpty) {
                    return AppLocalizations.of(context).translate('required');
                  } else if (!MyPatterns.emailIsValid(input)) {
                    return AppLocalizations.of(context)
                        .translate('enter_valid_email');
                  } else {
                    return null;
                  }
                },
              ),
              divider(size),
              MyTextFormField(
                prefixIcon: FontAwesomeIcons.file,
                height: 120,
                maxLines: 5,
                textInputAction: TextInputAction.next,
                controller: _infoArController,
                hint: AppLocalizations.of(context).translate(
                  'information_about_you_in_arabic',
                ),
                validator: (String input) {
                  if (input.isEmpty) {
                    return AppLocalizations.of(context).translate('required');
                  } else if (input.length < 2) {
                    return AppLocalizations.of(context)
                        .translate('enter_valid_name');
                  } else {
                    return null;
                  }
                },
              ),
              divider(size),
              MyTextFormField(
                prefixIcon: FontAwesomeIcons.file,
                textInputAction: TextInputAction.next,
                height: 120,
                maxLines: 5,
                controller: _infoEnController,
                validator: (String input) {
                  if (input.isEmpty) {
                    return AppLocalizations.of(context).translate('required');
                  } else if (input.length < 2) {
                    return AppLocalizations.of(context)
                        .translate('enter_valid_name');
                  } else {
                    return null;
                  }
                },
                hint: AppLocalizations.of(context)
                    .translate('information_about_you_in_english'),
              ),
              divider(size),
              // AddPhonesLists(childern: phoneWidgetsList),
              divider(size),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context).translate('place_photos'),
                    ),
                    BuildImageProvider(
                      picker: _picker,
                      deletePickerImage: () {
                        Dialogs().deleteDialog(
                            context: context,
                            content: AppLocalizations.of(context)
                                .translate('delete_confirm'),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              _picker = null;
                              _mainImageNetwork = null;
                              if (mounted) setState(() {});
                            });
                      },
                      singleImage: false,
                      getImage: getImage,
                    )
                  ],
                ),
              ),
              divider(size),
              Container(
                height: ScreenUtil().setHeight(80.0),
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(10.0)),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    return Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                            height: ScreenUtil().setHeight(80.0),
                            width: ScreenUtil().setWidth(120.0),
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            child: BuildProfileImage(
                                imageFile: galleryList[index])),
                        /* Positioned(
                                    bottom: 0.0,
                                    right: 5.0.w,
                                    child: Image.asset(
                                        'assets/images/dues_home_icon.png')),*/
                        GestureDetector(
                          onTap: () {
                            galleryList.removeAt(index);
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.all(2.0),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: Container(
                              padding: const EdgeInsets.all(1.0),
                              decoration: BoxDecoration(
                                  color: mainColor, shape: BoxShape.circle),
                              child: const Icon(
                                Icons.delete_rounded,
                                color: Colors.white,
                                size: 12.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  itemCount: galleryList.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              divider(size),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(16),
                ),
                child: Container(
                  color: mainColor.withOpacity(.08),
                  child: Row(
                    children: [
                      SizedBox(
                        width: ScreenUtil().setWidth(12),
                      ),
                      Icon(
                        Icons.location_on,
                        color: mainColor,
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(12),
                      ),
                      Container(
                        width: ScreenUtil().setWidth(1),
                        height: ScreenUtil().setHeight(30),
                        color: mainColor.withOpacity(.55),
                      ),
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedGovernorates,
                            hint: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(AppLocalizations.of(context)
                                  .translate('select_city')),
                            ),
                            items: _generalDataController.cityList
                                .map((GeneralData value) {
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
                            onChanged: (String newArea) {
                              _generalDataController.getDistrictList(newArea);
                              setState(() {
                                _selectedGovernorates = newArea;
                                _selectedArea = null;
                              });
                            },
                          ),
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
                child: Container(
                  color: mainColor.withOpacity(.08),
                  child: Row(
                    children: [
                      SizedBox(
                        width: ScreenUtil().setWidth(12),
                      ),
                      Icon(
                        Icons.location_on,
                        color: mainColor,
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(12),
                      ),
                      Container(
                        width: ScreenUtil().setWidth(1),
                        height: ScreenUtil().setHeight(30),
                        color: mainColor.withOpacity(.55),
                      ),
                      Expanded(child: Obx(() {
                        return DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedArea,
                            hint: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(AppLocalizations.of(context)
                                  .translate('select_area')),
                            ),
                            items: _generalDataController.districtList
                                .map((var value) {
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
                            onChanged: (String newArea) {
                              _selectedArea = newArea;
                              setState(() {});
                            },
                          ),
                        );
                      })),
                    ],
                  ),
                ),
              ),
              divider(size),
              MyTextFormField(
                prefixIcon: FontAwesomeIcons.file,
                textInputAction: TextInputAction.next,
                height: 70,
                controller: _addressArController,
                validator: (String input) {
                  if (input.isEmpty) {
                    return AppLocalizations.of(context).translate('required');
                  } else if (input.length < 2) {
                    return AppLocalizations.of(context)
                        .translate('enter_valid_name');
                  } else {
                    return null;
                  }
                },
                maxLines: 2,
                hint:
                    AppLocalizations.of(context).translate('address_in_arabic'),
              ),
              divider(size),
              MyTextFormField(
                prefixIcon: FontAwesomeIcons.file,
                textInputAction: TextInputAction.done,
                height: 70,
                maxLines: 2,
                controller: _addressEnController,
                validator: (String input) {
                  if (input.isEmpty) {
                    return AppLocalizations.of(context).translate('required');
                  } else if (input.length < 2) {
                    return AppLocalizations.of(context)
                        .translate('enter_valid_name');
                  } else {
                    return null;
                  }
                },
                hint: AppLocalizations.of(context)
                    .translate('address_in_english'),
              ),
              divider(size),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(16),
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: MyButton(
                    text: AppLocalizations.of(context).translate(
                      'take_the_coordinates_of_my_site',
                    ),
                    onTap: () async {
                      /* var poisiton = await AppUtils.determinePosition();
                      if (poisiton != null &&
                          selectedLng == null &&
                          selectedLat == null) {
                        selectedLat = poisiton.latitude.toString();
                        selectedLng = poisiton.longitude.toString();
                      }*/
                      showPlacePicker();
                    },
                    borderRadius: 8,
                    textStyle: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    width: size.width / 2 - 30,
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
                    text: AppLocalizations.of(context).translate('save'),
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

  void showPlacePicker() async {
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlacePicker(
              "$googleMapApiKey",
              displayLocation: const LatLng(31.037933, 31.381523),
            )));
    selectedPlace = result;
    selectedLat = (selectedPlace.latLng.latitude).toString();
    selectedLng = (selectedPlace.latLng.longitude).toString();

    AppUtils.showToast(
        msg: "تم تحديد العنوان بنجاح", backgroundColor: Color(0xff3CDF9E));
    // Handle the result in your way
    print(result);
  }

  Widget divider(Size size) {
    return SizedBox(
      height: size.height * .02,
    );
  }

  Future<void> getImage(ImageSource source, bool singleImage) async {
    _picker = ImagePicker();
    if (singleImage) {
      XFile pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        if (mounted) {
          setState(() {
            storedImage = File(pickedFile.path);
          });
        }
      }
    } else {
      if (source == ImageSource.camera) {
        XFile pickedFile = await _picker.pickImage(source: source);
        if (pickedFile != null) {
          if (mounted) {
            setState(() {
              galleryList.add(pickedFile);
            });
          }
        }
      } else {
        final List<XFile> images = await _galleryPicker.pickMultiImage();
        if (images != null) {
          if (mounted) {
            setState(() {
              galleryList.addAll(images);
              /*  galleryList.addAll((images.map((element) {
              File(element.path);
            }).toList()));*/
            });
          }
        }
      }
    }
  }

  void validateAndSubmit() async {
    AppUtils.hideKeyboard(context);
    if (_formKey.currentState.validate()) {
      Map<String, Object> body = {
        "request_type": "personalInfo",
        "name_ar": "${_nameArController.text}",
        "name_en": "${_nameEnController.text}",
        "email": "${_emailController.text}",
        "description_en": "${_infoEnController.text}",
        "description_ar": "${_infoArController.text}",
        "address_en": "${_addressEnController.text}",
        "address_ar": "${_addressArController.text}",
        "lng": "$selectedLng",
        "lat": "$selectedLat",
        "city_id": "$_selectedGovernorates",
        "district_id": "$_selectedArea",
      };
      if (storedImage != null)
        body['logo'] = await dio.MultipartFile.fromFile(storedImage.path,
            filename: "upload.png");
      var data = dio.FormData.fromMap(body);

      if (galleryList != null && galleryList.length > 0)
        galleryList.forEach((element) async {
          dio.MultipartFile file = await dio.MultipartFile.fromFile(
              element.path,
              filename: 'upload.png');
          data.files.addAll([MapEntry('images[]', file)]);
        });
      _authController.updateInfo(context, body: data, isFirstTime: false);
    }
  }

  void _addPhone() {
    // Unfocus all focus nodes
    textFieldFocusNode.unfocus();

    // Disable text field's focus node request
    textFieldFocusNode.canRequestFocus = false;

    //Enable the text field's focus node request after some delay
    Future.delayed(const Duration(milliseconds: 100), () {
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
    Future.delayed(const Duration(milliseconds: 100), () {
      textFieldFocusNode.canRequestFocus = true;
    });

    if (phoneWidgetsList.length > 0) {
      phoneWidgetsList = List.from(phoneWidgetsList)..removeAt(_count);
      phoneControllers = List.from(phoneControllers)..removeAt(_count);

      setState(() {
        _count--;
      });
    }
  }

  Future<void> getPhones() async {
    _count = _authController.activeUserData.value.phones.length - 1;
    TextEditingController controller = TextEditingController();
    phoneControllers.add(controller);

    await Future.delayed(const Duration(seconds: 0))
        .then((value) => phoneWidgetsList.add(Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: MyTextFormField(
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
              ),
            )));
  }
}

class BuildImageProvider extends StatelessWidget {
  final ImagePicker picker;
  final deletePickerImage;
  final getImage;
  final singleImage;
  BuildImageProvider(
      {@required this.picker,
      @required this.deletePickerImage,
      @required this.getImage,
      @required this.singleImage});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(110),
        width: ScreenUtil().setWidth(200),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(6),
          ),
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
                        child: _buildPictureOptions(context, singleImage),
                      ));
            },
            child: Center(
              child: DottedBorder(
                borderType: BorderType.Rect,
                color: mainColor,
                radius: Radius.circular(12),
                padding: EdgeInsets.all(6),
                child: Container(
                  height: ScreenUtil().setHeight(130),
                  width: ScreenUtil().setWidth(200),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload,
                        color: mainColor,
                      ),
                      Text(
                        AppLocalizations.of(context)
                            .translate('click_to_choose_an_image'),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildPictureOptions(BuildContext context, bool singleImage) {
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
                  getImage(ImageSource.camera, singleImage);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.image),
                title: Text(AppLocalizations.of(context).translate('gallery')),
                subtitle: Text(
                    AppLocalizations.of(context).translate('pickup_gallery')),
                onTap: () {
                  getImage(ImageSource.gallery, singleImage);
                  Navigator.pop(context);
                },
              ),
              if (picker != null) ...[
                ListTile(
                    leading: Icon(Icons.delete),
                    title:
                        Text(AppLocalizations.of(context).translate('delete')),
                    subtitle: Text(AppLocalizations.of(context)
                        .translate('delete_current_image')),
                    onTap: deletePickerImage)
              ],
            ],
          ),
        ],
      ),
    );
  }
}
