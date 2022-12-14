import 'package:flutter/material.dart';

import '../constants/string.constant.dart';

Widget SearchField(TextEditingController textEditingController) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.blue.withOpacity(0.3),
      borderRadius: BorderRadius.circular(15),
    ),
    child: TextField(
      controller: textEditingController,
      // onChanged: (value) => print(value),
      // onChanged: (query) {
      //   // setState(() {
      //   searchItem = query;
      //   // });
      // },
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 9),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        hintText: TEXT_SEARCH_HINT,
        prefixIcon: Icon(Icons.search),
      ),
    ),
  );
}
