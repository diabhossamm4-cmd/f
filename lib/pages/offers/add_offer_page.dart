import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:dotted_border/dotted_border.dart';
import 'package:espitaliaa_doctors/getx/offer_controller.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/app_utils.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/utils/dialogs.dart';
import 'package:espitaliaa_doctors/widgets/my_button.dart';
import 'package:espitaliaa_doctors/widgets/my_date_picker.dart';
import 'package:espitaliaa_doctors/widgets/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as intl;
import 'package:intl/intl.dart';

class AddOfferPage extends StatefulWidget {
  @override
  _AddOfferPageState createState() => _AddOfferPageState();
}

class _AddOfferPageState extends State<AddOfferPage> {
  TextEditingController titleArController = TextEditingController();
  TextEditingController titleEnController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController detailsArController = TextEditingController();
  TextEditingController detailsEnController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  OfferController _offerController = Get.put(OfferController());
  ImagePicker _picker;
  ImagePicker _galleryPicker = ImagePicker();

  File storedImage;
  List<XFile> galleryList;
  DateTime startDate;

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * .05,
              ),
              ListTile(
                title: Text(
                  AppLocalizations.of(context).translate('create_an_offer'),
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
                    AppLocalizations.of(context)
                        .translate('add_the_following_data'),
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
              MyTextFormField(
                prefixIcon: FontAwesomeIcons.alignRight,
                controller: titleArController,
                textInputAction: TextInputAction.next,
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
                hint: AppLocalizations.of(context).translate(
                    'enter_the_main_title_of_the_presentation_in_arabic'),
                height: 60,
                maxLines: 2,
                iconSize: 20,
              ),
              divider(size),
              MyTextFormField(
                prefixIcon: FontAwesomeIcons.alignLeft,
                controller: titleEnController,
                textInputAction: TextInputAction.next,
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
                hint: AppLocalizations.of(context).translate(
                    'enter_the_main_title_of_the_presentation_in_english'),
                height: 60,
                maxLines: 2,
                iconSize: 20,
              ),
              divider(size),
              MyDatePicker(
                text: AppLocalizations.of(context)
                    .translate('enter_the_start_date_of_the_show'),
                controller: startDateController,
                isStartDate: true,
                startDate: startDate,
                onDateChanged: (DateTime date) {
                  setState(() {
                    final f = new DateFormat('yyyy-MM-dd ');
                    String dateTime = f.format(date);
                    startDate = date;
                    startDateController.text = dateTime;
                  });
                },
                validator: (String input) {
                  if (input.isEmpty) {
                    return AppLocalizations.of(context).translate('required');
                  } else {
                    return null;
                  }
                },
              ),
              divider(size),
              MyDatePicker(
                text: AppLocalizations.of(context)
                    .translate('enter_the_end_date_of_the_show'),
                controller: endDateController,
                startDate: startDate,
                isStartDate: false,
                onDateChanged: (date) {
                  setState(() {
                    final f = new DateFormat('yyyy-MM-dd ');
                    String dateTime = f.format(date);

                    endDateController.text = dateTime;
                  });
                },
                validator: (String input) {
                  if (input.isEmpty) {
                    return AppLocalizations.of(context).translate('required');
                  } else {
                    return null;
                  }
                },
              ),
              divider(size),
              MyTextFormField(
                iconSize: 20,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                prefixIcon: FontAwesomeIcons.moneyBillWave,
                hint: AppLocalizations.of(context).translate('detection_price'),
                controller: priceController,
                validator: (String input) {
                  if (input.isEmpty) {
                    return AppLocalizations.of(context).translate('required');
                  } else {
                    return null;
                  }
                },
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
                hint: AppLocalizations.of(context).translate(
                    'enter_full_details_and_information_about_the_offer_in_arabic'),
                maxLines: 5,
                height: 100,
              ),
              divider(size),
              MyTextFormField(
                iconSize: 20,
                prefixIcon: FontAwesomeIcons.fileMedical,
                maxLines: 5,
                height: 100,
                textInputAction: TextInputAction.done,
                controller: detailsEnController,
                validator: (String input) {
                  if (input.isEmpty) {
                    return AppLocalizations.of(context).translate('required');
                  } else {
                    return null;
                  }
                },
                hint: AppLocalizations.of(context).translate(
                    'enter_full_details_and_information_about_the_offer_in_english'),
              ),
              divider(size),
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
                        ? GestureDetector(
                            onTap: () {},
                            child: SizedBox(
                              height: ScreenUtil().setHeight(110),
                              width: ScreenUtil().setWidth(200),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(6),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
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
                                                  context, true),
                                            ));
                                  },
                                  child: Center(
                                    child: DottedBorder(
                                      borderType: BorderType.Rect,
                                      color: mainColor,
                                      radius: const Radius.circular(12),
                                      padding: const EdgeInsets.all(6),
                                      child: Container(
                                        height: ScreenUtil().setHeight(130),
                                        width: ScreenUtil().setWidth(200),
                                        color: Colors.white,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.cloud_upload,
                                              color: mainColor,
                                            ),
                                            Text(
                                              AppLocalizations.of(context)
                                                  .translate(
                                                      'click_to_choose_an_image'),
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
                              /* Positioned(
                                    bottom: 0.0,
                                    right: 5.0.w,
                                    child: Image.asset(
                                        'assets/images/dues_home_icon.png')),*/
                              GestureDetector(
                                onTap: () {
                                  storedImage = null;
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
                          ),
                  ],
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
                      AppLocalizations.of(context).translate('display_photos'),
                    ),
                    GestureDetector(
                      child: SizedBox(
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
                                        child: _buildPictureOptions(
                                            context, false),
                                      ));
                            },
                            child: Center(
                              child: DottedBorder(
                                borderType: BorderType.Rect,
                                color: mainColor,
                                radius: const Radius.circular(12),
                                padding: const EdgeInsets.all(6),
                                child: Container(
                                  height: ScreenUtil().setHeight(130),
                                  width: ScreenUtil().setWidth(200),
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.cloud_upload,
                                        color: mainColor,
                                      ),
                                      Text(
                                        AppLocalizations.of(context).translate(
                                            'click_to_select_images'),
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
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
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
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
              divider(size),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton(
                    text: 'Create',
                    onTap: () {
                      validateAndSubmit();
                    },
                    borderRadius: 12,
                    width: ScreenUtil().setWidth(150),
                  ),
                  MyButton(
                    text: AppLocalizations.of(context).translate('cancel'),
                    width: ScreenUtil().setWidth(150),
                    borderRadius: 12,
                    buttonColor: Colors.grey,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              divider(size),
              divider(size),
            ],
          ),
        ),
      ),
    );
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = intl.DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  void validateAndSubmit() async {
    AppUtils.hideKeyboard(context);
    if (_formKey.currentState.validate()) {
      if (storedImage == null) {
        Get.showSnackbar(GetBar(
          duration: Duration(seconds: 3),
          message:
              "${AppLocalizations.of(context).translate('main_image_validation')}",
        ));
        return;
      }
      dio.FormData formData = dio.FormData();

      var body = {
        "title_en": "${titleEnController.text}",
        "title_ar": "${titleArController.text}",
        "description_en": "${detailsEnController.text}",
        "description_ar": "${detailsArController.text}",
        "discount": "${priceController.text}",
        "from_date": "${startDateController.text}",
        "to_date": "${endDateController.text}",
      };
      formData = dio.FormData.fromMap(body);
      dio.MultipartFile file = await dio.MultipartFile.fromFile(
          storedImage.path,
          filename: 'upload.png');
      formData.files.add(MapEntry('main_pic', file));

      if (galleryList != null && galleryList.length > 0)
        galleryList.forEach((element) async {
          dio.MultipartFile file = await dio.MultipartFile.fromFile(
              element.path,
              filename: 'upload.png');
          formData.files.addAll([MapEntry('images[]', file)]);
        });
      _offerController.addNewOffer(context, body: formData);
    }
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
      }
      else{

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
    }}
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
}

class BuildProfileImage extends StatelessWidget {
  final imageFile;

  BuildProfileImage({@required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.file(
        File(imageFile.path),
        fit: BoxFit.cover,
/*      width: 70,
        height: 70,*/
      ),
    );
  }
}
