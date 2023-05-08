import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:redeo/styling/app_colors.dart';
import '../../assets/images.dart';
import '../../route/routes.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/app_text.dart';
import '../../widgets/colors.dart';
import '../../widgets/image_view.dart';

class AttendantsPage extends StatefulWidget {
  const AttendantsPage({Key? key}) : super(key: key);

  @override
  State<AttendantsPage> createState() => _AttendantsPageState();
}

class _AttendantsPageState extends State<AttendantsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.darkGreyColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            'Attendants',
            style: w600_16(),
          ),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'Select Attendants',
              style: w600_16(),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: AppColors.darkGreyColor,
                borderRadius: BorderRadius.circular(8)),
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                ImageView(
                  path: Images.searchIcon,
                  color: Colors.purple,
                ),
                SizedBox(width: 15),
                Flexible(
                    child: TextFormField(
                  style: w500_14(),
                  decoration: InputDecoration(
                      hintStyle: w500_14(
                        color: AppColors.dark2GreyColor,
                      ),
                      border: InputBorder.none,
                      hintText: 'Search Coordinator…',
                      isDense: true),
                ))
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return groupListTile(
                      title: 'John Doe',
                      subtitle: '2006 Chapmans Lane, San Francisco,',
                    );
                  }))
        ]));
  }

  groupListTile({
    required String title,
    required String subtitle,
  }) {
    return GestureDetector(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: AppColors.borderGreyColor))),
          child: Row(
            children: [
              SvgPicture.asset(
                Images.peopleIcon,
                height: 25,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: w500_14(),
                    ),
                    Text(
                      subtitle,
                      style: w500_12(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Radio(
                value: false,
                groupValue: 'groupValue',
                onChanged: (value) {},
              )
            ],
          ),
        ));
  }
}
