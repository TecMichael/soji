import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roomies_app/screens/registration.dart';

import '../bloc/post_bloc/bloc.dart';
import '../services/api_service.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/soji_logo.png',
                    scale: 2,
                    height: 50,
                    width: 130,
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Column(
                children: [
                  Image.asset('assets/onboarding.png',scale: 2.7,),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Text('Protect yourself from',
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w700,
                            fontSize: 25,
                            color: const Color(0xff5E5E5E)),
                        textAlign: TextAlign.center),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('FRAUD',
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w900,
                          fontSize: 25,
                          color: const Color(0xff5E5E5E)),
                      textAlign: TextAlign.center),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: const [
                  Expanded(
                    child: Text(
                      'Lorem ipsum dolor sit onsectetur dipiscing\neliLorem ipsum dolor sit onsectetur g eli',
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider<
                                AppBloc>(
                                create: (context) => AppBloc(
                                    apiService: ApiService()),
                                child:
                                const RegistrationScreen()),
                          ));
                    },
                    child: Container(
                      height: 50,
                      width: 180,
                      decoration: BoxDecoration(
                          color: const Color(0xffff6600),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xffff6600).withOpacity(0.3),
                              blurRadius: 9.5,
                              offset: const Offset(8, 7),
                            ),
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 25, right: 7),
                                  child: Text(
                                    'Get Started',
                                    style: GoogleFonts.openSans(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                  ),
                                ),
                                const SizedBox(width: 25),
                                Expanded(
                                  child: Container(
                                    height: 40,
                                    width: 46,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => BlocProvider<
                                                        AppBloc>(
                                                    create: (context) => AppBloc(
                                                        apiService: ApiService()),
                                                    child:
                                                        const RegistrationScreen()),
                                              ));
                                        },
                                        icon: const Icon(
                                          Icons.arrow_forward,
                                          color: Color(0xffFF6600),
                                        )),
                                  ),
                                )
                              ])
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Lorem ipsum dolor sit onsectetur adipiscing',
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w400, fontSize: 13),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'elilrome',
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: const Color(0xffFF6600),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ipsum dolor',
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: const Color(0xffFF6600),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'sit onsectetur g eli',
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w400, fontSize: 13),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
