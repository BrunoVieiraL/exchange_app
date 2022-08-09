import 'package:flutter/material.dart';

class TextFieldCustomWidget extends StatelessWidget {
  final String label;
  final String prefix;
  final TextEditingController controller;
  final Function(String) onChanged;

  const TextFieldCustomWidget({
    Key? key,
    required this.label,
    required this.prefix,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.amber.shade900),
          border: const OutlineInputBorder(),
          prefixText: prefix,
          prefixStyle: const TextStyle(color: Colors.amber, fontSize: 25)),
      style: const TextStyle(color: Colors.amber, fontSize: 25.0),
      onChanged: onChanged,
      keyboardType: TextInputType.number,
    );
  }
}
