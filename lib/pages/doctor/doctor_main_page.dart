import 'package:cached_network_image/cached_network_image.dart';
import 'package:espitaliaa_doctors/getx/auth_controller.dart';
import 'package:espitaliaa_doctors/getx/reverstion_appointment_controller.dart';
import 'package:espitaliaa_doctors/pages/doctor/create_appointment.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'doctor_info.dart';
import 'place_info.dart';

class DoctorMainPage extends StatefulWidget {
  @override
  _DoctorMainPageState createState() => _DoctorMainPageState();
}

class _DoctorMainPageState extends State<DoctorMainPage> with SingleTickerProviderStateMixin {
  AnimationController animController;
  Animation<double> animation;
  bool monhani = true;
  String doctorTitle;
  ScrollController _scrollController;
  AuthController userController = Get.put(AuthController());

  //  0 =>  doctor info  ||  1 =>  place info  || 2 => doctor pages.appointment
  int _selectedTap = 0;

  /// to get User Data  (profile - etc ... )
  // final AuthController _authController = Get.find();
  final _reversionController = Get.put(ReverstiotionController());

  @override
  void initState() {
    animController = AnimationController(
      duration: Duration(microseconds: 300000),
      vsync: this,
    );
    animation = Tween<double>(begin: 50.0, end: 0.0).animate(animController)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
    _reversionController.initData();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset.toInt() >= 283 && monhani == true) {
          setState(() {
            animController.forward();
            monhani = false;
          });
        } else if (_scrollController.offset.toInt() <= 283) {
          animController.reverse();
          monhani = true;
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // _reverstiotionController.initData();

    return userController.activeUserData != null
        ? Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: ScreenUtil().setHeight(60),
                          color: mainColor,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(5)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: ScreenUtil().setHeight(60),
                              ),
                              Text(
                                '${userController.activeUserData.value.name ?? ""}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              userController.activeUserData.value.title != null
                                  ? Text(
                                      '${userController.activeUserData.value.title.name ?? ''}',
                                      style: TextStyle(fontSize: 12, height: 2.0),
                                    )
                                  : SizedBox(),
                              SizedBox(
                                height: ScreenUtil().setHeight(30),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildInfoWidow(
                                    AppLocalizations.of(context).translate('seen'),
                                    '${userController.activeUserData.value.watched ?? "0"}',
                                    Icons.visibility,
                                  ),
                                  /*     _buildInfoWidow(
                              AppLocalizations.of(context)
                                  .translate('reservations'),
                              '200',
                              FontAwesomeIcons.bookMedical,
                              iconSize: 20,
                            ),*/
                                ],
                              ),
                              SizedBox(
                                height: size.height * .05,
                              ),
                              Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          child: Text(
                                            '${AppLocalizations.of(context).translate('doctor_info')}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: _selectedTap == 0 ? FontWeight.bold : FontWeight.normal,
                                              fontSize: _selectedTap == 0 ? 15 : 14,
                                            ),
                                          ),
                                          onTap: () {
                                            _selectedTap = 0;
                                            setState(() {});
                                          },
                                        ),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(6),
                                        ),
                                        AnimatedContainer(
                                          duration: Duration(milliseconds: 200),
                                          height: 1,
                                          color: _selectedTap == 0 ? mainColor : Colors.transparent,
                                          width: ScreenUtil().setWidth(120),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          child: Text(
                                            '${AppLocalizations.of(context).translate('place_info')}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: _selectedTap == 1 ? FontWeight.bold : FontWeight.normal,
                                              fontSize: _selectedTap == 1 ? 15 : 14,
                                            ),
                                          ),
                                          onTap: () {
                                            _selectedTap = 1;
                                            setState(() {});
                                          },
                                        ),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(6),
                                        ),
                                        AnimatedContainer(
                                          duration: Duration(milliseconds: 200),
                                          height: 1,
                                          color: _selectedTap == 1 ? mainColor : Colors.transparent,
                                          width: ScreenUtil().setWidth(120),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          child: Text(
                                            '${AppLocalizations.of(context).translate('my_appointments')}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: _selectedTap == 2 ? FontWeight.bold : FontWeight.normal,
                                              fontSize: _selectedTap == 2 ? 15 : 14,
                                            ),
                                          ),
                                          onTap: () {
                                            _selectedTap = 2;
                                            setState(() {});
                                          },
                                        ),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(6),
                                        ),
                                        AnimatedContainer(
                                          duration: Duration(milliseconds: 200),
                                          height: 1,
                                          color: _selectedTap == 2 ? mainColor : Colors.transparent,
                                          width: ScreenUtil().setWidth(120),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * .05,
                              ),
                              _selectedTap == 0
                                  ? DoctorInfo()
                                  : _selectedTap == 1
                                      ? PlaceInfo()
                                      : CreateAppointment()
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Obx(() {
                    return userController.activeUserData != null
                        ? Container(
                            width: ScreenUtil().setWidth(100),
                            height: ScreenUtil().setHeight(100),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: CircleAvatar(
                                    backgroundImage: userController.activeUserData.value.profilePic != null
                                        ? CachedNetworkImageProvider(
                                            ServerVars.IMAGES_PREFIX_LINK + userController.activeUserData.value.profilePic,
                                          )
                                        : const AssetImage(
                                            'assets/images/doctor_placeholder.jfif',
                                          ),
                                  ),
                                )),
                          )
                        : SizedBox();
                  })
                ],
              ),
            ),
          )
        : SizedBox();
  }

  Widget _buildInfoWidow(
    String title,
    String subTitle,
    IconData icon, {
    double iconSize,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(25),
        vertical: ScreenUtil().setHeight(15),
      ),
      //  height: ScreenUtil().setHeight(80),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 3),
            blurRadius: 7,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: mainColor,
                size: iconSize,
              ),
              SizedBox(
                width: 15,
              ),
              Text('$title'),
            ],
          ),
          SizedBox(height: ScreenUtil().setHeight(8)),
          Text(
            '$subTitle',
            style: TextStyle(color: mainColor, fontSize: ScreenUtil().setWidth(15)),
          ),
        ],
      ),
    );
  }
}
