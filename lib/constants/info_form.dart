import 'package:chatkid_mobile/enum/role.dart';

class Options {
  final String label;
  final String value;

  Options({
    required this.label,
    required this.value,
  });
}

class InfoForm {
  static final List<Options> GENDER_OPTIONS = [
    Options(label: 'Nam', value: Gender.male.toString().split('.')[1]),
    Options(label: 'Nữ', value: Gender.female.toString().split('.')[1]),
    Options(label: 'Khác', value: Gender.other.toString().split('.')[1]),
  ];

  static final List<Options> ROLE_OPTIONS = [
    Options(label: 'Bố', value: FamilyRole.father.toString().split('.')[1]),
    Options(label: 'Mẹ', value: FamilyRole.mother.toString().split('.')[1]),
  ];
}
