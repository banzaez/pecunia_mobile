import 'package:get/get.dart';
import 'package:pecunia/screen/transactions/transactions_controller.dart';

class TransactionsBinding implements Binding {
  @override
  List<Bind> dependencies() => [
        Bind.put(TransactionsController()),
      ];
}
