import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:track_money_app/core/providers/firebase_providers.dart';
import 'package:track_money_app/core/router/AppPath.dart';
import 'package:track_money_app/features/add_expense/controller/add_expense_controller.dart';
import 'package:track_money_app/features/add_expense/models/expense.dart';
import 'package:track_money_app/features/auth/controller/auth_controller.dart';
import 'package:track_money_app/theme/palette.dart';

class AddExpense extends ConsumerWidget {
  const AddExpense({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Expense"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            TextFormField(
              style: const TextStyle(
                color: Pallete.blackColor,
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                ref
                    .watch(amountProvider.notifier)
                    .update((state) => double.tryParse(value) ?? 0.0);
              },
              decoration: InputDecoration(
                label: const Text("Amount"),
                hintText: "0.0",
                hintStyle: TextStyle(
                  color: Pallete.blackColor.withOpacity(0.5),
                ),
              ),
            ),
            TextFormField(
              readOnly: true,
              controller: dateController,
              decoration: const InputDecoration(label: Text("Date")),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return DatePickerDialog(
                          firstDate: DateTime(2010, 1, 1),
                          lastDate: DateTime.now());
                    }).then((value) {
                  if (value != null) {
                    ref
                        .read(dateTimeProvider.notifier)
                        .update((state) => value);
                    dateController.text =
                        DateFormat("MMM dd, yyy").format(value);
                  }
                });
              },
            ),
            TextFormField(
              controller: descriptionController,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                ref
                    .watch(descriptionProvider.notifier)
                    .update((state) => value);
              },
              decoration: const InputDecoration(label: Text("Description")),
            ),
            const SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () {
                context.pushNamed(AppPath.categoryListScreen);
              },
              child: const Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Category",
                    style: TextStyle(color: Pallete.blackColor),
                  ),
                  Icon(
                    Icons.arrow_forward_outlined,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () async {
                  debugPrint("amount: ${ref.read(amountProvider)}");
                  debugPrint("desc: ${ref.read(descriptionProvider)}");
                  debugPrint("date: ${ref.read(dateTimeProvider)}");

                  var amount = ref.read(amountProvider);
                  var desc = ref.read(descriptionProvider);
                  var date = ref.read(dateTimeProvider);

                  if (amount != 0 && desc.isNotEmpty && date != null) {
                    Expense expense = Expense(
                        uid: ref.read(userProvider.notifier).state!.uid,
                        amount:
                            ref.read(amountProvider.notifier).state.toString(),
                        dateTime: ref.read(dateTimeProvider.notifier).state!,
                        description:
                            ref.read(descriptionProvider.notifier).state);
                    await ref
                        .read(firestoreProvider)
                        .collection("expenses")
                        .add(expense.toFirestore());
                  }
                },
                child: const Text("Save"))
          ],
        ),
      ),
    );
  }
}
