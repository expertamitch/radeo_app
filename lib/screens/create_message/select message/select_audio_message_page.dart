import 'dart:io';
import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../assets/images.dart';
import '../../../styling/app_colors.dart';
import '../../../styling/font_style_globle.dart';
import '../../../widgets/app_text.dart';

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
        appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 65),
            child: SafeArea(
                child: Container(
              decoration: const BoxDecoration(
                color: AppColors.darkGreyColor,
              ),
              alignment: Alignment.center,
              child: AnimationSearchBar(
                  backIconColor: Colors.black,
                  centerTitle: 'Select Audio',
                  backIcon:
                      Platform.isAndroid ? Icons.arrow_back_outlined : null,
                  onChanged: (text) {
                    // textMessagesList = textMessagesList
                    //     .where(
                    //         (e) => e.toLowerCase().contains(text.toLowerCase()))
                    //     .toList();
                    setState(() {});
                  },
                  searchTextEditingController: controller,
                  horizontalPadding: 5),
            ))),
        body: Column(children: [
          SizedBox(
            height: 15,
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
                width: 10,
              ),
              AppText(
                text: 'Create New Audio',
                textSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.purpleColor,
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            color: AppColors.greyColor,
            thickness: 1,
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
              child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      Divider(color: AppColors.greyColor),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return audioListTile(
                        title: 'textfile_23052023',
                        duration: '00:12',
                        size: '12 KB');
                  }))
        ]));
  }

  audioListTile({
    required String title,
    required String duration,
    required String size,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.greyColor))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
            ),
            SvgPicture.asset(
              Images.audiFileIcon,
              width: 35,
            ),
            SizedBox(
              width: 20,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: w500_14(),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    duration + '  ' + size,
                    style: w500_12(color: AppColors.dark2GreyColor),
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
