import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dateController = TextEditingController(text: "");
final descriptionController = TextEditingController(text: "");

final amountProvider = StateProvider<double>((ref) => 0);
final dateTimeProvider = StateProvider<DateTime?>((ref) => null);
final descriptionProvider = StateProvider<String>((ref) => "");
final categoryProvider = StateProvider<String>((ref) => "");

class AddExpenseState {
  final double amount;
  final DateTime? dateTime;
  final String description;
  final String category;

  AddExpenseState(
      {required this.amount,
      required this.dateTime,
      required this.description,
      required this.category});
}
