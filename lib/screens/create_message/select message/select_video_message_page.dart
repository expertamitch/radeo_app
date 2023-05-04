import 'dart:io';
import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:redeo/styling/font_style_globle.dart';
import '../../../../assets/images.dart';
import '../../../../styling/app_colors.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/image_view.dart';

class SelectVideoMessagePage extends StatefulWidget {
  const SelectVideoMessagePage({Key? key}) : super(key: key);

  @override
  State<SelectVideoMessagePage> createState() => _SelectVideoMessagePageState();
}

class _SelectVideoMessagePageState extends State<SelectVideoMessagePage> {
  late TextEditingController controller;
  List allVideosData = [
    {'thumbnailPath': 'assets/dummy_data/video 01.png', 'name': 'video 01'},
    {'thumbnailPath': 'assets/dummy_data/video 02.png', 'name': 'video 02'},
    {'thumbnailPath': 'assets/dummy_data/video 03.png', 'name': 'video 03'},
    {'thumbnailPath': 'assets/dummy_data/video 04.png', 'name': 'video 04'}
  ];

  int? selectedVideoIndex;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();

    // controller.addListener(() {
    //   filteredVideosPaths = allVideosPaths.where((e) {
    //     String fileName = e.split('/').last;
    //     return fileName.toLowerCase().contains(controller.text.toLowerCase());
    //   }).toList();
    //   setState(() {});
    // });
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
                centerTitle: 'Select Video',
                backIcon: Platform.isAndroid ? Icons.arrow_back_outlined : null,
                onChanged: (p0) {},
                searchTextEditingController: controller,
                horizontalPadding: 5),
          ))),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () async {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageView(
                  path: Images.videoIcon,
                  height: 16,
                  color: AppColors.purpleColor,
                ),
                SizedBox(
                  width: 10,
                ),
                AppText(
                  text: 'Create New Video',
                  textSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.purpleColor,
                ),
              ],
            ),
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
          if (isLoading)
            Center(
                child: SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                color: AppColors.purpleColor,
              ),
            )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Wrap(
                  alignment: allVideosData.length == 2
                      ? WrapAlignment.start
                      : WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runAlignment: allVideosData.length == 2
                      ? WrapAlignment.start
                      : WrapAlignment.spaceBetween,
                  runSpacing: 10,
                  spacing: 10,
                  children: List.generate(
                      allVideosData.length,
                      (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                if (selectedVideoIndex == index) {
                                  selectedVideoIndex = null;
                                } else {
                                  selectedVideoIndex = index;
                                }
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.27,
                              child: Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        ImageView(
                                          path: allVideosData.elementAt(
                                              index)['thumbnailPath'],
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.26,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.27,
                                        ),
                                        if (selectedVideoIndex == index)
                                          Container(
                                            color: AppColors.purpleColor
                                                .withOpacity(.38),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.26,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.27,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                ImageView(
                                                  path: Images.selectIcon,
                                                  width: 25,
                                                  height: 25,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                        Positioned(
                                          bottom: 5,
                                          left: 10,
                                          child: ImageView(
                                            path: Images.videoIcon,
                                            color: Colors.white,
                                            width: 15,
                                            height: 15,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      allVideosData.elementAt(index)['name'],
                                      style: w600_14(),
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ))),
            ),
          )
        ],
      )),
    );
  }
}