import 'package:flutter/material.dart';

import '../styling/app_colors.dart';
import '../styling/font_style_globle.dart';
import 'image_view.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;

  final String? Function(String?)? validator;
  final FocusNode? currentNode;
  final FocusNode? nextNode;

  final bool isEnabled;
  final int minLines;
  final AutovalidateMode? autovalidateMode;
  final int? maxLength;
  final int maxLines;
  final Function(String)? onChanged;
  final VoidCallback? onEditingComplete;
  final TextInputType? keyboardType;
  final TextInputAction? action;

  final String hint;
  final String? mainHint;
  final String? prefixPath;
  final Color? prefixColor;
  final double? prefixSize;

  const AppTextField({
    Key? key,
    this.controller,
    required this.hint,
    this.action,
    this.prefixSize,
    this.autovalidateMode,
    this.currentNode,
    this.nextNode,
    this.validator,
    this.prefixPath,
    this.mainHint,
    this.prefixColor,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
    this.isEnabled = true,
    this.onChanged,
    this.keyboardType,
    this.onEditingComplete,
  }) : super(key: key);

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
        TextFormField(
          style: w300_13(),
          autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
          controller: controller,
          enabled: isEnabled,
          focusNode: currentNode,
          validator: validator,
          textInputAction: action,
          keyboardType: keyboardType,
          maxLines: maxLines,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          minLines: minLines,
          maxLength: maxLength,
          onFieldSubmitted: (data) {
            if (nextNode != null) FocusScope.of(context).requestFocus(nextNode);
          },
          decoration: InputDecoration(
              hintStyle: w300_13(),
              hintText: mainHint ?? hint,
              border: InputBorder.none,
              counterStyle: w300_0(color: Colors.transparent),
              errorStyle: w300_13(color: AppColors.redColor),
              prefixIconConstraints: BoxConstraints(maxWidth: 20, minWidth: 20),
              prefixIcon: prefixPath != null
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageView(
                            path: prefixPath,
                            color: prefixColor ?? AppColors.purpleColor,
                            height: prefixSize ?? 18,
                          ),
                        ],
                      ),
                    )
                  : null),
        )
      ],
    );
  }
}
