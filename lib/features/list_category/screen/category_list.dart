import 'package:flutter/material.dart';
import 'package:track_money_app/theme/palette.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return const AddCategory();
              });
        },
        child: Container(
          decoration: BoxDecoration(
            color: Pallete.greenColor,
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: const Icon(
            Icons.add,
            size: 32,
            color: Pallete.whiteColor,
          ),
        ),
      ),
    );
  }
}

class AddCategory extends StatelessWidget {
  const AddCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      color: Pallete.whiteColor,
      child: Center(
        child: TextField(
          controller: TextEditingController(),
          decoration: InputDecoration(
            hintText: "Category",
            labelText: "Category",
          ),
        ),
      ),
    );
  }
}
