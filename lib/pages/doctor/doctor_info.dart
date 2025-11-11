import 'package:espitaliaa_doctors/getx/auth_controller.dart';
import 'package:espitaliaa_doctors/models/user_model.dart';
import 'package:espitaliaa_doctors/pages/doctor/edit_about_doctor_info.dart';
import 'package:espitaliaa_doctors/pages/doctor/edit_certification_page.dart';
import 'package:espitaliaa_doctors/pages/doctor/edit_medical_specialty_page.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tags/flutter_tags.dart';

import 'package:get/get.dart';

class DoctorInfo extends StatelessWidget {
  final AuthController userController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      userController.activeUserData != null
          ? () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _rowInfo(
                      '${AppLocalizations.of(context).translate('doctor_info')}',
                      valueSubTitle:
                          '${userController.activeUserData.value.bio ?? "--"}',
                      icon: true, onTap: () {
                    Get.to(EditAboutDoctorInfoPage());
                  }),
                  SizedBox(
                    height: ScreenUtil().setHeight(12),
                  ),
                  userController.activeUserData.value.specializations != null
                      ? _rowInfo(
                          AppLocalizations.of(context)
                              .translate('medical_specialty'),
                          subTitle: Tags(
                              alignment: WrapAlignment.start,
                              itemCount: userController
                                  .activeUserData.value.specializations.length,
                              itemBuilder: (int index) {
                                final item = userController.activeUserData.value
                                    .specializations[index];
                                return ItemTags(
                                  index: index,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0.w, vertical: 3.0.h),
                                  key: Key(index.toString()),
                                  // color: Colors.white,
                                  activeColor: mainColor,
                                  color: mainColor,
                                  textActiveColor: Colors.white,
                                  textColor: Colors.white,
                                  onPressed: (item) => print(item),
                                  onLongPressed: (item) => print(item),
                                  //                   child: ItemTags(
                                  title: item.name,
                                );
                              }))
                      : SizedBox(),
                  userController.activeUserData.value.title != null
                      ? _rowInfo(
                          AppLocalizations.of(context)
                              .translate('medical_qualification'),
                          valueSubTitle:
                              '${userController.activeUserData.value.title.name}',
                        )
                      : SizedBox(),
                  SizedBox(
                    height: ScreenUtil().setHeight(12),
                  ),
                ],
              )
          : SizedBox(),
    );
  }

  Widget _rowInfo(String title,
      {String valueSubTitle, bool icon, Function onTap, Widget subTitle}) {
    return ListTile(
      title: Padding(
        padding: EdgeInsets.only(bottom: 10.0.h),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 17.0.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      subtitle: subTitle ??
          Text(
            '$valueSubTitle ',
            style: TextStyle(fontSize: 15.0.sp, height: 1.5),
          ),
      trailing: icon != null
          ? Icon(
              Icons.edit,
              color: mainColor,
            )
          : SizedBox(),
      onTap: onTap ?? () {},
    );
  }
}
