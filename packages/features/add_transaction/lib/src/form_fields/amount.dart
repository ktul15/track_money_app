import 'package:formz/formz.dart';

class Amount extends FormzInput<double, AmountValidationError> {
  const Amount.unvalidated([double value = 0]) : super.pure(value);
  const Amount.validated([double value = 0]) : super.dirty(value);

  @override
  AmountValidationError? validator(double value) {
    if (value == 0) {
      return AmountValidationError.empty;
    } else if (value < 0) {
      return AmountValidationError.invalid;
    }
    return null;
  }
}

enum AmountValidationError {
  empty,
  invalid,
}
