import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roomies_app/components/register_form.dart';
import 'package:roomies_app/screens/dashboard.dart';
import 'package:roomies_app/screens/registration.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
              "Welcome Back!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SvgPicture.asset(
            'assets/register.svg',
          ),
          const SizedBox(height: 17),
          Column(
            children: const [
              RegisterForm(txt: 'Email'),
              RegisterForm(txt: 'Password')
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 53),
            child: Row(
              children: const [
                Text(
                  "Forgot Password?",
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
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_)=>const DashboardScreen()));
                // ignore: prefer_const_constructors
              },
              child: const Text(
                "Log In",
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
          const SizedBox(height: 18),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: RichText(
              text: const TextSpan(
                text: 'Do not have an account?',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
                children: [
                  TextSpan(
                    text: ' Sign Up',
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
