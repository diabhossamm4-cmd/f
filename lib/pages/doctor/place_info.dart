import 'package:espitaliaa_doctors/getx/auth_controller.dart';
import 'package:espitaliaa_doctors/models/user_model.dart';
import 'package:espitaliaa_doctors/pages/doctor/edit_clinic_info.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:get/get.dart';

class PlaceInfo extends StatelessWidget {
  final AuthController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    UserData user = userController.activeUserData.value;
    print("user== ${user.clinicService}");
    return Column(
      children: [
        _rowInfo(
          AppLocalizations.of(context).translate('name'),
          valueTitle: '${user.name ?? "--"}',
          icon: true,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => EditClinicInfo(),
              ),
            );
          },
        ),
        SizedBox(
          height: ScreenUtil().setHeight(12),
        ),
        _rowInfo(
          AppLocalizations.of(context).translate('address'),
          valueTitle: '${user.address ?? "--"}',
        ),
        SizedBox(
          height: ScreenUtil().setHeight(12),
        ),
        _rowInfo(
          AppLocalizations.of(context).translate('clinic_info'),
          valueTitle: '${user.clinicInfo ?? "--"}',
          /*onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => EditInsuranceCompanyPage(),
              ),
            );
          },*/
        ),
        SizedBox(
          height: ScreenUtil().setHeight(12),
        ),
        Visibility(
          visible: user.clinicService != null && user.clinicService?.length > 0,
          child: _rowInfo(
            AppLocalizations.of(context).translate('clinic_services'),
            subTitle: Tags(
              alignment: WrapAlignment.start,
              itemCount: user?.clinicService?.length,
              itemBuilder: (int index) {
                final item = user.clinicService[index];
                return ItemTags(
                  index: index,
                  padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 3.0.h),
                  key: Key(index.toString()),
                  // color: Colors.white,
                  activeColor: mainColor,
                  color: mainColor,
                  textActiveColor: Colors.white,
                  textColor: Colors.white,
                  onPressed: (item) => print(item),
                  onLongPressed: (item) => print(item),
                  //                   child: ItemTags(
                  title: item,
                );
              },
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(12),
        ),
        _rowInfo(
          AppLocalizations.of(context).translate('doctor_mobile'),
          valueTitle: '${user.mobile ?? "--"}',
          /*onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => EditNamePhoneAssistantPage(),
            ),
          );
        }*/
        ),
        SizedBox(
          height: ScreenUtil().setHeight(12),
        ),
        _rowInfo(
          AppLocalizations.of(context).translate('detection_price'),
          valueTitle: '${user.price ?? "--"}',
          /*   onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => EditReservationPagePage(),
              ),
            );
          },*/
        ),
        SizedBox(
          height: 10.0,
        )
      ],
    );
  }

  Widget _rowInfo(String title, {String valueTitle, bool icon, Function onTap, Widget subTitle}) {
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
            '$valueTitle ',
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
