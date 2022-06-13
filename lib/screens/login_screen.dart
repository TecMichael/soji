import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import 'package:roomies_app/components/register_form.dart';
import 'package:roomies_app/screens/dashboard.dart';
import 'package:roomies_app/screens/forgot_password.dart';

import '../bloc/post_bloc/bloc.dart';
import '../bloc/post_bloc/event.dart';
import '../bloc/post_bloc/state.dart';
import '../services/api_service.dart';
import '../utility/user_store.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool? isLoading = false;
  AppBloc? appBloc;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    appBloc = BlocProvider.of<AppBloc>(context);

    // Provider.of<UserStore>(context,listen: false).mixpanel!.track('Opened Login Screen', properties: {});
  }

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
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: BlocListener<AppBloc, AppState>(
            listener: (context, state) async {
              if (state is LoadingState || state is InitialState) {
                setState(() {
                  isLoading = true;
                });
              } else if (state is SignInPostedState) {
                setState(() {
                  isLoading = false;
                });

                Flushbar(
                  message: 'Login Successful',
                  flushbarStyle: FlushbarStyle.GROUNDED,
                  duration: const Duration(seconds: 3),
                ).show(context);
                Provider.of<UserStore>(context, listen: false)
                    .fetchCurrentUser();
                // Provider.of<UserStore>(context,listen: false).mixpanel!.track('Login Success');

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider(
                            create: (_) => AppBloc(apiService: ApiService()),
                            child: const DashboardScreen(),
                          )),
                );
              } else if (state is LoadFailureState) {
                Flushbar(
                  message: 'Incorrect credentials',
                  flushbarStyle: FlushbarStyle.GROUNDED,
                  duration: const Duration(seconds: 3),
                ).show(context);

                setState(() {
                  isLoading = false;
                });
              } else {
                setState(() {
                  isLoading = false;
                });
              }
            },
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Sign In",
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
                      txt: 'Enter your Email',
                      controller: emailController,
                      inputType: TextInputType.phone,
                    ),
                    const SizedBox(height: 10),
                    RegisterForm(
                        txt: 'Enter your Password',
                        controller: passwordController,
                        isObscure: true),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider<AppBloc>(
                                        create: (context) =>
                                            AppBloc(apiService: ApiService()),
                                        child: const ForgotPassword()),
                                  ));
                            },
                            child: const Text(
                              "Forgotten Password?",
                              style: TextStyle(
                                color: Color(0xffFF6600),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 72),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70, vertical: 70),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xffff6600).withOpacity(0.4),
                              blurRadius: 9.5,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            appBloc!.add(SignInEvent(
                              email: emailController.text,
                              password: passwordController.text,
                            ));
                          },
                          child: isLoading!
                              ? const SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: CircularProgressIndicator(
                                      color: Colors.white))
                              : const Text(
                                  "Log In",
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
          ),
        ),
      ),
    );
  }
}
