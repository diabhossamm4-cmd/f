import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:espitaliaa_doctors/getx/offer_controller.dart';
import 'package:espitaliaa_doctors/getx/org/appointment_controller.dart';
import 'package:espitaliaa_doctors/models/org/notification_model.dart';
import 'package:espitaliaa_doctors/pages/appointment/org/appointment_org_page.dart';
import 'package:espitaliaa_doctors/pages/home/org/org_main_page.dart';
import 'package:espitaliaa_doctors/pages/more/more_page.dart';
import 'package:espitaliaa_doctors/pages/notifications/notification_page.dart';
import 'package:espitaliaa_doctors/pages/offers/main_offers_page.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/utils/firebase_config.dart';
import 'package:espitaliaa_doctors/utils/local_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomeOrgPage extends StatefulWidget {
  @override
  _HomeOrgPageState createState() => _HomeOrgPageState();
}

class _HomeOrgPageState extends State<HomeOrgPage> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  PageController _pageController;
  AppointmentOrgController appointmentController = Get.put(AppointmentOrgController());
  final OfferController offerController = Get.put(OfferController());
  List<Widget> pages;
  @override
  initState() {
    pages = [
      OrgMainPage(),
      MainOffersPage(),
      AppointmentOrgPage(),
//    Container(),

      NotificationPage(
        isOrg: true,
        notificationRoute: notificationRoutes,
      ),
      MorePage(
        isOrg: true,
      ),
    ];
    initOrgData();
    super.initState();
    _pageController = PageController(initialPage: _page);
    NotificationPlugin().initializePlatformSpecifics();
    FireBaseCongigFile().initFirebaseMessages();
  }

  @override
  Widget build(BuildContext context) {
//    var networkProvider = Provider.of<NetworkProvider>(context);

    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: const SizedBox(),
        title: Text(
          _page == 0
              ? AppLocalizations.of(context).translate('profile_page')
              : _page == 1
                  ? AppLocalizations.of(context).translate('offers')
                  : _page == 2
                      ? AppLocalizations.of(context).translate('my_appointments')
                      : _page == 3
                          ? AppLocalizations.of(context).translate('notifications')
                          : AppLocalizations.of(context).translate('more'),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: _page == 0
            ? mainColor
            : _page == 1
                ? mainColor
                : _page == 2
                    ? mainColor
                    : _page == 3
                        ? mainColor
                        : mainColor,
        backgroundColor: _page == 0
            ? Colors.white
            : _page == 1
                ? Colors.white
                : _page == 2
                    ? Colors.white
                    : _page == 3
                        ? Colors.white
                        : Colors.white,
        height: ScreenUtil().setHeight(55),
        index: _page,
        key: _bottomNavigationKey,
        items: <Widget>[
          const Icon(
            FontAwesomeIcons.userMd,
            size: 25,
            color: /* _page == 1 ? Colors.black :*/ Colors.white,
          ),
          const Icon(
            Icons.local_offer,
            size: 25,
            color: /* _page == 1 ? Colors.black :*/ Colors.white,
          ),
          const Icon(
            Icons.calendar_today,
            size: 25,
            color: /* _page == 1 ? Colors.black :*/ Colors.white,
          ),
          const Icon(
            Icons.notifications,
            size: 25,
            color: /* _page == 1 ? Colors.black :*/ Colors.white,
          ),
          Icon(
            Icons.more_horiz,
            size: 25,
            color: _page == 1 ? Colors.black : Colors.white,
          ),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
            _pageController.animateToPage(
              _page,
              duration: const Duration(
                milliseconds: 400,
              ),
              curve: Curves.linear,
            );
          });
        },
      ),
      body: PageView(
        physics: bouncingScroll,
        controller: _pageController,
        children: pages,
        onPageChanged: (int page) {
          _page = page;
          setState(() {});
        },
      ),

//          : NoInternetConnectionPage(),
    );
  }

  void initOrgData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      offerController.isOrg.value = true;
      //offerController.pagingController.refresh();
      offerController.startPagingControllerListener();

      //await appointmentController.initData();
    });
  }

  notificationRoutes(NotificationData model) {
    if (model != null) {
      switch (model.actionType) {
        case "appointment":
        case "cancel_appointment":
          if (mounted) {
            setState(() {
              _page = 2;
            });
          }
          _pageController.jumpToPage(
            _page,
          );
          break;
        default:
          break;
      }
    }
  }

  @override
  void dispose() {
    if (!mounted) offerController.pagingController.dispose();
    super.dispose();
  }
}
