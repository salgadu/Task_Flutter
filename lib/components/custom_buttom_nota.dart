import 'package:flutter/material.dart';

class CustomButtomNota extends StatelessWidget {
  const CustomButtomNota({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: Color.fromRGBO(92, 157, 254, 1),
            style: BorderStyle.solid,
            width: 1.0,
          ),
        ),
        height: 50,
        alignment: Alignment.center,
        child: Text(
          "Nota",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(92, 157, 254, 1),
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
