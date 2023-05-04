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
                  centerTitle: 'Select Text',
                  backIcon:
                      Platform.isAndroid ? Icons.arrow_back_outlined : null,
                  onChanged: (text) {
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
                path: Images.textFileIcon,
                height: 16,
                color: AppColors.purpleColor,
              ),
              SizedBox(
                width: 10,
              ),
              AppText(
                text: 'Create Message',
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
                    return textListTile(
                      title: 'textfile_23052023',
                    );
                  }))
        ]));
  }

  textListTile({
    required String title,
  }) {
    return GestureDetector(
      onTap: () {},
      child: ListTile(
        leading: SvgPicture.asset(
          Images.textIcon,
          width: 20,
        ),
        minLeadingWidth: 10,
        title: Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: w600_14(),
        ),
      ),
    );
  }
}
