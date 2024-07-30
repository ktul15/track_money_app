import 'package:cloud_firestore/cloud_firestore.dart';

class Transaction {
  final String uid;
  final String amount;
  final String? description;
  final DateTime dateTime;

  const Transaction(
      {required this.uid,
      required this.amount,
      this.description,
      required this.dateTime});

  factory Transaction.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Transaction(
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

  Transaction copyWith({
    String? uid,
    String? amount,
    String? description,
    DateTime? dateTime,
  }) {
    return Transaction(
      uid: uid ?? this.uid,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}
