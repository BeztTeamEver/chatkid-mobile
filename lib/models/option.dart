import 'package:equatable/equatable.dart';

class OptionModel<T> extends Equatable {
  final T value;
  final String label;

  const OptionModel({
    required this.value,
    required this.label,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [value];
}
