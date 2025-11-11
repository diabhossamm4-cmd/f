import 'package:cached_network_image/cached_network_image.dart';
import 'package:espitaliaa_doctors/models/offer_model.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OfferCard extends StatelessWidget {
  final OfferData offerModel;

  OfferCard({this.offerModel});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Card(
      /*margin: EdgeInsets.only(
        top: ScreenUtil().setHeight(20),
        left: ScreenUtil().setWidth(15),
        right: ScreenUtil().setWidth(15),
      ),*/
      color: Colors.grey[100],
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  child: CachedNetworkImage(
                      imageUrl: "${ServerVars.IMAGES_PREFIX_LINK + offerModel.mainPic}",
                      width: ScreenUtil().setWidth(100),
                      height: ScreenUtil().setHeight(100),
                      errorWidget: (ctx, url, _) => Image.asset(
                            'assets/images/offer_page.png',
                            fit: BoxFit.cover,
                            width: ScreenUtil().setWidth(100),
                            height: ScreenUtil().setHeight(100),
                          )),
                ),
                SizedBox(
                  width: size.width / 40,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      cardRows(titleName: AppLocalizations.of(context).translate('offer_name'), details: Text("${offerModel.title}")),
                      const SizedBox(
                        height: 10.0,
                      ),
                      cardRows(titleName: AppLocalizations.of(context).translate('offer_price_title'), details: Text("${offerModel.discount}")),
                      const SizedBox(
                        height: 10.0,
                      ),
                      cardRows(
                          titleName: AppLocalizations.of(context).translate('offer_duration'),
                          details: Text("${offerModel.fromDate} - ${offerModel.toDate}")),
                      const SizedBox(
                        height: 10.0,
                      ),
                      cardRows(
                          titleName: AppLocalizations.of(context).translate('offer_status'),
                          details: Text(AppLocalizations.of(context).translate(offerModel.active == 1 ? "active" : "un_active")))
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget cardRows({
    String titleName,
    Widget details,
  }) {
    return Row(
      children: [
        Text(
          "$titleName :  ",
          style: TextStyle(color: mainColor, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 2.0,
        ),
        Expanded(child: details)
      ],
    );
  }
}
