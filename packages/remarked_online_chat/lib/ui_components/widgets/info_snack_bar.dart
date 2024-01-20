import 'package:flutter/material.dart';

class InfoSnackBar {
  InfoSnackBar(BuildContext context, String content) {
    final SnackBar snackBar = SnackBar(
      action: SnackBarAction(
        label: 'закрыть',
        textColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
      backgroundColor: const Color.fromARGB(255, 251, 0, 0),
      content: Text(content),
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
