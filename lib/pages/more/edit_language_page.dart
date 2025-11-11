import 'package:espitaliaa_doctors/main.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditLanguagePage extends StatefulWidget {
  @override
  _EditLanguagePageState createState() => _EditLanguagePageState();
}

class _EditLanguagePageState extends State<EditLanguagePage> {
  int _selectedLanguage;
  int _defaultLanguage;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _loadlang();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //var networkProvider = Provider.of<NetworkProvider>(context);
    //_selectedLanguage = myLocale=='ar'?0:1;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context).translate('change_the_language'),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: mainColor,
        ),
        body: /*networkProvider.hasNetworkConnection
          ? */
            SingleChildScrollView(
          physics: bouncingScroll,
          child: Container(
            width: size.width,
            height: size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * .15,
                ),
                Text(
                  AppLocalizations.of(context).translate('select_your_language'),
                  style: TextStyle(
                    color: Color(0xff707070),
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: size.height * .05,
                ),
                Column(
                  children: List.generate(2, (index) {
                    return languageButton(
                      size,
                      isSelected: _selectedLanguage == index,
                      title: index == 0 ? 'عربي' : 'English',
                      onTab: () {
                        _selectedLanguage = index;
                        setState(() {});
                      },
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: size.height * .05,
                ),
                MyButton(
                  text: AppLocalizations.of(context).translate('done'),
                  width: size.width * .65,
                  borderRadius: 12,
                  onTap: () async {
                    if (_defaultLanguage != _selectedLanguage) {
                      var lan = _selectedLanguage == 0 ? 'ar' : 'en';
                      await SharedPreferences.getInstance().then(
                        (pref) {
                          pref.setString(
                            'lang',
                            lan,
                          );
                          Get.updateLocale(Locale(lan));
                        },
                      );

                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => LaunchPage()));
                    }
                  },
                ),
              ],
            ),
          ),
        )
        /*: NoInternetConnectionPage(),*/
        );
  }

  Widget languageButton(
    Size size, {
    bool isSelected,
    String title,
    Function onTab,
  }) {
    return Column(
      children: [
        Container(
          width: size.width * .65,
          height: ScreenUtil().setHeight(45),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 6),
                blurRadius: 9,
              ),
            ],
            border: isSelected
                ? Border.all(
                    color: mainColor,
                    width: 1,
                  )
                : null,
            borderRadius: BorderRadius.circular(12),
          ),
          child: FlatButton(
            onPressed: onTab ?? () {},
            child: Center(
              child: Text(
                '$title',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: size.height * .02,
        ),
      ],
    );
  }

  void _loadlang() async {
    /* await SharedPreferences.getInstance().then((pref) {
      String lnagCode = pref.getString('lang');
      print("SellectedLang= ${lnagCode}");

      if (lnagCode == null) {
        _selectedLanguage = 0;
      } else if (lnagCode == 'ar') {
        _selectedLanguage = 0;
      } else {
        _selectedLanguage = 1;
      }
    });*/
    String myLocale = Localizations.localeOf(context).languageCode;
    if (myLocale == 'ar') {
      setState(() {
        _selectedLanguage = 0;
      });
    } else {
      _selectedLanguage = 1;
    }
    _defaultLanguage = _selectedLanguage;
    if (mounted) {
      setState(() {});
    }
  }
}
