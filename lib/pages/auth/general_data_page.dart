import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:dotted_border/dotted_border.dart';
import 'package:espitaliaa_doctors/getx/auth_controller.dart';
import 'package:espitaliaa_doctors/getx/general_data_controller.dart';
import 'package:espitaliaa_doctors/models/general_model.dart';
import 'package:espitaliaa_doctors/pages/offers/add_offer_page.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/app_utils.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/utils/dialogs.dart';
import 'package:espitaliaa_doctors/widgets/build_tag_form_field.dart';
import 'package:espitaliaa_doctors/widgets/my_button.dart';
import 'package:espitaliaa_doctors/widgets/my_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:place_picker/place_picker.dart';

class GeneralDataPage extends StatefulWidget {
  @override
  _GeneralDataPageState createState() => _GeneralDataPageState();
}

class _GeneralDataPageState extends State<GeneralDataPage> {
  TextEditingController _priceController = TextEditingController();
  TextEditingController infoArController = TextEditingController();
  TextEditingController infoEnController = TextEditingController();
  TextEditingController addressArController = TextEditingController();
  TextEditingController addressEnController = TextEditingController();
  List<XFile> galleryList;

  List<String> servicesEnItemList = [];
  List<String> servicesArItemList = [];

  LocationResult selectedPlace;

  String selectedLat;
  String selectedLng;
  String _selectedGovernorates;
  String _selectedArea;
  final _generalDataController = Get.put(GeneralDataController());
  final _formKey = GlobalKey<FormState>();
  ImagePicker _picker;

