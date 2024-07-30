import 'package:add_transaction/src/models/transaction.dart';

import 'add_transaction_data_source.dart';

class AddTransactionRepository {
  final AddTransactionDataSource dataSource;

  AddTransactionRepository(this.dataSource);

  Future<Transaction> addTransaction(Transaction transaction) async {
    return await dataSource.addTransaction(transaction);
  }
}
