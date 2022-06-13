import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/register_form.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

TextEditingController emailController = TextEditingController();
bool? isLoading = false;

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset(
          'assets/soji_logo.png',
          scale: 5,
          height: 45,
          width: 115,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xffff6600)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Forgot Password",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xffFF6600),
                  fontSize: 25,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8.84),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0x99000000),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              RegisterForm(
                txt: 'johndoe@mail.com',
                controller: emailController,
                inputType: TextInputType.phone,
              ),
              const SizedBox(height: 72),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 70, vertical: 90),
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(255, 0,0, 0.3),
                        blurRadius: 9.5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: MaterialButton(
                    onPressed: () {},
                    child: isLoading!
                        ? const SizedBox(
                            width: 25,
                            height: 25,
                            child:
                                CircularProgressIndicator(color: Colors.white))
                        : const Text(
                            "Reset Password",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xfffffbfb),
                              fontSize: 15,
                              fontFamily: "Open Sans",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    color: const Color(0xffFF6600),
                    minWidth: double.infinity,
                    height: 60,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Lorem ipsum dolor sit onsectetur adipiscing',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w400, fontSize: 13),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'eliLorem ipsum dolor ',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                        color: const Color(0xffFF6600),
                        fontWeight: FontWeight.w400,
                        fontSize: 13),
                  ),
                  Text(
                    ' sit onsectetur g eli',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w400, fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
