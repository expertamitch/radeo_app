import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import 'package:redeo/models/territory_list_model.dart';
import 'package:redeo/network/storage_utils.dart';
import 'package:redeo/route/routes.dart';

import '../../screens/territory/controller/territory_controller.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../app_button.dart';
import '../image_view.dart';

class TerritoryTile extends StatelessWidget {
  TerritoryInfo info;
  VoidCallback? onTap;
  TerritoryTile({required this.info, this.onTap});

  @override
  Widget build(BuildContext context) {
    String statusTitle = '';
    if (info.userId == int.parse(StorageUtils.getUid()!) &&
        info.status == 'in-use') {
      //   my territory and in use
      statusTitle = 'In use';
    } else if (info.status == 'completed')
      statusTitle = 'Completed';
    else if (int.parse(StorageUtils.getUid()!) == info.userId! && info.assignedTo==null){
    //   my territory and not assigned
      statusTitle = 'Assign';
    }
    else if(info.assignedTo!=null && int.parse(StorageUtils.getUid()!) == info.assignedTo! && info.status == 'in-use' )
      {
      //  territory assigned to me
        statusTitle = 'Complete';
      }

      return GestureDetector(
        onTap:onTap?? () {
          Get.toNamed(Routes.territoryDetailsScreen, arguments: info);
        },
        child: Container(
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: AppColors.borderGreyColor))),
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageView(
                path: info.image ?? '',
                height: 30.sp,
                width: 30.sp,
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      info.name ?? '',
                      style: w600_14(),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    if(onTap==null)
                    AppButton(
                        onPressedFunction: () {
                          /*  if (index == 0)
                          Get.toNamed(
                            Routes.listOfAddressScreen,
                          );
                        else if (index == 1) {
                          Get.toNamed(
                            Routes.contactPage,
                          );
                        }*/

                          if (info.userId == int.parse(StorageUtils.getUid()!) &&
                              info.status == 'in-use') {
                            //   my territory and in use
                          } else if (info.status == 'completed'){}

                          else if (int.parse(StorageUtils.getUid()!) == info.userId! && info.assignedTo==null){
                            //   my territory and not assigned
                            Get.toNamed(
                              Routes.contactPage,
                            )?.then((value) {
                              if (value != null) {
                                TerritoryController controller = Get.find();
                                controller.assignTerritory(
                                    id: info.id.toString(), assigned_to: value);
                              }
                            });
                          }
                          else if(info.assignedTo!=null && int.parse(StorageUtils.getUid()!) == info.assignedTo! && info.status == 'in-use' )
                          {
                            //  territory assigned to me
                            TerritoryController controller = Get.find();
                            controller.updateTerritory(
                                id: info.id.toString(), status: 'completed');
                          }





                        },
                        child: Text(
                          // index == 0
                          //     ? "In use"
                          //     : index == 1
                          //     ? "Assign"
                          //     : "Completed",
                          statusTitle,
                          style: w300_13(color: Colors.white),
                        ),
                        height: 20.h,
                        sodiumShapeBorder: true,
                        width: null,
                        buttonColor: AppColors.purpleColor)
                  ],
                ),
              ),
              if (info.userId == int.parse(StorageUtils.getUid()!))
                Text(
                  'My Territory',
                  style: w300_10(color: AppColors.redColor),
                ),
            ],
          ),
        ),
      );
  }
}
