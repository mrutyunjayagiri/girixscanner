import 'package:email_validator/email_validator.dart';

class AuthValidation {
  static bool isEmail(String email) => EmailValidator.validate(email);

  String validateLoginPass(String value) {
    String msg = '';
    //print(value);
    if (value.isEmpty) {
      msg = 'Please enter a password';
    } else if (value.length < 5) {
      msg = "Password must be 5";
    } else {
      msg = null;
    }
    return msg;
  }

  String validatePassword(String value) {
//    Pattern pattern =
//        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
//    RegExp regex = RegExp(pattern);
    String msg;
    if (value.isEmpty) {
      msg = 'Please enter a password';
    } else if (value.length < 5) {
      msg = "Password should contain atleast 5 characters";
    }
//    else {
//      if (!regex.hasMatch(value))
//        msg =
//        'Password should contain upper case and lower case,\ndigit and special character';
//      else
//        msg = null;
//    }
    return msg;
  }

// Making Form Email Validation
  String validateEmail(String value) {
    bool isEmail(String email) => EmailValidator.validate(email);
    String msg = '';
    if (!isEmail(value.trim())) {
      msg = 'Please enter a valid email';
    } else {
      msg = null;
    }
    return msg;
  }

  String usernameValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter a name';
    } else if (value.length < 4) {
      return 'Name must be 4';
    }
  }

  String confirmPassowardValidator(String password, String confrim) {
    if (confrim.isEmpty) {
      return 'Please enter confirm password';
    } else if (password != confrim) {
      return 'Passwords not match';
    }
  }

  String mobileValidator(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
  }

  String dobValidator(String value) {
    String msg;
    if (value.length == 0) {
      msg = 'Please enter Date of Birth';
    }
    return msg;
  }

  String generalValidator(String value) {
    String msg;
    if (value.length == 0) {
      msg = 'Please enter a value';
    }
    return msg;
  }

  String barcodeFontValidator(String value) {
    String msg;
    if (value.length == 0) {
      msg = 'Please enter a value';
    } else if (double.parse(value) > 90) {
      msg = "Value can not be greater than 90";
    }
    return msg;
  }
}
