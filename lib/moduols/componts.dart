import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List notes = [];
Widget textdefult({required String textfildtitle, required Color colorfont}) =>
    Text(
      textfildtitle,
      textDirection: TextDirection.rtl,
      style: TextStyle(
        color: colorfont,
        fontWeight: FontWeight.bold,
      ),
    );
Widget iconsbuttondefult({
  required VoidCallback onpressed,
  required Icon iconsbtn,
}) =>
    IconButton(
      onPressed: onpressed,
      icon: iconsbtn,
      color: Color.fromARGB(255, 96, 126, 170),
    );
Widget textformfildeditandadd(
        {required TextEditingController controller,
        required String textnotes,
        FormFieldValidator<String>? valida}) =>
    TextFormField(
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        controller: controller,
        decoration: InputDecoration(
          label: Align(
            alignment: Alignment.topRight,
            child: Text(
              overflow: TextOverflow.ellipsis,
              textnotes,
              style: TextStyle(fontWeight: FontWeight.bold),
              maxLines: 1,
            ),
          ),
        ),
        validator: valida);
