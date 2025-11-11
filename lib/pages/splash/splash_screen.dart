import 'package:espitaliaa_doctors/getx/auth_controller.dart';
import 'package:espitaliaa_doctors/getx/org/auth_org_controller.dart';
import 'package:espitaliaa_doctors/getx/org/home_org_controllers.dart';
import 'package:espitaliaa_doctors/models/user_model.dart';
import 'package:espitaliaa_doctors/pages/auth/start_page.dart';
import 'package:espitaliaa_doctors/pages/home/home_page.dart';
import 'package:espitaliaa_doctors/pages/home/org/home_org_page.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var globalKey = RectGetter.createGlobalKey();
  Rect rect;

  // The ripple animation time (1 second)
  Duration animationDuration = Duration(milliseconds: 500);
  Duration delayTime = Duration(milliseconds: 500);
  AuthController authController = Get.put(AuthController());
  AuthOrgController authOrgController = Get.put(AuthOrgController());
  bool isOrg;
  bool isLogged = false;
  HomeOrgController _homeOrgController = Get.put(HomeOrgController());

  @override
  void initState() {
    // Check if user login or Not from sharedPrefrence.
    checkUserLogin();

    super.initState();

    // after 2 seconds run the animation effect then go to next page
    Future.delayed(Duration(seconds: 5), () {
      _makeAnimation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          body: Container(
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RectGetter(
                    key: globalKey,
                    child: Image.asset(
                      'assets/images/logo.png',
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(80),
                  ),
                  SpinKitThreeBounce(
                    color: mainColor,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
        _ripple(),
      ],
    );
  }

  // create a ripple widget to start animation from it
  Widget _ripple() {
    if (rect == null) {
      return Container();
    }

    // has the same position of fab and its shape
    // use AnimatedPosition to transition from a small dot to blue screen go smoothly
    return AnimatedPositioned(
      duration: animationDuration,
      left: rect.left,
      right: MediaQuery.of(context).size.width - rect.right,
      top: rect.top,
      bottom: MediaQuery.of(context).size.height - rect.bottom,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle, // the shape of the ripple
          color: Colors.white, // the color of the overlay
        ),
      ),
    );
  }

  void _makeAnimation() {
    // => set rect to be size of fab  (widget)
    setState(() => rect = RectGetter.getRectFromKey(globalKey));

    /*
        we cannot change the size of ripple after we set it to the original one (covering the fab).
        We need to delay it a bit, to be more specific,
        we just need a one frame delay. That’s why we will use WidgetsBinding.postFrameCallback.
         */

    // Make delay for one frame to expand the size of the ripple
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // => expand the ripple size to the logest side * 1.3 to covering whole screen
      setState(() =>
          rect = rect.inflate(1.3 * MediaQuery.of(context).size.longestSide));
      // => after delay, go to next page
      Future.delayed(animationDuration + delayTime, goToNextPage);
    });
  }

  void goToNextPage() {
    if (isLogged)
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => isOrg ? HomeOrgPage() : HomePage()));
    else
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => StartPage()));
  }

  void checkUserLogin() async {
    UserModel _user = UserModel();
    isOrg = await _user.getUserType != 'doctor';

    if (await _user.isLoggedIn && await _user.getRememberMe) {
      isLogged = true;
      if (isOrg) {
        await authOrgController.getUserProfile(isSplash: true);
        await _homeOrgController.initData();
      } else {
        await authController.getUserProfile(isSplash: true);
      }
    } else {
      isLogged = false;
      // if not loggedIn navigate to login or register

    }
  }
}
