import 'dart:io';

import 'package:espitaliaa_doctors/models/about_us_model.dart';
import 'package:espitaliaa_doctors/utils/api_provider.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/app_utils.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/utils/exceptions.dart';
import 'package:espitaliaa_doctors/widgets/loading_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  String desc;
  bool _isLoading = true;
  AboutUsModel aboutModel;
//  AboutData aboutModel;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  _initData() async {
    try {
      var model = await ApiProvider().getRequest(ServerVars.getAboutUs, isGlobalUrl: true);
      aboutModel = AboutUsModel.fromJson(model.data);
      desc = aboutModel.data.description;
    } on SocketException catch (_) {
    } on ApiException catch (e) {
      if (ServerVars.IS_DEBUG) print("_notificationsA ${e.toString()}");
      AppUtils.showToast(msg: e.toString());
    } catch (e, stackTrace) {
      if (ServerVars.IS_DEBUG) print("_notificationsS ${e.toString()}");

      // AppUtils.showToast(msg: ApiException.unknownErr);
    } finally {
      _isLoading = false;
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context).translate('about_espitaliaa'),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: mainColor,
        ),
        body: _isLoading
            ? LoadingModel(
                isLoadingDialog: true,
              )
            : Container(
                width: size.width,
                height: size.height,
                color: mainColor,
                child: SingleChildScrollView(
                  physics: bouncingScroll,
                  child: Padding(
                    padding: EdgeInsets.all(
                      ScreenUtil().setWidth(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: size.width,
                          height: size.height * .165,
                          padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(25.0),
                            bottom: ScreenUtil().setHeight(25.0),
                          ),
                          child: Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: size.height * .05,
                        ),
                        Text(
                          "$desc",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            wordSpacing: 2,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: size.height * .10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            socialMediaButton(FontAwesomeIcons.facebookF, onTap: () => AppUtils.openLink('${aboutModel.data.appFacebook}')),
                            socialMediaButton(FontAwesomeIcons.twitter, onTap: () => AppUtils.openLink('${aboutModel.data.appLinkedin}')),
                            socialMediaButton(FontAwesomeIcons.instagram, onTap: () => AppUtils.openLink('${aboutModel.data.appTwitter}')),
                            socialMediaButton(FontAwesomeIcons.linkedin, onTap: () => AppUtils.openLink('${aboutModel.data.appLinkedin}')),
                            /*socialMediaButton(FontAwesomeIcons.youtube,
                                  onTap: () => AppUtils.openLink('')),*/
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }

  Widget socialMediaButton(IconData icon, {Function onTap}) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(4),
      ),
      width: ScreenUtil().setWidth(40),
      height: ScreenUtil().setHeight(40),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: FlatButton(
          onPressed: onTap ?? () {},
          padding: EdgeInsets.all(0),
          child: Center(
            child: Icon(
              icon,
              size: 20,
              color: mainColor,
            ),
          ),
        ),
      ),
    );
  }
}
