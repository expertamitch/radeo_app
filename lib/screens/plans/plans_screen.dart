import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/models/plans_model.dart';
import 'package:redeo/screens/plans/plans_controller.dart';
import 'package:redeo/styling/font_style_globle.dart';

import '../../widgets/common_app_bar.dart';
import '../../widgets/not_found_widget.dart';
import '../../widgets/on_screen_loader.dart';

class PlansScreen extends StatefulWidget {
  @override
  _PlansScreenState createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  PlansController plansController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'Subscription Plans',
        ),
        body: Column(children: [
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: Obx(() =>plansController.plansLoading.value
                ? OnScreenLoader(): plansController.plansList.isEmpty &&
                    !plansController.plansLoading.value
                ? NotFoundWidget()
                : ListView.separated(
                    padding: EdgeInsets.only(top: 26.h),
                    itemBuilder: (c, i) {
                      return getItem(plansController.plansList.value[i]);
                    },
                    separatorBuilder: (c, i) {
                      return Container(
                        height: 15.h,
                      );
                    },
                    itemCount: plansController.plansList.value.length)),
          )
        ]));
  }

  Widget getItem(PlanDetail planDetail) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Color(0XFFF1F4F8), borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:
                EdgeInsets.only(top: 8.h, bottom: 8.h, left: 16.w, right: 18.w),
            decoration: BoxDecoration(
                color: planDetail.id == plansController.activePlanId.value
                    ? Color(0XFF74167B)
                    : Color(0XFF1F1F1F),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5))),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      planDetail.name ?? '',
                      style: w600_13(color: Colors.white),
                    ),
                    if (planDetail.id == plansController.activePlanId.value)
                      SizedBox(
                        height: 4,
                      ),
                    if (planDetail.id == plansController.activePlanId.value)
                      Text(
                        'Active Now',
                        style: w300_11(color: Colors.white),
                      )
                  ],
                ),
                Spacer(),
                Text(
                  '\$${planDetail.price}',
                  style: w900_25(color: Colors.white),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                top: 16.h, bottom: 14.h, left: 16.w, right: 10.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  planDetail.details!
                      .toString()
                      .substring(1, planDetail.details!.toString().length - 1),
                  style: w300_13(color: Color(0XFF73BAD9)),
                ),
                SizedBox(
                  height: 15,
                ),
                Column(
                  children: planDetail.planPoints!
                      .map((e) => Column(
                            children: [
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                '- $e',
                                style: w300_11(color: Colors.black),
                              ),
                            ],
                          ))
                      .toList(),
                ),
                if (planDetail.id != plansController.activePlanId.value)
                  GestureDetector(
                    onTap: () async {
                     await plansController.buyPlan(planDetail.id.toString());

                     setState(() {

                     });},
                    child: Container(
                      margin: EdgeInsets.only(top: 14.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black, width: 1)),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      width: Get.width,
                      alignment: Alignment.center,
                      child: Text(
                        'Buy Now',
                        style: w300_11(),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
