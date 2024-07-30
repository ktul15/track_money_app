import 'package:add_transaction/src/models/transaction.dart' as models;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';

class AddTransactionDataSource {
  AddTransactionDataSource();

  Future<models.Transaction> addTransaction(models.Transaction transaction) async {
    return await FirebaseFirestore.instance
        .collection('transactions')
        .add(transaction.toFirestore())
        .then((value) => transaction.copyWith(uid: value.id));
  }
}
