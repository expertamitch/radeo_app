import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../assets/images.dart';
import '../styling/app_colors.dart';
import '../styling/font_style_globle.dart';
import 'image_view.dart';

class AttachmentWidget extends StatelessWidget {
  String title, hint;
  String? attachment;

  Function(String?) filePickedCallback;

  AttachmentWidget(
      {required this.hint,
      required this.title,
      required this.filePickedCallback,
        required   this.attachment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hint,
          style: w300_13(
            color: AppColors.blueColor,
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        (attachment != null)
            ? DottedBorder(
          color: AppColors.greyColor,
          strokeWidth: 1,
          dashPattern: [5, 5],
          borderType: BorderType.RRect,
          radius: Radius.circular(8),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      attachment!.split('/').last,
                      maxLines: 2,
                      style: w300_13(),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      filePickedCallback(null);
                    },
                    child: ImageView(
                      path: Images.closeIcon,
                      width: 10,
                      color: AppColors.purpleColor,
                    ),
                  )
                ],
              ),
            )
            : GestureDetector(
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    filePickedCallback(result.files.single.path!);
                  }
                },
                child: DottedBorder(
                  color: AppColors.greyColor,
                  strokeWidth: 1,
                  dashPattern: [5, 5],
                  borderType: BorderType.RRect,
                  radius: Radius.circular(8),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageView(
                        path: Images.attachIcon,
                        color: AppColors.purpleColor,
                        height: 15,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        title,
                        style: w300_13(),
                      )
                    ],
                  ),
                ))
      ],
    );
  }
}
