import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

import 'form_fields/amount.dart';
import 'form_fields/description.dart';

class AddExpenseState extends Equatable {
  const AddExpenseState({
    this.amount = const Amount.unvalidated(0),
    required this.date,
    required this.formattedDate,
    this.submissionStatus = SubmissionStatus.initial,
    this.transactionType = TransactionType.EXPENSE,
    this.description = const Description.unvalidated(),
  });

  final Amount amount;
  final SubmissionStatus submissionStatus;
  final TransactionType transactionType;
  final DateTime date;
  final String formattedDate;
  final Description description;

  @override
  List<Object?> get props => [amount, submissionStatus];

  AddExpenseState copyWith({
    Amount? amount,
    Description? description,
    SubmissionStatus? submissionStatus,
    TransactionType? transactionType,
    DateTime? date,
    String? formattedDate,
  }) {
    return AddExpenseState(
      amount: amount ?? this.amount,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      transactionType: transactionType ?? this.transactionType,
      description: description ?? this.description,
      date: date ?? this.date,
      formattedDate: formattedDate ?? this.formattedDate,
    );
  }
}

enum SubmissionStatus {
  error,
  initial,
}
