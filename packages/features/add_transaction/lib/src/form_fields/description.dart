import 'package:formz/formz.dart';

class Description extends FormzInput<String, DescriptionValidationError> {
  const Description.unvalidated([String value = ""]) : super.pure(value);
  const Description.validated([String value = ""]) : super.dirty(value);

  @override
  DescriptionValidationError? validator(String value) {
    print("valdes: $value");
    if (value.trim().length < 5) {
      return DescriptionValidationError.invalid;
    }
    return null;
  }
}

enum DescriptionValidationError {
  empty,
  invalid,
}
