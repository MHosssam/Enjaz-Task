import 'package:enjaz/helpers/translation/localization_methods.dart';
import 'package:flutter/services.dart';

extension Validator on String {
  String? noValidate() {
    return null;
  }

  String? validateEmpty({String? message}) {
    if (trim().isEmpty) {
      return message ?? tr("fillField");
    }
    return null;
  }

  String? validatePassword({String? message}) {
    if (isEmpty) {
      return message ?? tr("pleaseEnterYourPassword");
    // } else {
    //   if (length < 8) {
    //     return tr("passwordLength");
      // } else if (!isStartingWithCapital) {
      //   return tr("passwordLengthDes");
      // } else if (!_isPasswordValid(this)) {
      //   return tr("passwordLengthDes");
      } else {
        return null;
      }
    // }
  }

  bool get isStartingWithCapital => substring(0, 1).toUpperCase() == substring(0, 1);

  bool _isPasswordValid(String password) {
    RegExp passwordPattern = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@#$%^&+=])[A-Za-z\d@#$%^&+=]{6,}$');
    return passwordPattern.hasMatch(password);
  }

  String? validateEmail({String? message}) {
    if (trim().isEmpty) {
      return message ?? tr("fillField");
    } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this)) {
      return message ?? tr("mailValidation");
    }
    return null;
  }

  String? validateEmailOrPhone({String? message}) {
    // i want to validate if user enter numbers only so u can validate it as phone and if user enter values tha has @
    // u can validate it as email
    if (isValidEmail()) {
      return validateEmail();
    } else if (isValidPhoneNumber()) {
      return validatePhone();
    } else {
      return message ?? tr("pleaseEnterValidPhoneNumberOrEmail");
    }
  }

  bool isValidPhoneNumber() {
    const phoneRegex = r'^[0-9]+$';
    final phoneRegExp = RegExp(phoneRegex);
    return phoneRegExp.hasMatch(this);
  }

  bool isValidEmail() {
    const emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final emailRegExp = RegExp(emailRegex);
    return emailRegExp.hasMatch(this);
  }

  String? validateEmailORNull({String? message}) {
    if (trim().isNotEmpty) {
      if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this)) {
        return message ?? tr("mailValidation");
      }
    }
    return null;
  }

  String? validatePhone({String? message}) {
    if (trim().isEmpty) {
      return message ?? tr("fillField");
    } else if (contains(RegExp(r'[a-zA-Z]'))) {
      return tr("phoneValidation");
    } else if (length < 9) {
      return tr("phoneNumberValidateMini");
    } else if (length > 9) {
      return tr("phoneNumberValidateMax");
    }
    return null;
  }

  String? validatePasswordConfirm({required String pass, String? message}) {
    if (trim().isEmpty) {
      return message ?? tr("fillField");
    } else if (this != pass) {
      return message ?? tr("confirmValidation");
    }
    return null;
  }

  String? validateCarNumber() {
    RegExp regex = RegExp(r'^\d{1,4}$');
    if (!regex.hasMatch(this)) {
      return tr("carNumVAl");
    }
    return null;
  }

  String? validateArabicCarLetters({required String val}) {
    // Regular expression to match 3 Arabic letters
    // RegExp regex = RegExp(r'^[a-zA-Z]{1,5}$');
    // if (!regex.hasMatch(this)) {
    if (val.length != 5) {
      return tr("carValidate");
    }
    return null;
  }
}

String? validateDropDown(dynamic value, {String? message}) {
  if (value == null) {
    return message ?? tr("fillField");
  }
  return null;
}


TextDirection getTextDirection(String text) {
  final firstChar = text.isNotEmpty ? text[0] : '';
  if (RegExp(r'^[\u0600-\u06FF]').hasMatch(firstChar)) {
    return TextDirection.rtl;
  } else {
    return TextDirection.ltr;
  }
}
