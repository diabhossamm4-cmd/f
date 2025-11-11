import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/widgets/my_button.dart';
import 'package:espitaliaa_doctors/widgets/my_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class EditCertificationPage extends StatefulWidget {
  @override
  _EditCertificationpageState createState() => _EditCertificationpageState();
}

class _EditCertificationpageState extends State<EditCertificationPage> {
  List<String> country = [
    'الدولة',
    'مصر الجديدة',
    'الدقي',
    'المهندسين',
    'رمسيس',
    'طنطا',
    'الاسكندرية',
  ];

  List<String> degree = [
    'الدرجة',
    'مصر الجديدة',
    'الدقي',
    'المهندسين',
    'رمسيس',
    'طنطا',
    'الاسكندرية',
  ];

  List<String> university = [
    'الجامعة',
    'مصر الجديدة',
    'الدقي',
    'المهندسين',
    'رمسيس',
    'طنطا',
    'الاسكندرية',
  ];

  String _selectedArea = 'الدولة';
  String _selectedDegree = 'الدرجة';
  String _selectedUniversity = 'الجامعة';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'المؤهلات الطبية',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: bouncingScroll,
        child: Padding(
          padding: EdgeInsets.all(
            ScreenUtil().setWidth(16),
          ),
          child: Column(
            children: [
              Container(
                color: mainColor.withOpacity(.05),
                width: MediaQuery.of(context).size.width,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedArea,
                    items: country.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                          child: Text(value),
                          margin: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(16),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String newArea) {
                      _selectedArea = newArea;
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              Container(
                color: mainColor.withOpacity(.05),
                width: MediaQuery.of(context).size.width,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedDegree,
                    items: degree.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                          child: Text(value),
                          margin: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(16),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String newArea) {
                      _selectedDegree = newArea;
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              Container(
                color: mainColor.withOpacity(.05),
                width: MediaQuery.of(context).size.width,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedUniversity,
                    items: university.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                          child: Text(value),
                          margin: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(16),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String newArea) {
                      _selectedUniversity = newArea;
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              MyDatePicker(
                text: 'السنة',
              ),
              SizedBox(
                height: ScreenUtil().setHeight(60),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(20),
                ),
                child: MyButton(
                  borderRadius: 12,
                  text: AppLocalizations.of(context).translate(
                    'save',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
