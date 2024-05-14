import 'package:flutter/material.dart';
import 'package:todotasks/utils/app_str.dart';

class RepTextField extends StatelessWidget {
  const RepTextField({
    super.key,
    required this.controller,
    required this.textTheme,
    this.isForDescription = false,
  });

  final TextEditingController controller;
  final bool isForDescription;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ListTile(
        title: TextFormField(
          controller: controller,
          maxLines: !isForDescription ? 6 : null,
          cursorHeight: isForDescription ? 25 : null,
          style: const TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),
            counter: Container(),
            prefixIcon: isForDescription
                ? const Icon(Icons.bookmark_border, color: Colors.grey)
                : null,
            hintText: isForDescription
                ? AppStr.addNote
                : AppStr.titleOfTitleTextField,
            hintStyle: textTheme.titleMedium,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),
          ),
          onFieldSubmitted: (value) {},
          onChanged: (value) {},
        ),
      ),
    );
  }
}
