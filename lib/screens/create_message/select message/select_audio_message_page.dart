import 'dart:io';
import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../assets/images.dart';
import '../../../styling/app_colors.dart';
import '../../../styling/font_style_globle.dart';

import '../../../widgets/image_view.dart';

class SelectAudioMessage extends StatefulWidget {
  const SelectAudioMessage({Key? key}) : super(key: key);

  @override
  State<SelectAudioMessage> createState() => _SelectAudioMessageState();
}

class _SelectAudioMessageState extends State<SelectAudioMessage> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.darkGreyColor,
        appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 65),
            child: SafeArea(
                child: Container(
              decoration: const BoxDecoration(
                color: AppColors.darkGreyColor,
              ),
              alignment: Alignment.center,
              child: AnimationSearchBar(
                  searchIconColor: AppColors.purpleColor,
                  backIconColor: Colors.black,
                  centerTitle: 'Select Audio',
                  textStyle: w600_14(),
                  centerTitleStyle: w900_16(),
                  backIcon:
                      Platform.isAndroid ? Icons.arrow_back_outlined : null,
                  onChanged: (text) {
                    setState(() {});
                  },
                  searchTextEditingController: controller,
                  horizontalPadding: 5),
            ))),
        body: Container(
          color: Colors.white,
          child: Column(children: [
            SizedBox(
              height: 15.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageView(
                  path: Images.micIcon,
                  height: 16,
                  color: AppColors.purpleColor,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  'Create New Audio',
                  style: w600_14(
                    color: AppColors.purpleColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Divider(
              color: AppColors.borderGreyColor,
              thickness: 1,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return audioListTile(
                          title: 'Audiofile_23052023',
                          duration: '00:12',
                          size: '12 KB');
                    }))
          ]),
        ));
  }

  audioListTile({
    required String title,
    required String duration,
    required String size,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: AppColors.borderGreyColor))),
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 20.w,
            ),
            SvgPicture.asset(
              Images.audiFileIcon,
              width: 30,
            ),
            SizedBox(
              width: 20.w,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: w300_13(),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    duration + '  ' + size,
                    style: w300_13(color: AppColors.dark2GreyColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
