import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:redeo/screens/authentication/controller/auth_controller.dart';
import 'package:redeo/utils/validators.dart';
import 'package:redeo/widgets/app_button.dart';

import '../../assets/images.dart';
import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String firstName = '';
  String lastName = '';
  String mobileNo = '';
  String emailId = '';
  String password = '';
  String confirmPassword = '';
  String initialCountry = 'IN';

  FocusNode nodes = FocusNode();

  PhoneNumber number = PhoneNumber(isoCode: 'IN');

  // AuthController controller = Get.find();

  AuthController controller = Get.isRegistered<AuthController>()
      ? Get.find<AuthController>()
      : Get.put(AuthController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,

      appBar: getAppBar(),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [getFields(), getButton()],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 212,
      flexibleSpace: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Images.authPageBg), fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: Container(),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 21.0),
                child: Text('Register your Account',
                    style: w900_35(color: Colors.white)),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          )),
      elevation: 0,
    );
  }

  Widget getFields() {
    return Column(
      children: [
        TextFormField(
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.name,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: w600_14(),
          decoration: inputDecoration.copyWith(labelText: 'First Name'),
          validator: (value) =>
              value == null || value.isEmpty ? 'Please enter first name' : null,
          onChanged: (value) => setState(() {
            firstName = value;
          }),
        ),
        SizedBox(
          height: 10.h,
        ),
        TextFormField(
          textInputAction: TextInputAction.next,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: w600_14(),
          onFieldSubmitted: (data) {
            FocusScope.of(context).requestFocus(nodes);
          },
          decoration: inputDecoration.copyWith(labelText: 'Last Name'),
          validator: (value) =>
              value == null || value.isEmpty ? 'Please enter last name' : null,
          onChanged: (value) => setState(() {
            lastName = value;
          }),
        ),
        SizedBox(
          height: 10.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: InternationalPhoneNumberInput(
            onInputChanged: (PhoneNumber number) {
              mobileNo = number.phoneNumber.toString();
              print(number.phoneNumber);
            },
            onInputValidated: (bool value) {
              print(value);
            },
            validator: (value) {
              return Validators.validateMobile(value);
            },
            selectorConfig: SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            ),
            ignoreBlank: false,
            focusNode: nodes,
            spaceBetweenSelectorAndTextField: 0,
            selectorTextStyle: TextStyle(color: Colors.black),
            initialValue: number,
            formatInput: false,
            keyboardAction: TextInputAction.next,
            textStyle: w600_14(),
            maxLength: 10,
            keyboardType:
                TextInputType.numberWithOptions(signed: false, decimal: false),
            inputDecoration: inputDecoration.copyWith(
              labelText: 'Mobile',
            ),
            onSaved: (PhoneNumber number) {
              print('On Saved: $number');
            },
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        TextFormField(
          textInputAction: TextInputAction.next,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: w600_14(),
          keyboardType: TextInputType.emailAddress,
          decoration: inputDecoration.copyWith(labelText: 'Email ID'),
          validator: (value) => Validators.validateEmail(value),
          onChanged: (value) => setState(() {
            emailId = value;
          }),
        ),
        SizedBox(
          height: 10.h,
        ),
        TextFormField(
          textInputAction: TextInputAction.next,
          obscuringCharacter: '✱',
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: w600_14(),
          obscureText: true,
          decoration: inputDecoration.copyWith(
            labelText: 'Password',
          ),
          validator: (value) =>
              value == null || value.isEmpty ? 'Please enter password' : null,
          onChanged: (value) => setState(() {
            password = value;
          }),
        ),
        SizedBox(
          height: 10.h,
        ),
        TextFormField(
          textInputAction: TextInputAction.done,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: w600_14(),
          obscureText: true,
          obscuringCharacter: '✱',
          decoration: inputDecoration.copyWith(labelText: 'Confirm Password'),
          validator: (value) =>
              Validators.validateConfirmPassword(password, value),
          onChanged: (value) => setState(() {
            confirmPassword = value;
          }),
        ),
      ],
    );
  }

  Widget getButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 40.h,
        ),
        AppButton(
            onPressedFunction: () async {
              if (_formKey.currentState!.validate()) {
                var success = await controller.register(
                    firstName: firstName,
                    lastName: lastName,
                    mobile: mobileNo,
                    email: emailId,
                    password: password);
                if (success)
                  Get.toNamed(Routes.otpVerficationScreen, arguments: mobileNo);
              }
            },
            child: Text(
              'Register Now',
              style: w900_15(color: Colors.white),
            ),
            height: 50.h,
            buttonColor: AppColors.purpleColor),
        SizedBox(
          height: 40.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Already have an account? ', style: w300_12()),
            GestureDetector(
              onTap: () {
                Get.offNamed(Routes.loginScreen);
              },
              child: Text('Sign In Now',
                  style: w900_12(
                    color: AppColors.purpleColor,
                  )),
            ),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}
