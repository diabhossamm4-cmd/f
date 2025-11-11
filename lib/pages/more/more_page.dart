import 'package:espitaliaa_doctors/main.dart';
import 'package:espitaliaa_doctors/models/user_model.dart';
import 'package:espitaliaa_doctors/pages/auth/organization/change_pass_screen.dart';
import 'package:espitaliaa_doctors/pages/doctor/about_espitalia.dart';
import 'package:espitaliaa_doctors/pages/more/edit_language_page.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/widgets/developed_webstdy.dart';
import 'package:espitaliaa_doctors/widgets/more_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MorePage extends StatelessWidget {
  final bool isOrg;

  MorePage({this.isOrg});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text(
//          AppLocalizations.of(context).translate('more'),
//          style: TextStyle(
//            fontWeight: FontWeight.bold,
//            fontSize: 16,
//          ),
//        ),
//        centerTitle: true,
//        elevation: 0,
//        backgroundColor: mainColor,
//      ),
//      drawer: appDrawer(context),
//      bottomNavigationBar: MyBottomNavigationBar(
//        isMore: true,
//      ),
      body: Column(
        children: [
          MoreItem(
            title: AppLocalizations.of(context).translate('change_password'),
            leadingIcon: Icons.settings,
            onTap: () {
              Get.to(() => SetNewPasswordPage(
                    isOrg: isOrg,
                  ));
//              Navigator.of(context).push(
//                MaterialPageRoute(
//                  builder: (_) => SettingPage(),
//                ),
//              );
            },
          ),
          /*      MoreItem(
            title: 'قائمة المرضى',
            leadingIcon: Icons.favorite_border,
            ///DSFKDS .COMAMED @.COMZCLCZX .SWQEL LELLLCOM .COMC AMSD,.CC .VCXMZXC..CDS .SDFEWKEWF , D DSQWE SD.SAD.COM VOOODO .1.C1 ,SDKS,SD ,SALAAHMED.COM.CCC VOOOZOO.COOC, OEWKWE,. OMOSTO VODIKO. MOST.
            onTap: () {
//              Navigator.of(context).push(
//                MaterialPageRoute(
//                  builder: (_) => FavoritesPage(),
//                ),
//              );
            },
          ),*/
          MoreItem(
            title: AppLocalizations.of(context).translate('change_the_language'),
            leadingIcon: Icons.language,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => EditLanguagePage(),
                ),
              );
            },
          ),
          MoreItem(
            title: AppLocalizations.of(context).translate('about'),
            leadingIcon: Icons.phone,
            onTap: () {
              Get.to(() => AboutUsPage());
//              Navigator.of(context).push(
//                MaterialPageRoute(
//                  builder: (_) => ContactUsPage(),
//                ),
//              );
            },
          ),
          MoreItem(
            withTrailing: false,
            title: AppLocalizations.of(context).translate('logout'),
            leadingIcon: Icons.exit_to_app,
            onTap: () {
              _logout(context);
            },
          ),
          const Spacer(),
          const DevelopedByWebStdy()
        ],
      ),
    );
  }

  void _logout(context) async {
    await UserModel().resetUser();

    MyApp.resetApp(context);

    /* Navigator.of(context).push
    Get.offAll(() => StartPage());
  */ /* if (isLogged) {
      try {
        ApiProvider().logout();
      } on SocketException catch (_) {
        await AppUtils.showNoInternectConnectiondailog(context);
      } on ApiException catch (e) {
        if (ServerVars.IS_DEBUG) print("_notificationsA ${e.toString()}");
      } catch (e, stackTrace) {
        if (ServerVars.IS_DEBUG) print("_notificationsS ${e.toString()}");
        print(e.toString());
      }
    }*/
  }
}
