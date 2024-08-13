import 'package:chatkid_mobile/enum/role.dart';

class Option {
  final String label;
  final String value;

  Option({
    required this.label,
    required this.value,
  });
}

class InfoForm {
  static final List<Option> GENDER_OPTIONS = [
    Option(label: 'Nam', value: Gender.male.toString().split('.')[1]),
    Option(label: 'Nữ', value: Gender.female.toString().split('.')[1]),
    Option(label: 'Khác', value: Gender.other.toString().split('.')[1]),
  ];

  static final List<Option> ROLE_OPTIONS = [
    Option(label: 'Bố', value: "Bố"),
    Option(label: 'Mẹ', value: "Mẹ"),
    Option(label: 'Cô', value: "Cô"),
    Option(label: 'Chú', value: "Chú"),
    Option(label: 'Dì', value: "Dì"),
    Option(label: 'Bác', value: "Bác"),
  ];
  static final List<Option> YEAR_BIRTHDAY_OPTIONS =
      List.generate(100, (index) => DateTime.now().year - index)
          .map((e) => Option(label: e.toString(), value: e.toString()))
          .toList();
}
