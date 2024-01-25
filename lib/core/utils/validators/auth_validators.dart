import 'package:the_yurko_method/core/utils/extensions/extensions.dart';
import 'package:the_yurko_method/core/utils/extensions/utils.dart';

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a password';
  }
  if (value.length < 8) {
    return 'Please enter minimum 8 characters';
  }
  if (!value.isCotainUpperCase) {
    return 'Must contain at least 1 uppercase';
  }
  if (!value.isContainLowerCase) {
    return 'Must contain at least 1 lowercase';
  }
  if (!value.isContainSymbol) {
    return 'Must contain at least 1 special symbol';
  }

  return null;
}

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter enter your email address';
  }
  if (!value.isEmail) {
    return 'Please enter valid email address';
  }
  return null;
}

String? phoneValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter enter your phone number';
  }
  if (!value.isPhoneNumber) {
    return 'Please enter valid phone number';
  }
  return null;
}

String? conformPassword(String? pass, String? confirmPass) {
  final isValid = passwordValidator(pass);
  if (isValid != null) return isValid;
  print(pass);
  print(confirmPass);

  if (pass != confirmPass) {
    return "Password and confirmed password should match";
  }
  return null;
}

String? nameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your name';
  }
  if (!value.isAlphabetOnly) {
    return 'Please enter valid name';
  }
  return null;
}
