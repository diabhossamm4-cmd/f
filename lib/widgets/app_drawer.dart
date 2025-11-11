import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget appDrawer(BuildContext context) {
  return Drawer(
    child: SafeArea(
      child: Column(
        children: [
          ListTile(
            title: Text(
              AppLocalizations.of(context).translate('hi'),
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            subtitle: Text(
              'هيثم محمد',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Divider(
            color: Colors.grey,
            thickness: 1,
            endIndent: ScreenUtil().setWidth(70),
            indent: ScreenUtil().setWidth(20),
          ),
          _drawerItem(
            AppLocalizations.of(context).translate('edit_my_details'),
            Icons.person,
            onTap: () {
              Navigator.of(context).pop();
//              Navigator.of(context).push(
//                MaterialPageRoute(
//                  builder: (_) => ProfilePage(),
//                ),
//              );
            },
          ),
          _drawerItem(
            AppLocalizations.of(context).translate('change_the_language'),
            Icons.language,
            onTap: () {
              Navigator.of(context).pop();
//              Navigator.of(context).push(
//                MaterialPageRoute(
//                  builder: (_) => EditLanguagePage(),
//                ),
//              );
            },
          ),
          _drawerItem(
            AppLocalizations.of(context).translate('favourites'),
            Icons.star_border,
            onTap: () {
              Navigator.of(context).pop();
//              Navigator.of(context).push(
//                MaterialPageRoute(
//                  builder: (_) => FavoritesPage(),
//                ),
//              );
            },
          ),
          _drawerItem(
            AppLocalizations.of(context).translate('contact_us'),
            Icons.phone,
            onTap: () {
              Navigator.of(context).pop();
//              Navigator.of(context).push(
//                MaterialPageRoute(
//                  builder: (_) => ContactUsPage(),
//                ),
//              );
            },
          ),
          _drawerItem(
            AppLocalizations.of(context).translate('about'),
            FontAwesomeIcons.question,
            onTap: () {
              Navigator.of(context).pop();
//              Navigator.of(context).push(
//                MaterialPageRoute(
//                  builder: (_) => AboutUsPage(),
//                ),
//              );
            },
          ),
          _drawerItem(
            AppLocalizations.of(context).translate('share_app'),
            Icons.share,
            noTrailing: true,
            onTap: () {},
          ),
          _drawerItem(
            AppLocalizations.of(context).translate('logout'),
            Icons.exit_to_app,
            noTrailing: true,
            onTap: () {
              Navigator.of(context).pop();
//              Navigator.of(context).pushAndRemoveUntil(
//                  MaterialPageRoute(
//                    builder: (_) => StartPage(),
//                  ),
//                  (_) => false);
            },
          ),
        ],
      ),
    ),
  );
}

Widget _drawerItem(
  String title,
  IconData leadingIcon, {
  Function onTap,
  bool noTrailing = false,
}) {
  return ListTile(
    onTap: onTap,
    title: Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    leading: Icon(
      leadingIcon,
      color: mainColor,
    ),
    trailing: noTrailing
        ? SizedBox.shrink()
        : IconButton(
            icon: Icon(
              Icons.arrow_right,
              color: mainColor,
            ),
            onPressed: onTap ?? () {},
          ),
  );
}
