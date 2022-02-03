import 'package:flutter/material.dart';

class CustomAlertDialogLoading extends StatelessWidget {
  final String titulo;
  CustomAlertDialogLoading({Key? key, required this.titulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titulo),
      content: const Center(child: CircularProgressIndicator()),
    );
  }
}
