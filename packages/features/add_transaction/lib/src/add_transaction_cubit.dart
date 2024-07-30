import 'package:add_transaction/src/add_transaction_data_source.dart';
import 'package:add_transaction/src/add_transaction_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

import '../add_expense.dart';

class AddTransactionCubit extends Cubit<AddExpenseState> {
  AddTransactionCubit(this.transactionType)
      : addTransactionRepository =
            AddTransactionRepository(AddTransactionDataSource()),
        super(
          AddExpenseState(
            date: DateTime.now(),
            formattedDate: DateFormat("MMM dd, yyy").format(DateTime.now()),
            transactionType: transactionType,
          ),
        );

  final TransactionType transactionType;

  AddTransactionRepository addTransactionRepository;

  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();

  void onAmountChanged(String value) {
    final previousState = state;
    final previousAmountState = previousState.amount;

    final shouldValidate = !previousAmountState.isPure;

    double doubleValue = double.tryParse(value) ?? -1;

    final newAmountState = shouldValidate
        ? Amount.validated(doubleValue)
        : Amount.unvalidated(doubleValue);

    final newScreenState = previousState.copyWith(amount: newAmountState);

    emit(newScreenState);
  }

  void onAmountUnfocused() {
    final previousState = state;
    final previousAmountState = previousState.amount;
    final previousAmountValue = previousAmountState.value;

    final newAmountState = Amount.validated(previousAmountValue);

    print("va: ${newAmountState.isValid}");
    print("va: ${newAmountState.error}");

    final newScreenState = previousState.copyWith(amount: newAmountState);

    emit(newScreenState);
  }

  void onDescriptionChanged(String value) {
    final previousState = state;
    final previousDescritionState = previousState.description;

    final shouldValidate = previousDescritionState.isPure;

    print("shouldValidate $shouldValidate");

    final newDescriptionState = Description.validated(value);

    final newScreenState =
        previousState.copyWith(description: newDescriptionState);

    emit(newScreenState);
  }

  void onDescriptionUnfocused() {
    final previousState = state;
    final previousDescritionState = previousState.description;
    final previousDescritionValue = previousDescritionState.value;

    final newDescriptionState = Description.validated(previousDescritionValue);

    final newScreenState =
        previousState.copyWith(description: newDescriptionState);

    emit(newScreenState);
  }

  void onSubmitTransaction() {
    final amount =
        Amount.validated(double.tryParse(amountController.text) ?? 0);
    final date = state.date;
    final description = Description.validated(descriptionController.text);
    final transactionType = state.transactionType;

    print("sdf ${amount.displayError}");
    print("ds ${description.displayError}");

    final isFormValid = Formz.validate([
      amount,
      description,
    ]);

    final newState = state.copyWith(
      amount: amount,
      description: description,
      date: selectedDate,
      transactionType: transactionType,
    );

    emit(newState);

    print("form: $isFormValid");

    if (isFormValid) {
      print("op");
      final transaction = <String, dynamic>{
        "amount": amount.value,
        "description": description.value,
        "date": state.date,
        "transactionType": transactionType.name,
      };

      var db = FirebaseFirestore.instance;

      db
          .collection("transactions")
          .add(transaction)
          .then((DocumentReference doc) {
        print('DocumentSnapshot added with ID: ${doc.id}');
      });
    }
  }
}
