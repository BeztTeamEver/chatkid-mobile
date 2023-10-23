class Regex {
  static final RegExp email = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
  static final RegExp password =
      RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");
  static final RegExp phone = RegExp(r'^[0-9]{10}$');
}
