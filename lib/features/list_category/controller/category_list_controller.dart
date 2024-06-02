import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryListController = Provider((ref) => CategoryListController());

class CategoryListController {
  final TextEditingController categoryController = TextEditingController();
}
