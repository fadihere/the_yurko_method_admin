import 'dart:math';

String getRandomString(int length) {
  const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random rnd = Random();
  return String.fromCharCodes(
    Iterable.generate(
      length,
      (_) => chars.codeUnitAt(
        rnd.nextInt(chars.length),
      ),
    ),
  );
}

int getRandomInt(int length) {
  const numbers = "1234567890";
  Random rnd = Random();
  final number = String.fromCharCodes(
    Iterable.generate(
      length,
      (_) => numbers.codeUnitAt(
        rnd.nextInt(numbers.length),
      ),
    ),
  );
  return int.parse(number);
}
