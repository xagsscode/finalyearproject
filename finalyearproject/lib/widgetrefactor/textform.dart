import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextForm extends StatefulWidget {
  final String text;
  final String text2;
  final TextEditingController? controllerCallback;
  final bool Obsecuretext;
  final String? Function(String?)? validator; // Added validator field

  TextForm({
    Key? key,
    required this.text,
    required this.text2,
    this.controllerCallback,
    this.Obsecuretext = false,
    this.validator,
  }) : super(key: key);

  @override
  State<TextForm> createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  String? text3;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(
          obscureText: widget.Obsecuretext,
          controller: widget.controllerCallback,
          decoration: InputDecoration(
            hintText: widget.text,
            labelText: widget.text2,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          ),
          validator: widget.validator, // Set the validator here
        ),
      ),
    );
  }
}
