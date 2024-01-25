extension ContainChecker on String {
  bool get isCotainUpperCase {
    final RegExp regex = RegExp(r'^(?=.*?[A-Z])');
    return regex.hasMatch(this);
  }

  bool get isContainLowerCase {
    final RegExp regex = RegExp(r'^(?=.*?[a-z])');
    return regex.hasMatch(this);
  }

  bool get isContainNumber {
    final RegExp regex = RegExp(r'^(?=.*?[0-9])');
    return regex.hasMatch(this);
  }

  bool get isContainSymbol {
    final RegExp regex = RegExp(r'^(?=.*?[!@#\$&*~])');
    return regex.hasMatch(this);
  }
}
