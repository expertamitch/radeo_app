abstract class Validators {
  static String? validateEmail(String? email) {
    return email!.isEmpty
        ? "Required"
        : RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(email)
            ? null
            : "Invalid email address";
  }
  static String? validateEmailPattern(String? email) {
    return email!.isEmpty
        ? null
        : RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)
        ? null
        : "Invalid email address";
  }

  static String? validateMobile(String? mobile) {
    return mobile!.isEmpty
        ? "Required"
        : mobile.length < 10
            ? "Invalid mobile"
            : null;
  }
  static String? validateMobilePattern(String? mobile) {
    return mobile!.isEmpty
        ? null
        : mobile.length < 10
        ? "Invalid mobile"
        : null;
  }

  static String? validateOTP(String? otp) {
    return otp!.isEmpty
        ? "Required"
        : otp.length < 4
            ? "Invalid OTP"
            : null;
  }

  static String? validateName(String? mobile) {
    return mobile!.isEmpty ? "Required" : null;
  }

  static String? validateAccountNumber(String? number, {bool force=false}) {
    return force?'Invalid account details':number!.isEmpty ? "Required" : null;
  }


  static String? validatePassword(String? password) {
    return password!.isEmpty
        ? "Required"
        : password.length < 1
            ? ""
            : null;


    // return password!.isEmpty
    //     ? "Required"
    //     : password.length < 8 ||
    //     !password.contains(new RegExp(r'[A-Z]')) ||
    //     !password.contains(new RegExp(r'[0-9]')) ||
    //     !password.contains(new RegExp(r'[^A-Za-z0-9]'))
    //     ? ""
    //     : null;
  }

  static String? validateConfirmPassword(
      String? password, String? confirmPassword) {
    return confirmPassword!.isEmpty
        ? "Required"
        : confirmPassword != password
            ? "Confirm Password do not match Password"
            : null;
  }

  static String? validateCardNumber(String? number) {
    return number!.isEmpty
        ? "Required"
        : number.length < 22
            ? "Invalid card number"
            : null;
  }

  static String? validateMM(String? number) {
    return number!.isEmpty
        ? "Required"
        : number.length < 2 || int.parse(number) > 12 || int.parse(number) == 0
            ? "Invalid"
            : null;
  }

  static String? validateCVV(String? number) {
    return number!.isEmpty
        ? "Required"
        : number.length < 3
            ? "Invalid"
            : null;
  }

  static String? validateYY(String? number, String mm) {
    if (number != null && number.isEmpty) return "Required";
    var enteredDate = DateTime(2000 + int.parse(number!), int.parse(mm));

    DateTime currentDate = DateTime.now();
    int currentYear = currentDate.year - 2000;
    int currentMonth = currentDate.month;
    int inputMonth = mm == "" ? 0 : int.parse(mm);

    if(enteredDate.isBefore(currentDate))
      return 'Invalid';
   else
      return null;
  }

/*getPasswordAssist() {
    return Obx(() => Row(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            children: [
              getCell('At least 8 characters',
                  controller.passwordString.value.length > 7),
              getCell('At least one number',
                  controller.passwordString.contains(new RegExp(r'[0-9]'))),
            ],
          ),
        ),
        SizedBox(
          width: 13.w,
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              getCell('At least one upper case',
                  controller.passwordString.contains(new RegExp(r'[A-Z]'))),
              getCell(
                  'At least one symbol',
                  controller.passwordString
                      .contains(new RegExp(r'[^A-Za-z0-9]'))),
            ],
          ),
        ),
      ],
    ));
  }*/

}
