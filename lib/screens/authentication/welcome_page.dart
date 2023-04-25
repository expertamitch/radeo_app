import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:redeo/screens/authentication/login_page.dart';
import 'package:redeo/screens/authentication/register_page.dart';

import '../../widgets/colors.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Welcome to REDEO",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: purpleColor),
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/icons/screen 1/Logo.png',
                width: MediaQuery.of(context).size.width * 0.45,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 50,
                  width: double.maxFinite,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: purpleColor),
                      onPressed: () {
                        Get.to(LoginPage());
                      },
                      child: Text('Login Now'))),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: 50,
                  width: double.maxFinite,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: lighBlueColor),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()));
                      },
                      child: Text('Register Now'))),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Or login with',
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey, width: 0.5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/icons/screen 1/google.svg',
                              height: 20, semanticsLabel: 'Acme Logo'),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Google',
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey, width: 0.5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/icons/screen 1/Facebook.svg',
                              height: 20, semanticsLabel: 'Acme Logo'),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Facebook',
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
