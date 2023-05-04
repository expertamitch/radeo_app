import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:redeo/assets/images.dart';
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
        child: SafeArea(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: ImageView(
                              path: Images.closeIcon,
                              color: Colors.white,
                            )),
                      ),
                      Expanded(
                          child: SizedBox(
                        width: 10,
                      )),
                      Center(
                        child: AppText(
                          text: 'Scan QR code',
                          textSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: SizedBox(
                        width: 10,
                      )),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: SizedBox(
                height: 10,
              )),
              Align(
                alignment: Alignment.center,
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
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
                height: 30,
              ),
              Expanded(
                  child: SizedBox(
                height: 10,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
