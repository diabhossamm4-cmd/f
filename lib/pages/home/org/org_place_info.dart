import 'package:espitaliaa_doctors/getx/org/auth_org_controller.dart';
import 'package:espitaliaa_doctors/models/org/user_org_model.dart';
import 'package:espitaliaa_doctors/pages/doctor/org/edit_org_info.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:get/get.dart';

class OrgPlaceInfo extends StatelessWidget {
  final AuthOrgController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    String phones = "";
    UserOrgData user = userController.activeUser.value.data;
    user.phones.forEach((element) {
      phones += element + "\n\n";
    });
    return SingleChildScrollView(
      child: Column(
        children: [
          _rowInfo(
            AppLocalizations.of(context).translate('name'),
            valueTitle: '${user.name}',
            icon: true,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => EditOrganizationInfo(),
                ),
              );
            },
          ),
          _rowInfo(
            AppLocalizations.of(context).translate('address'),
            valueTitle: user.address ?? '--',
          ),
          _rowInfo(
            AppLocalizations.of(context).translate('org_info'),
            valueTitle: user.description ?? '--',
            /*onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => EditInsuranceCompanyPage(),
                ),
              );
            },*/
          ),
          /* _rowInfo(
            AppLocalizations.of(context).translate('clinic_services'),
            '$clientServices',
            */ /*onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => EditInsuranceCompanyPage(),
                ),
              );
            },*/ /*
          ),*/
          user.phones != null
              ? _rowInfo(
                  AppLocalizations.of(context).translate('doctor_mobile'),
                  subTitle: Tags(
                      alignment: WrapAlignment.start,
                      itemCount: user.phones.length,
                      itemBuilder: (int index) {
                        final item = user.phones[index];
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
                          title: item,
                        );
                      }),
                  /*onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => EditNamePhoneAssistantPage(),
              ),
            );
          }*/
                )
              : SizedBox(),
          /* _rowInfo(
            AppLocalizations.of(context).translate('detection_price'),
            '${user.price}',
            */ /*   onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => EditReservationPagePage(),
                ),
              );
            },*/ /*
          ),*/
        ],
      ),
    );
  }

  Widget _rowInfo(String title,
      {String valueTitle, bool icon, Function onTap, Widget subTitle}) {
    return ListTile(
      title:
          Padding(padding: EdgeInsets.only(bottom: 10.0.h), child: Text(title)),
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
