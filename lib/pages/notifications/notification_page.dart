import 'package:espitaliaa_doctors/getx/org/notification_controller.dart';
import 'package:espitaliaa_doctors/models/org/notification_model.dart';
import 'package:espitaliaa_doctors/pages/more/no_data_found.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationPage extends StatefulWidget {
  final bool isOrg;
  final Function notificationRoute;
  NotificationPage({this.isOrg, this.notificationRoute});
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  NotificationController _controller = Get.put(NotificationController());

  @override
  void initState() {
    super.initState();
    _controller.getNotification(widget.isOrg);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          body: _controller.isLoading.value == true
              ? Center(
                  child: CupertinoActivityIndicator(
                    radius: 15.0.w,
                  ),
                )
              : _controller.notificationList == null ||
                      _controller.notificationList.length == 0
                  ? NoDataFound(title: 'no_notifications')
                  : ListView.builder(
                      physics: bouncingScroll,
                      itemCount: _controller.notificationList.length,
                      itemBuilder: (context, index) {
                        NotificationData model =
                            _controller.notificationList[index];
                        return Card(
                          margin: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(10),
                            vertical: ScreenUtil().setHeight(10),
                          ),
                          elevation: 8,
                          child: ListTile(
                            onTap: () {
                              widget.notificationRoute(model);
                            },
                            leading: Container(
                              width: ScreenUtil().setWidth(40),
                              height: ScreenUtil().setHeight(40),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: mainColor,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              '${model.title}',
                              overflow: TextOverflow.visible,
                              style:
                                  TextStyle(fontSize: ScreenUtil().setSp(13)),
                            ),
                            subtitle: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: ScreenUtil().setHeight(8),
                              ),
                              child: Text(
                                '${model.description}',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: ScreenUtil().setSp(11),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )),
    );
  }
}
