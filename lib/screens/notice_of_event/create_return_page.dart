import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/widgets/image_view.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
 
import 'package:redeo/widgets/app_button.dart';

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
                AppButton(
                    onPressedFunction: () {},
                    child: Text(
                      'Save',
                      style: w300_12(color: Colors.white),
                    ),
                    height: 30.h,
                    sodiumShapeBorder: true,
                    width: null,
                    buttonColor: AppColors.purpleColor)
              ],
            ),
            SizedBox(
              width: 10.w,
            )
          ],
        ),
        body: Column(children: [
          Container(
            width: double.maxFinite,
            color: AppColors.darkGreyColor,
            padding: EdgeInsets.only(left: 18, right: 16, bottom: 20),
            child: Text(
              'Create Return',
              style: w900_30(),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Details',
                      style: w300_13(
                        color: AppColors.blueColor,
                      ),
                    ),
                    TextFormField(
                      style: w300_14(),
                      decoration: InputDecoration(
                          hintStyle: w300_14(
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
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Set Return Visit',
                      style: w300_13(
                        color: AppColors.blueColor,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        DateTime? d = await showDatePicker(
                            context: context,
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  primaryColor: AppColors.purpleColor,
                                  accentColor: AppColors.purpleColor,
                                  colorScheme: ColorScheme.light(
                                      primary: AppColors.purpleColor),
                                  buttonTheme: ButtonThemeData(
                                      textTheme: ButtonTextTheme.primary),
                                ),
                                child: child!,
                              );
                            },
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1990),
                            lastDate: DateTime(3000));
                        if (d != null) {
                          TimeOfDay? t = await showTimePicker(
                            context: context,
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  primaryColor: AppColors.purpleColor,
                                  accentColor: AppColors.purpleColor,
                                  colorScheme: ColorScheme.light(
                                      primary: AppColors.purpleColor),
                                  buttonTheme: ButtonThemeData(
                                      textTheme: ButtonTextTheme.primary),
                                ),
                                child: child!,
                              );
                            },
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
                          Text(
                            setReturnVisitDate == null
                                ? 'Select date'
                                : DateFormat('EEEE, MMM d, yyyy')
                                    .format(setReturnVisitDate!),
                            style: w300_14(
                                color: setReturnVisitDate == null
                                    ? AppColors.dark2GreyColor
                                    : Colors.black),
                          ),
                          if (setReturnVisitDate != null)
                            Text(
                              DateFormat('h:mm a').format(setReturnVisitDate!),
                              style: w300_14(color: Colors.black),
                            ),
                        ],
                      ),
                    ),
                    if (showSetReturnVisitDateTimeError)
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          'Please select a date',
                          style: w300_13(
                            color: Colors.red[800],
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 10.h,
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
                          style: w300_14(color: AppColors.dark2GreyColor),
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
                              style: w300_15(),
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
                      height: 10.h,
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
                          style: w300_14(color: AppColors.dark2GreyColor),
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
                              style: w300_15(),
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
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Notify Joe',
                            style: w300_14(),
                          ),
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
                      height: 10.h,
                    ),
                  ],
                ),
              ),
              Divider(thickness: 1, color: AppColors.borderGreyColor),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Indicatores',
                        style: w300_13(
                          color: AppColors.blueColor,
                        )),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Status',
                      style: w600_14(),
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
                          child: Text(
                            'Open for encouragment',
                            style: w300_14(),
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
                          child: Text(
                            'All Set',
                            style: w300_14(),
                          ),
                        ),
                      ],
                    ),
                    if (showIndicatorStatusError)
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          'Please select a indicator status',
                          style: w300_13(
                            color: Colors.red[800],
                          ),
                        ),
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
                    Text('Level',
                        style: w300_13(
                          color: AppColors.blueColor,
                        )),
                    SizedBox(
                      height: 10.h,
                    ),
                    if (showLevelError)
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          'Please select a level',
                          style: w300_13(
                            color: Colors.red[800],
                          ),
                        ),
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
                      height: 20.h,
                    )
                  ],
                ),
              ),
            ]),
          )))
        ]));
  }
}
