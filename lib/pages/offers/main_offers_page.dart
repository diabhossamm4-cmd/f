import 'package:espitaliaa_doctors/getx/offer_controller.dart';
import 'package:espitaliaa_doctors/models/offer_model.dart';
import 'package:espitaliaa_doctors/pages/more/no_data_found.dart';
import 'package:espitaliaa_doctors/pages/offers/add_offer_page.dart';
import 'package:espitaliaa_doctors/pages/offers/offers_card.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../widgets/loading_model.dart';

class MainOffersPage extends StatefulWidget {
  final bool isOrg;

  MainOffersPage({this.isOrg}) {
    //  offerController.startPagingControllerListener();
  }

  @override
  _MainOffersPageState createState() => _MainOffersPageState();
}

class _MainOffersPageState extends State<MainOffersPage> {
  final offerController = Get.put(OfferController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FloatingActionButton(
            elevation: 1.0,
            onPressed: () {
              // Add your onPressed code here!
              Get.to(() => AddOfferPage());
            },
            child: const Icon(Icons.add),
            backgroundColor: mainColor,
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            offerController.pagingController.refresh();
          },
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: AnimationLimiter(
              child: PagedListView<int, OfferData>(
                  pagingController: offerController.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<OfferData>(
                      noItemsFoundIndicatorBuilder: (_) => NoDataFound(
                            title: "no_offers",
                          ),
                      firstPageProgressIndicatorBuilder: (_) => const LoadingModel(
                            isLoadingDialog: true,
                          ),
                      firstPageErrorIndicatorBuilder: (_) => NoDataFound(
                            title: "no_offers",
                          ),
                      newPageErrorIndicatorBuilder: (_) => NoDataFound(
                            title: "no_offers",
                          ),
                      itemBuilder: (context, item, index) {
                        var model = item;
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: OfferCard(
                                offerModel: model,
                              ),
                            ),
                          ),
                        );
                      })),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    if (!mounted) offerController.pagingController.dispose();
    super.dispose();
  }
}
