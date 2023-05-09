import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/styling/font_style_globle.dart';
import 'package:redeo/widgets/app_text.dart';
import 'package:redeo/widgets/image_view.dart';

class ScanQrPage extends StatefulWidget {
  const ScanQrPage({Key? key}) : super(key: key);

  @override
  State<ScanQrPage> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 17, 19, 23),
            image: DecorationImage(
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.dstATop),
                fit: BoxFit.cover,
                image: AssetImage(
                  Images.scanQrBgImg,
                ))),
        child: Column(
          children: [
            SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width.w,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: ImageView(
                            path: Images.closeIcon,
                            color: Colors.white,
                          )),
                      Expanded(
                          child: SizedBox(
                        width: 10.w,
                      )),
                      Center(
                        child: Text(
                          'Scan QR code',
                          style: w700_18(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                          child: SizedBox(
                        width: 10.w,
                      )),
                      SizedBox(
                        width: 30.w,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                child: SizedBox(
              height: 10.h,
            )),
            Align(
              alignment: Alignment.center,
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.white.withOpacity(.4), width: 2),
                      borderRadius: BorderRadius.circular(18)),
                  width: MediaQuery.of(context).size.width * 0.50,
                  height: MediaQuery.of(context).size.width * 0.50,
                  padding: EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(18)),
                    child: Center(
                      child: PrettyQr(
                        // image: AssetImage('images/twitter.png'),
                        typeNumber: 3,
                        data: 'https://www.google.ru',
                        errorCorrectLevel: QrErrorCorrectLevel.M,
                        roundEdges: true,
                      ),
                    ),
                  )),
            ),
            SizedBox(
              height: 30.h,
            ),
            Expanded(
                child: SizedBox(
              height: 10.h,
            )),
          ],
        ),
      ),
    );
  }
}
