import 'package:dotted_border/dotted_border.dart';
import 'package:espitaliaa_doctors/pages/auth/finish_page.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/widgets/my_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class UploadCertificatePage extends StatefulWidget {
  @override
  _UploadCertificatePageState createState() => _UploadCertificatePageState();
}

class _UploadCertificatePageState extends State<UploadCertificatePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      width: size.width,
      child: Column(
        children: [
          SizedBox(
            height: size.height * .05,
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)
                  .translate('upload_practice_license_title'),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                wordSpacing: 2,
                fontSize: 22,
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
          SizedBox(
            height: size.height * .20,
          ),
          Center(
            child: Container(
              height: ScreenUtil().setHeight(130),
              width: ScreenUtil().setWidth(200),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
                child: FlatButton(
                  onPressed: () {},
                  padding: EdgeInsets.all(1),
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
                            Image.asset(
                              'assets/images/done_upload_certificate.png',
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          divider(size),
          divider(size),
          Text(
            AppLocalizations.of(context).translate('upload_practice_license'),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(18),
                vertical: ScreenUtil().setHeight(12),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: MyButton(
                  borderRadius: 12,
                  width: ScreenUtil().setWidth(120),
                  text: AppLocalizations.of(context).translate('confirm'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => FinishPage(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget divider(Size size) {
    return SizedBox(
      height: size.height * .02,
    );
  }
}
