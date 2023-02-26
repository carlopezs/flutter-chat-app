import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String ruta;
  final String secondaryText;
  final String primaryText;

  const Labels(
      {super.key,
      required this.ruta,
      required this.secondaryText,
      required this.primaryText});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          secondaryText,
          style: const TextStyle(
              color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300),
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: (() {
            Navigator.pushReplacementNamed(context, ruta);
          }),
          child: Text(
            primaryText,
            style: TextStyle(
                color: Colors.blue[600],
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
