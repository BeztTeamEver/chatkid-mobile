import 'package:chatkid_mobile/enum/role.dart';

const iconAnimalList = [
  'animal/bear',
  'animal/chicken',
  'animal/penguin',
  'animal/koala',
  'animal/giraffe',
];

class RoleConstant {
  static final Parent = Role.Parent.toString().split('.')[1];
  static final Child = Role.Children.toString().split('.')[1];
}
