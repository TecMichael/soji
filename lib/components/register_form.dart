import 'package:flutter/material.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm(
      {Key? key,
      required this.txt,
      required this.controller,
      this.isObscure = false,
      this.inputType = TextInputType.text})
      : super(key: key);
  final String txt;
  final TextEditingController controller;
  final bool isObscure;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.black),
        obscureText: isObscure,
        decoration: InputDecoration(
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 17.0, horizontal: 25.0),
          fillColor: Colors.white,
          filled: true,
          hintText: txt,
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              borderSide: BorderSide(color: Colors.grey)),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          hintStyle: const TextStyle(
              color: Color.fromRGBO(60, 60, 60, 0.44),
              fontSize: 15,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
