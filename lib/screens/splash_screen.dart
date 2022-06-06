import 'dart:async';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:roomies_app/screens/registration.dart';

import '../bloc/post_bloc/bloc.dart';
import '../services/api_service.dart';
import '../services/cache_helper.dart';
import '../utility/user_store.dart';
import 'dashboard.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'pop_screen.dart';
import 'search_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  CacheHelper _cacheHelper = CacheHelper();
  bool? isUserLoggedIn = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller = AnimationController(
      value: 0.0,
      duration: const Duration(seconds: 2),
      reverseDuration: const Duration(milliseconds: 75),
      vsync: this,
    )..addStatusListener((AnimationStatus status) {
      setState(() {
        // setState needs to be called to trigger a rebuild because
        // the 'HIDE FAB'/'SHOW FAB' button needs to be updated based
        // the latest value of [_controller.status].
      });
    });
    if (_isAnimationRunningForwardsOrComplete) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    _cacheHelper.isLoggedIn().then((value) => {
      setState(() {
        isUserLoggedIn = value;
      }),

      if(isUserLoggedIn!){
        Provider.of<UserStore>(context,listen:false).fetchCurrentUser(),
        startTime()
      }
      else{
        startTime(),
      }
    });
    super.initState();
  }

  bool get _isAnimationRunningForwardsOrComplete {
    switch (_controller.status) {
      case AnimationStatus.forward:
      case AnimationStatus.completed:
        return true;
      case AnimationStatus.reverse:
      case AnimationStatus.dismissed:
        return false;
    }
  }


  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, route);
  }

  route() {
    if (!isUserLoggedIn!) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BlocProvider<AppBloc>(
            create: (context) => AppBloc(apiService: ApiService()),
            child: LoginScreen()),
        ),
      );
    } else {

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BlocProvider<AppBloc>(
              create: (context) => AppBloc(apiService: ApiService()),
              child: DashboardScreen()),
          ));

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget? child) {
                return FadeScaleTransition(
                  animation: _controller,
                  child: child,
                );
              },
              child: Image.asset(
                'assets/soji_logo.png',
                height: 100,
                width: 200,

              ),
            ),
          ),


        ],
      ),
    );
  }
}
