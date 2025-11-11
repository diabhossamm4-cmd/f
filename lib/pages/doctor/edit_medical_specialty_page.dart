import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class EditMedicalSpecialty extends StatefulWidget {
  @override
  _EditMedicalSpecialtyState createState() => _EditMedicalSpecialtyState();
}

class _EditMedicalSpecialtyState extends State<EditMedicalSpecialty> {
  List<String> areas = [
    'كل المناطق',
    'مصر الجديدة',
    'الدقي',
    'المهندسين',
    'رمسيس',
    'طنطا',
    'الاسكندرية',
  ];

  String _selectedArea = 'كل المناطق';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate(
            'medical_specialty',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: bouncingScroll,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.all(
              ScreenUtil().setWidth(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('التخصص الأساس'),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                Container(
                  color: mainColor.withOpacity(.05),
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedArea,
                      items: areas.map((String value) {
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
                  height: ScreenUtil().setHeight(50),
                ),
                Text('التخصصات الفرعية'),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(12),
                  ),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 5,
                      childAspectRatio: 3 / 1,
                    ),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: areas.length,
                    itemBuilder: (context, index) {
                      return Specialty(
                        index: index,
                        specialties: areas,
                        onSpecialtySelected: (String selectedDay) {
                          print(selectedDay);
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(80),
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
      ),
    );
  }
}

class Specialty extends StatefulWidget {
  final int index;
  final List<String> specialties;
  final ValueChanged<String> onSpecialtySelected;

  const Specialty({
    Key key,
    this.index,
    this.specialties,
    this.onSpecialtySelected,
  }) : super(key: key);

  @override
  _SpecialtyState createState() => _SpecialtyState();
}

class _SpecialtyState extends State<Specialty> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        onPressed: () {
          _selected = !_selected;
          if (_selected) {
            widget.onSpecialtySelected(widget.specialties[widget.index]);
          }
          setState(() {});
        },
        child: Center(
          child: Text(
            widget.specialties[widget.index],
            style: TextStyle(
              color: _selected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: _selected ? mainColor : Colors.white,
        border: Border.all(
          width: 1,
          color: mainColor,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
