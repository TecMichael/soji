import 'package:flutter/material.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    Key? key,
    required this.txt,
  }) : super(key: key);
  final String txt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 6),
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
          fillColor: Colors.white,
          filled: true,
          hintText: txt,
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
              borderSide: BorderSide(color: Colors.grey)),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          hintStyle: const TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
