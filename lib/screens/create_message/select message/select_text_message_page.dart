import 'dart:io';
import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:redeo/widgets/image_view.dart';
import '../../../assets/images.dart';
import '../../../styling/app_colors.dart';
import '../../../styling/font_style_globle.dart';
import '../../../widgets/app_text.dart';

class SelectTextMessagePage extends StatefulWidget {
  const SelectTextMessagePage({Key? key}) : super(key: key);

  @override
  State<SelectTextMessagePage> createState() => _SelectTextMessagePageState();
}

class _SelectTextMessagePageState extends State<SelectTextMessagePage> {
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
                  centerTitle: 'Select Text',
                  textStyle: w600_14(),
                  centerTitleStyle: w700_16(),
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
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageView(
                  path: Images.textFileIcon,
                  height: 14,
                  color: AppColors.purpleColor,
                ),
                SizedBox(
                  width: 10,
                ),
                AppText(
                  text: 'Create Message',
                  textSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.purpleColor,
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Divider(
              color: AppColors.borderGreyColor,
              thickness: 1,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return textListTile(
                        title: 'textfile_23052023',
                      );
                    }))
          ]),
        ));
  }

  textListTile({
    required String title,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: AppColors.borderGreyColor))),
        padding: EdgeInsets.symmetric(vertical: 5),
        child: ListTile(
          leading: SvgPicture.asset(
            Images.textFileIcon,
            width: 20,
          ),
          minLeadingWidth: 10,
          title: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: w500_14(),
          ),
        ),
      ),
    );
  }
}
