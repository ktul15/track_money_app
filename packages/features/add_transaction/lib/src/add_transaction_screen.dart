import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:theme/theme.dart';

import '../add_expense.dart';

class AddTransactionScreen extends ConsumerWidget {
  const AddTransactionScreen(this.transactionType, {super.key});

  final TransactionType transactionType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BlocProvider<AddTransactionCubit>(
      create: (_) => AddTransactionCubit(transactionType),
      child: const AddExpenseView(),
    );
  }
}

class AddExpenseView extends StatefulWidget {
  const AddExpenseView({
    super.key,
  });

  @override
  State<AddExpenseView> createState() => _AddExpenseViewState();
}

class _AddExpenseViewState extends State<AddExpenseView> {
  final _amountFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<AddTransactionCubit>();
    _amountFocusNode.addListener(() {
      if (!_amountFocusNode.hasFocus) {
        cubit.onAmountUnfocused();
      }
    });
    _descriptionFocusNode.addListener(() {
      if (!_descriptionFocusNode.hasFocus) {
        cubit.onDescriptionUnfocused();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var addExpenseLocalizations = AddExpenseScreenLocalizations.of(context);
    return BlocBuilder<AddTransactionCubit, AddExpenseState>(
      builder: (context, state) {
        var cubit = context.read<AddTransactionCubit>();
        final amountStateError =
            state.amount.isNotValid ? state.amount.error : null;
        final descriptionStateError =
            state.description.isNotValid ? state.description.error : null;
        print("descriptionStateError : $descriptionStateError");

        return Scaffold(
          appBar: AppBar(
            title: Text(addExpenseLocalizations.appbar_title),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                TextFormField(
                  controller: cubit.amountController,
                  focusNode: _amountFocusNode,
                  style: const TextStyle(
                    color: Pallete.blackColor,
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (value) {
                    cubit.onAmountChanged(value);
                  },
                  decoration: InputDecoration(
                    label: Text(addExpenseLocalizations.amount_textfield_label),
                    labelStyle:
                        TextStyle(color: Pallete.blackColor.withOpacity(0.9)),
                    hintText: "0.0",
                    hintStyle: TextStyle(
                      color: Pallete.blackColor.withOpacity(0.9),
                    ),
                    errorText: amountStateError != null
                        ? amountStateError == AmountValidationError.empty
                            ? "Amount cannot be empty."
                            : "Amount is invalid."
                        : null,
                  ),
                ),
                TextFormField(
                  readOnly: true,
                  controller: cubit.dateController,
                  style: const TextStyle(
                    color: Pallete.blackColor,
                  ),
                  decoration: InputDecoration(
                    label: Text(
                      addExpenseLocalizations.date_textfield_label,
                    ),
                    labelStyle:
                        TextStyle(color: Pallete.blackColor.withOpacity(0.9)),
                  ),
                  onTap: () {
                    showDialog<DateTime>(
                        context: context,
                        builder: (context) {
                          return DatePickerDialog(
                              firstDate: DateTime(2010, 1, 1),
                              lastDate: DateTime.now());
                        }).then((value) {
                      if (value != null) {
                        cubit.selectedDate = value;
                        cubit.dateController.text =
                            DateFormat("MMM dd, yyy").format(value);
                      }
                    });
                  },
                ),
                TextFormField(
                  controller: cubit.descriptionController,
                  focusNode: _descriptionFocusNode,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    cubit.onDescriptionChanged(value);
                  },
                  style: const TextStyle(
                    color: Pallete.blackColor,
                  ),
                  decoration: InputDecoration(
                    label: Text(
                        addExpenseLocalizations.description_textfield_label),
                    errorText: descriptionStateError != null
                        ? descriptionStateError ==
                                DescriptionValidationError.invalid
                            ? "Description is too long."
                            : "Description is invalid."
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                    onPressed: () async {
                      cubit.onSubmitTransaction();
                    },
                    child: Text(addExpenseLocalizations.button_label_save))
              ],
            ),
          ),
        );
      },
    );
  }
}
