import 'package:espitaliaa_doctors/pages/auth/upload_certificate_page.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/widgets/my_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'package:time_range/time_range.dart';

class SetDateTimePage extends StatefulWidget {
  @override
  _SetDateTimePageState createState() => _SetDateTimePageState();
}

class _SetDateTimePageState extends State<SetDateTimePage> {
  TextEditingController timeCtl = TextEditingController();

  List<String> days = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SingleChildScrollView(
      physics: bouncingScroll,
      child: Column(
        children: [
          SizedBox(
            height: size.height * .05,
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context).translate('reservation_dates'),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                wordSpacing: 2,
                fontSize: 22,
              ),
            ),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                '${AppLocalizations.of(context).translate('choose_your_reservation_dates_easily_now')}',
                style: TextStyle(
                  wordSpacing: 2,
                  color: Colors.black38,
                  fontSize: 16,
                ),
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
            height: size.height * .03,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(12),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppLocalizations.of(context).translate('date_of_reservation'),
                style: TextStyle(
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
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
              itemCount: days.length,
              itemBuilder: (context, index) {
                return Day(
                  index: index,
                  days: days,
                  selectedDay: (String selectedDay) {
                  },
                );
              },
            ),
          ),
          divider(size),
          divider(size),
          divider(size),
          TimeRange(
            fromTitle: Text(
              AppLocalizations.of(context).translate('from'),
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            toTitle: Text(
              AppLocalizations.of(context).translate('to'),
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            titlePadding: 20,
            textStyle:
                TextStyle(fontWeight: FontWeight.normal, color: Colors.black87),
            activeTextStyle:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            borderColor: Colors.black,
            backgroundColor: Colors.transparent,
            activeBackgroundColor: mainColor,
            firstTime: TimeOfDay(hour: 6, minute: 00),
            lastTime: TimeOfDay(hour: 24, minute: 00),
            timeStep: 30,
            timeBlock: 30,
            onRangeCompleted: (range) => setState(
              () => print(
                range.start.period.toString(),
              ),
            ),
          ),
          divider(size),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: ScreenUtil().setWidth(180),
              height: ScreenUtil().setHeight(50),
              margin: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(18),
                vertical: ScreenUtil().setHeight(20),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: mainColor,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        AppLocalizations.of(context)
                            .translate('add_a_reservation'),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Icon(
                        Icons.add_circle_outline,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(18),
              vertical: ScreenUtil().setHeight(12),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: MyButton(
                borderRadius: 12,
                width: ScreenUtil().setWidth(120),
                text: AppLocalizations.of(context).translate('save'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => UploadCertificatePage(),
                    ),
                  );
                },
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

class Day extends StatefulWidget {
  final int index;
  final List<String> days;
  final ValueChanged<String> selectedDay;

  const Day({
    Key key,
    this.index,
    this.days,
    this.selectedDay,
  }) : super(key: key);

  @override
  _DayState createState() => _DayState();
}

class _DayState extends State<Day> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        onPressed: () {
          _selected = !_selected;
          if (_selected) {
            widget.selectedDay(widget.days[widget.index]);
          }
          setState(() {});
        },
        child: Center(
          child: Text(
            widget.days[widget.index],
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
