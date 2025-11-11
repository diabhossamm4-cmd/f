import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class DevelopedByWebStdy extends StatelessWidget {
  const DevelopedByWebStdy({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 3,
          child: Image.asset(
            'assets/images/menu_back_ground.png',
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          top: 130.0.h,
          child: GestureDetector(
            onTap: () async {
              const url = "https://webstdy.com/ar";
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw "Could not launch $url";
              }
            },
            child: Column(
              children: [
                const Text(
                  "Developed by",
                  style: TextStyle(color: Color(0xffA3A3A3)),
                ),
                SizedBox(
                  height: 10.0.h,
                ),
                SvgPicture.asset(
                  'assets/images/web_stdy_logo.svg',
                  height: 30.0.w,
                  width: 30.0.w,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
