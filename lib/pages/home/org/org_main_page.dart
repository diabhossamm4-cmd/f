import 'package:cached_network_image/cached_network_image.dart';
import 'package:espitaliaa_doctors/getx/org/auth_org_controller.dart';
import 'package:espitaliaa_doctors/pages/doctor/org/add_doctor_page.dart';
import 'package:espitaliaa_doctors/pages/home/org/add_service_page.dart';
import 'package:espitaliaa_doctors/pages/home/org/doctors.dart';
import 'package:espitaliaa_doctors/pages/home/org/org_place_info.dart';
import 'package:espitaliaa_doctors/pages/home/org/services.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrgMainPage extends StatefulWidget {
  @override
  _OrgMainPageState createState() => _OrgMainPageState();
}

class _OrgMainPageState extends State<OrgMainPage> with SingleTickerProviderStateMixin {
  AnimationController animController;
  Animation<double> animation;
  bool monhani = true;
  String doctorTitle;
  ScrollController _scrollController;
  final AuthOrgController userController = Get.put(AuthOrgController());

  //  0 =>  doctor info  ||  1 =>  place info  || 2 => doctor pages.appointment
  int _selectedTap = 0;

  /// to get User Data  (profile - etc ... )
  // final AuthController _authController = Get.find();
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

    if (userController.activeUserData != null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: ScreenUtil().setHeight(30),
                    color: mainColor,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(5)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: ScreenUtil().setHeight(60),
                          ),
                          Text(
                            '${userController.activeUserData.value.nameAr}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${userController.activeUserData.value.descriptionAr ?? ''}',
                            style: const TextStyle(fontSize: 12, height: 2.0),
                          ),
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
                                        '${AppLocalizations.of(context).translate('doctors_list')}',
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
                                      duration: const Duration(milliseconds: 200),
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
                                        '${AppLocalizations.of(context).translate('services')}',
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
                                      duration: const Duration(milliseconds: 200),
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
                              ? Expanded(child: DoctorList())
                              : _selectedTap == 1
                                  ? Expanded(child: OrgPlaceInfo())
                                  : Expanded(child: ServicesList())
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Obx(() {
              return userController.activeUserData != null
                  ? Container(
                      width: ScreenUtil().setWidth(100),
                      height: ScreenUtil().setHeight(80),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: CircleAvatar(
                            backgroundImage: userController.activeUserData.value.logo != null
                                ? CachedNetworkImageProvider(ServerVars.IMAGES_PREFIX_LINK + userController.activeUserData.value.logo)
                                : const AssetImage(
                                    'assets/images/doctor_placeholder.jfif',
                                  ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox();
            })
          ],
        ),
        floatingActionButton: _selectedTap == 0 || _selectedTap == 2
            ? FloatingActionButton(
                onPressed: () {
                  _selectedTap == 0 ? Get.to(AddDoctorPage()) : Get.to(AddServicePage());
                },
                child: Icon(Icons.add),
                backgroundColor: mainColor,
              )
            : null,
      );
    } else {
      return SizedBox();
    }
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
        vertical: ScreenUtil().setHeight(12),
      ),
      //  height: ScreenUtil().setHeight(80),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const [
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
              const SizedBox(
                width: 15,
              ),
              Text('$title'),
            ],
          ),
          SizedBox(height: ScreenUtil().setHeight(8)),
          Text(
            '$subTitle',
            style: TextStyle(color: mainColor, fontSize: ScreenUtil().setWidth(18)),
          ),
        ],
      ),
    );
  }
}
