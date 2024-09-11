import 'package:flutter/material.dart';

class AsyncWidget extends StatefulWidget {
  const AsyncWidget({
    super.key,
    required this.whenLoadingShow,
    required this.whenSuccessShow,
    required this.whenErrorShow,
    required this.future,
  });

  final Future<Object?>? future;
  final Widget whenSuccessShow;
  final Widget whenLoadingShow;
  final Widget whenErrorShow;

  @override
  State<AsyncWidget> createState() => _AsyncWidgetState();
}

class _AsyncWidgetState extends State<AsyncWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.future,
      builder: (context, snapshot) {
        print("DATA ${snapshot.connectionState}");
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.whenLoadingShow;
        }
        print("HAS ERROR ${snapshot.hasError}");

        if (snapshot.hasError) {
          return widget.whenErrorShow;
        } else {
          return widget.whenSuccessShow;
        }
      },
    );
  }
}
