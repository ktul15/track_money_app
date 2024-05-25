import 'package:cloud_firestore/cloud_firestore.dart';

class Expense {
  final String uid;
  final String amount;
  final String? description;
  final DateTime dateTime;

  const Expense(
      {required this.uid,
      required this.amount,
      this.description,
      required this.dateTime});

  factory Expense.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Expense(
        uid: data?['uid'],
        amount: data?['amount'],
        description: data?['description'],
        dateTime: data?['dateTime']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "uid": uid,
      "amount": amount,
      if (description != null) "description": description,
      "dateTime": dateTime,
    };
  }
}
