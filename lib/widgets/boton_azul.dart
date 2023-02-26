import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  const BotonAzul({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      highlightElevation: 5,
      elevation: 2,
      color: Colors.blue,
      shape: const StadiumBorder(),
      child: SizedBox(
          width: double.infinity,
          height: 55,
          child: Center(
              child: Text(
            text,
            style: const TextStyle(
              fontSize: 17,
              color: Colors.white,
            ),
          ))),
    );
  }
}
