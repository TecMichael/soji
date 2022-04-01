import 'package:flutter/material.dart';
import 'package:roomies_app/screens/login_screen.dart';

import '../components/register_form.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool ischecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD8D6D6),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 1243,
            height: 49,
            child: Text(
              "Welcome!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 8.84),
          const SizedBox(
            width: 231,
            height: 36,
            child: Text(
              "Lets help you to get started",
              style: TextStyle(
                color: Color(0x99000000),
                fontSize: 16,
              ),
            ),
          ),
          const RegisterForm(
            txt: 'Enter your full name',
          ),
          const RegisterForm(
            txt: 'Email',
          ),
          const RegisterForm(
            txt: 'Phone Number',
          ),
          const RegisterForm(
            txt: 'Password',
          ),
          const RegisterForm(
            txt: 'Confirm password',
          ),
          const RegisterForm(
            txt: 'Country',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              children: [
                Checkbox(
                  value: ischecked,
                  onChanged: (value) {
                    setState(() => ischecked = value!);
                  },
                  activeColor: Colors.black,
                  checkColor: Colors.white,
                ),
                const Text(
                  "Terms and Conditions",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 38),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: MaterialButton(
              elevation: 10,
              onPressed: () {},
              child: const Text(
                "Register",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xfffffbfb),
                  fontSize: 18,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w700,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: const Color(0xffFF6600),
              minWidth: double.infinity,
              height: 56,
            ),
          ),
          const SizedBox(height: 28),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()));
            },
            child: RichText(
              text: const TextSpan(
                text: 'Already have an account?',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
                children: [
                  TextSpan(
                    text: ' Sign In',
                    style: TextStyle(
                        color: Color(0xffFF6600), fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
