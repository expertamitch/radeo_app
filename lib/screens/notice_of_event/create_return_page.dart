import 'package:flutter_svg/svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/widgets/image_view.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/app_text.dart';

class CreateReturnPage extends StatefulWidget {
  const CreateReturnPage({Key? key}) : super(key: key);

  @override
  State<CreateReturnPage> createState() => _CreateReturnPageState();
}

class _CreateReturnPageState extends State<CreateReturnPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool showSetReturnVisitDateTimeError = false;
  bool showIndicatorStatusError = false;
  bool showLevelError = false;

  DateTime? setReturnVisitDate;
  String? selectedTimePeroid; // 'Everyday','Weekly','Monthy','Yearly'
  String? selectedNotifyMe; // 'Everyday','Weekly','Monthy','Yearly'
  int? indicatorStatus; //openForEncouragment, All Set
  int? level;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.darkGreyColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            Row(
              children: [
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          primary: AppColors.purpleColor),
                      onPressed: () {},
                      child: AppText(
                        text: 'Save',
                        textSize: 12,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: Column(children: [
          Container(
            width: double.maxFinite,
            color: AppColors.darkGreyColor,
            padding: EdgeInsets.only(left: 18, right: 16, bottom: 20),
            child: AppText(
              text: 'Create Return',
              textSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: 'Details',
                      textSize: 14,
                      color: AppColors.blueColor,
                    ),
                    TextFormField(
                      style: w500_14(),
                      decoration: InputDecoration(
                          hintStyle: w500_14(
                            color: AppColors.dark2GreyColor,
                          ),
                          hintText: 'Enter Details',
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter a name' : null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ],
                ),
              ),
              Divider(thickness: 1, color: AppColors.borderGreyColor),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: 'Set Return Visit',
                      textSize: 14,
                      color: AppColors.blueColor,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        DateTime? d = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1990),
                            lastDate: DateTime(3000));
                        if (d != null) {
                          TimeOfDay? t = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );

                          if (t != null) {
                            setReturnVisitDate = DateTime(
                                d.year, d.month, d.day, t.hour, t.minute);
                          } else {
                            setReturnVisitDate =
                                DateTime(d.year, d.month, d.day);
                          }
                        }
                        setState(() {
                          showSetReturnVisitDateTimeError = false;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            text: setReturnVisitDate == null
                                ? 'Select date'
                                : DateFormat('EEEE, MMM d, yyyy')
                                    .format(setReturnVisitDate!),
                            textSize: 16,
                          ),
                          if (setReturnVisitDate != null)
                            AppText(
                              text: DateFormat('h:mm a')
                                  .format(setReturnVisitDate!),
                              textSize: 16,
                            ),
                        ],
                      ),
                    ),
                    if (showSetReturnVisitDateTimeError)
                      AppText(
                        padding: EdgeInsets.only(top: 10),
                        text: 'Please select a date',
                        color: Colors.red[800],
                        textSize: 13,
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(thickness: 1, color: AppColors.borderGreyColor),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.lightGreyColor),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: SizedBox(),
                        icon: ImageView(
                          path: Images.downArrowIcon,
                        ),
                        value: selectedTimePeroid,
                        hint: Text(
                          'Select',
                          style: w500_14(color: AppColors.dark2GreyColor),
                        ),
                        items: <String>[
                          'Everyday',
                          'Weekly',
                          'Monthy',
                          'Yearly'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: w500_15(),
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedTimePeroid = val;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.lightGreyColor),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: SizedBox(),
                        icon: ImageView(
                          path: Images.downArrowIcon,
                        ),
                        value: selectedNotifyMe,
                        hint: Text(
                          'Notify Me',
                          style: w500_14(color: AppColors.dark2GreyColor),
                        ),
                        items: <String>[
                          'Everyday',
                          'Weekly',
                          'Monthy',
                          'Yearly'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: w500_15(),
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedNotifyMe = val;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: 'Notify Joe',
                          textSize: 15,
                          padding: EdgeInsets.only(left: 10),
                        ),
                        Transform.scale(
                          scale: 0.6,
                          child: CupertinoSwitch(
                            activeColor: AppColors.purpleColor,
                            value: false,
                            onChanged: (value) {},
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Divider(thickness: 1, color: AppColors.borderGreyColor),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: 'Indicatores',
                      textSize: 14,
                      color: AppColors.blueColor,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AppText(
                      text: 'Status',
                      textSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 1,
                          groupValue: indicatorStatus,
                          activeColor: AppColors.purpleColor,
                          onChanged: (int? value) {
                            setState(() {
                              indicatorStatus = value;
                              showIndicatorStatusError = false;
                            });
                          },
                        ),
                        GestureDetector(
                          onTap: () => setState(() {
                            indicatorStatus = 1;
                            showIndicatorStatusError = false;
                          }),
                          child: AppText(
                            text: 'Open for encouragment',
                            textSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 2,
                          activeColor: AppColors.purpleColor,
                          groupValue: indicatorStatus,
                          onChanged: (int? value) {
                            setState(() {
                              indicatorStatus = value;
                              showIndicatorStatusError = false;
                            });
                          },
                        ),
                        GestureDetector(
                          onTap: () => setState(() {
                            indicatorStatus = 2;
                            showIndicatorStatusError = false;
                          }),
                          child: AppText(
                            text: 'All Set',
                            textSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    if (showIndicatorStatusError)
                      AppText(
                        padding: EdgeInsets.only(top: 10),
                        text: 'Please select a indicator status',
                        color: Colors.red[800],
                        textSize: 13,
                      ),
                  ],
                ),
              ),
              Divider(thickness: 1, color: AppColors.borderGreyColor),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: 'Level',
                      textSize: 14,
                      color: AppColors.blueColor,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (showLevelError)
                      AppText(
                        padding: EdgeInsets.only(bottom: 10),
                        text: 'Please select a level',
                        color: Colors.red[800],
                        textSize: 13,
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              level = 1;
                              showLevelError = false;
                            });
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width * .28,
                              height: 60,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: level == 1
                                          ? AppColors.purpleColor
                                          : AppColors.greyColor),
                                  borderRadius: BorderRadius.circular(8)),
                              child: SvgPicture.asset(
                                  'assets/icons/screen 18/Level 1.svg')),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              level = 2;
                              showLevelError = false;
                            });
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width * .28,
                              height: 60,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: level == 2
                                          ? AppColors.purpleColor
                                          : AppColors.greyColor),
                                  borderRadius: BorderRadius.circular(8)),
                              child: SvgPicture.asset(
                                  'assets/icons/screen 18/Level 2.svg')),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              level = 3;
                              showLevelError = false;
                            });
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width * .28,
                              height: 60,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: level == 3
                                          ? AppColors.purpleColor
                                          : AppColors.greyColor),
                                  borderRadius: BorderRadius.circular(8)),
                              child: SvgPicture.asset(
                                  'assets/icons/screen 18/Level 3.svg')),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ]),
          )))
        ]));
  }
}
