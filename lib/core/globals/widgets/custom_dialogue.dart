import 'dart:ui';

import 'package:flutter/material.dart';

class Alerts {
  final BuildContext context;

  Alerts({required this.context});

  void snackBar({
    required String massage,
    int duration = 1,
    bool isSuccess = true,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: const EdgeInsets.only(
          bottom: 64,
        ),
        content: Text(
          massage,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        duration: Duration(
          seconds: duration,
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: isSuccess ? Colors.green : Colors.red,
      ),
    );
  }

  /// Show a Custom Dialog with Circular Progress Indicator and Title
  void showLoadingDialog({required String title}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),
            Center(
              child: Dialog(
                backgroundColor: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(color: Colors.amber),
                    const SizedBox(height: 20),
                    Text(
                      title,
                      style: Theme.of(context).primaryTextTheme.headlineLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Dismiss the loading dialog
  void dismissDialog() {
    Navigator.of(context, rootNavigator: true).pop();
  }


}
