import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:redeo/screens/authentication/register_page.dart';
import 'package:redeo/widgets/colors.dart';

import 'fogot_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool rememberPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
            decoration: BoxDecoration(color: lighBlueColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  backgroundColor: lighBlueColor,
                  elevation: 0,
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 21.0),
                    child: Text(
                      'Sign in to your\nAccount',
                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            )),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: inputDecoration.copyWith(labelText: 'Username'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: inputDecoration.copyWith(labelText: 'Password'),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Flexible(
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        value: rememberPassword,
                        dense: true,
                        contentPadding: EdgeInsets.only(right: 5),
                        title: Text(
                          'Remember Password',
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                        onChanged: (value) {
                          setState(() {
                            rememberPassword = value ?? false;
                          });
                        },
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPasswordPage()));
                        },
                        child: Text(
                          'Forgot Password ?',
                          style: TextStyle(color: lighBlueColor, fontSize: 12),
                        ))
                  ],
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
                          // Get.to(LoginPage());
                        },
                        child: Text('Login Now'))),
                Expanded(
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account? ',
                        style: TextStyle(color: Colors.black, fontSize: 14)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return RegisterPage();
                          },
                        ));
                      },
                      child: Text('Register Now',
                          style: TextStyle(
                              color: purpleColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