  AuthController _authController = Get.put(AuthController());
  @override
  void initState() {
    super.initState();
    galleryList = [];
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
                  AppLocalizations.of(context)
                      .translate('enter_your_practical_information'),
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
                    '${AppLocalizations.of(context).translate('this_is_the_information_for_your')}${AppLocalizations.of(context).translate('clinic')}',
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
              MyTextFormField(
                prefixIcon: FontAwesomeIcons.moneyBillWave,
                controller: _priceController,
                textInputAction: TextInputAction.next,
                validator: (String input) {
                  if (input.isEmpty) {
                    return AppLocalizations.of(context).translate('required');
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.number,
                hint: AppLocalizations.of(context).translate('detection_price'),
              ),
              divider(size),
              MyTextFormField(
                prefixIcon: FontAwesomeIcons.file,
                height: 120,
                textInputAction: TextInputAction.next,
                validator: (String input) {
                  if (input.isEmpty) {
                    return AppLocalizations.of(context).translate('required');
                  } else if (input.length < 10) {
                    return AppLocalizations.of(context)
                        .translate('enter_valid_info');
                  } else {
                    return null;
                  }
                },
                controller: infoArController,
                maxLines: 5,
                hint: AppLocalizations.of(context).translate(
                  'information_about_you_in_arabic',
                ),
              ),
              divider(size),
              MyTextFormField(
                prefixIcon: FontAwesomeIcons.file,
                controller: infoEnController,
                textInputAction: TextInputAction.next,
                validator: (String input) {
                  if (input.isEmpty) {
                    return AppLocalizations.of(context).translate('required');
                  } else if (input.length < 10) {
                    return AppLocalizations.of(context)
                        .translate('enter_valid_info');
                  } else {
                    return null;
                  }
                },
                height: 120,
                maxLines: 5,
                hint: AppLocalizations.of(context)
                    .translate('information_about_you_in_english'),
              ),
              divider(size),
              BuildTagFromField(
                  hint: AppLocalizations.of(context)
                      .translate('services_in_arabic'),
                  items: servicesArItemList,
                  onRemove: (index) {
                    setState(() {
                      // required
                      servicesArItemList.removeAt(index);
                    });
                  },
                  onSubmit: (String str) {
                    // Add item to the data source.
                    setState(() {
                      // required
                      servicesArItemList.add(str);
                    });
                  }),
              divider(size),
              BuildTagFromField(
                  hint: AppLocalizations.of(context)
                      .translate('services_in_english'),
                  items: servicesEnItemList,
                  onRemove: (index) {
                    setState(() {
                      // required
                      servicesEnItemList.removeAt(index);
                    });
                  },
                  onSubmit: (String str) {
                    // Add item to the data source.
                    setState(() {
                      // required
                      servicesEnItemList.add(str);
                    });
                  }),
              divider(size),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(16),
                  ),
                  child: Text(
                    AppLocalizations.of(context).translate('place_photos'),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              divider(size),
              Container(
                height: ScreenUtil().setHeight(130),
                width: ScreenUtil().setWidth(200),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                  child: TextButton(
                    onPressed: () {
                      showModalBottomSheet(
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
                                style: TextStyle(color: mainColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
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
                            padding: EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: Container(
                              padding: EdgeInsets.all(1.0),
                              decoration: BoxDecoration(
                                  color: mainColor, shape: BoxShape.circle),
                              child: Icon(
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
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
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
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
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
                validator: (String input) {
                  if (input.isEmpty) {
                    return AppLocalizations.of(context).translate('required');
                  } else {
                    return null;
                  }
                },
                height: 70,
                controller: addressArController,
                maxLines: 2,
                hint:
                    AppLocalizations.of(context).translate('address_in_arabic'),
              ),
              divider(size),
              MyTextFormField(
                prefixIcon: FontAwesomeIcons.file,
                textInputAction: TextInputAction.next,
                height: 70,
                controller: addressEnController,
                validator: (String input) {
                  if (input.isEmpty) {
                    return AppLocalizations.of(context).translate('required');
                  } else {
                    return null;
                  }
                },
                maxLines: 2,
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
                      var poisiton = await AppUtils.determinePosition();
                      if (poisiton != null &&
                          selectedLng == null &&
                          selectedLat == null) {
                        selectedLat = poisiton.latitude.toString();
                        selectedLng = poisiton.longitude.toString();
                      }
                      showPlacePicker();
                    },
                    borderRadius: 8,
                    textStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    width: size.width / 2 - 30,
                  ),
                ),
              ),
              divider(size),
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

                      /* print(Pointer.placeType);
                      if (Pointer.placeType == 3) {
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

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.


  void showPlacePicker() async {
    double initialLang = selectedLng == null ? null : double.parse(selectedLng);
    double initialLat = selectedLat == null ? null : double.parse(selectedLat);
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlacePicker(
              "$googleMapApiKey",
              displayLocation:
                  LatLng(initialLat ?? 31.037933, initialLang ?? 31.381523),
            )));
    if (result != null) {
      selectedPlace = result;
      selectedLat = (selectedPlace.latLng.latitude).toString();
      selectedLng = (selectedPlace.latLng.longitude).toString();
      AppUtils.showToast(
          msg: "تم تحديد العنوان بنجاح", backgroundColor: Color(0xff3CDF9E));
      // Handle the result in your way
    }
  }

  Future<void> getImage(
    ImageSource source,
  ) async {
    _picker = ImagePicker();
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
      List<XFile> pickedFile = await _picker.pickMultiImage();
      if (pickedFile != null) {
        if (mounted) {
          setState(() {
            galleryList.addAll(pickedFile);
          });
        }
      }
    }
  }

  _buildPictureOptions(
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 0.0),
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
                  getImage(ImageSource.gallery);
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

  void validateAndSubmit() {
    AppUtils.hideKeyboard(context);
    if (_formKey.currentState.validate()) {
      if (servicesArItemList.length == 0 || servicesEnItemList.length == 0) {
        AppUtils.showToast(
            msg:
                AppLocalizations.of(context).translate('required_select_tags'));
        return;
      }
      if (_selectedGovernorates == null || _selectedArea == null) {
        AppUtils.showToast(
            msg:
                AppLocalizations.of(context).translate('required_select_city'));
        return;
      }

      /*   if (selectedLat == null || selectedLng == null) {
        AppUtils.showToast(msg: AppLocalizations.of(context).translate('please_select_map'));
        return;
      }*/

      servicesArItemList.map((e) => json.encode(e));
      servicesEnItemList.map((e) => json.encode(e));
      dio.FormData formData = dio.FormData();
      var body = {
        "request_type": "details",
        "clinic_info_en": "${infoEnController.text}",
        "clinic_info_ar": "${infoArController.text}",
        "clinic_service_en[]": servicesEnItemList,
        "clinic_service_ar[]": servicesArItemList,
        "address_en": "${addressEnController.text}",
        "address_ar": "${addressArController.text}",
        "price": "${_priceController.text}",
        "city_id": "$_selectedGovernorates",
        "district_id": "$_selectedArea",
        "is_emergenc": '0',
        "lat": "$selectedLat",
        "long": "$selectedLng"
      };
      formData = dio.FormData.fromMap(body);

      if (galleryList != null && galleryList.length > 0)
        galleryList.forEach((element) async {
          dio.MultipartFile file = await dio.MultipartFile.fromFile(
              element.path,
              filename: 'upload.png');
          formData.files.addAll([MapEntry('clinic_images[]', file)]);
        });
      _authController.updateInfo(body: formData, isFirstTime: true);
    }
  }

  Widget divider(Size size) {
    return SizedBox(
      height: size.height * .02,
    );
  }
}
