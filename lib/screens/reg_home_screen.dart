import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:roomies_app/screens/registration.dart';

import '../bloc/post_bloc/bloc.dart';
import '../services/api_service.dart';
import '../services/cache_helper.dart';
import '../utility/user_store.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class RegHomeScreen extends StatefulWidget {
  const RegHomeScreen({Key? key}) : super(key: key);

  @override
  State<RegHomeScreen> createState() => _RegHomeScreenState();
}

class _RegHomeScreenState extends State<RegHomeScreen> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD8D6D6),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/splash.svg',
          ),
          const SizedBox(height: 25),
          const SizedBox(
            width: 466,
            height: 60,
            child: Text(
              "Protect yourself from fraud",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 1),
          const SizedBox(
            width: 280,
            height: 92,
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Dignissim quam id venenatis integer donec ut consectetur quis pharetra. Aliquam accumsan ",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0x99000000),
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(height: 38),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: MaterialButton(
              elevation: 10,
              onPressed: () {

                Navigator.push(context,
                    MaterialPageRoute(builder: (_) =>   BlocProvider(
                      create: (_) => AppBloc(apiService: ApiService()),
                      child:     RegistrationScreen(),
                    )));
              },
              child: const Text(
                "Get Started",
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
        ],
      ),
    );
  }
}
