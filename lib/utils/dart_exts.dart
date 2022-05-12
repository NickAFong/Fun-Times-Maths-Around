import 'package:flutter/material.dart';

bool isLoading = false;

extension BuildContextExt on BuildContext {
  Future<void> showProgress() async {
    isLoading = true;
    return showDialog<void>(
      context: this,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: const [
              CircularProgressIndicator(),
              SizedBox(
                width: 10,
              ),
              Text("Please wait")
            ],
          ),
        );
      },
    );
  }

  void hideProgress() {
    if (isLoading) {
      Navigator.of(this).pop();
    }
  }
}
