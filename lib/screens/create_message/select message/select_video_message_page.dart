import 'dart:io';
import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:fetch_all_videos/fetch_all_videos.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redeo/widgets/loader.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../../../assets/images.dart';
import '../../../styling/app_colors.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/image_view.dart';

class SelectVideoMessagePage extends StatefulWidget {
  const SelectVideoMessagePage({Key? key}) : super(key: key);

  @override
  State<SelectVideoMessagePage> createState() => _SelectVideoMessagePageState();
}

class _SelectVideoMessagePageState extends State<SelectVideoMessagePage> {
  late TextEditingController controller;
  late List textMessagesList;
  List videos = [];
  List videosThumnails = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    textMessagesList = ['dummy text 1', 'dummy text 2', 'dummy text 3'];
    controller = TextEditingController();
    getVideos();
  }

  getVideos() async {
    FetchAllVideos ob = FetchAllVideos();
    videos = await ob.getAllVideos();

    for (var v in videos)
      videosThumnails.add(await VideoThumbnail.thumbnailFile(
        video: v,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.PNG,
        quality: 100,
      ));
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(videosThumnails.length);
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
                onChanged: (text) {
                  textMessagesList = textMessagesList
                      .where(
                          (e) => e.toLowerCase().contains(text.toLowerCase()))
                      .toList();
                  setState(() {});
                },
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
          Row(
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
          if (isLoading == false && videosThumnails.length == 0)
            Center(
              child: AppText(
                text: 'No videos found',
                textSize: 18,
                color: Colors.grey,
              ),
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
            child: Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              runAlignment: WrapAlignment.start,
              runSpacing: 10,
              spacing: 10,
              children: videosThumnails
                  .map((e) => Container(
                        color: Colors.grey,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Column(
                          children: [Image.file(File(e)), Text('video')],
                        ),
                      ))
                  .toList(),
            ),
          )
        ],
      )),
    );
  }
}
