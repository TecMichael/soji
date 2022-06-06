import 'package:another_flushbar/flushbar.dart';
import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:roomies_app/components/register_form.dart';
import 'package:roomies_app/screens/dashboard.dart';
import 'package:roomies_app/screens/registration.dart';

import '../bloc/post_bloc/bloc.dart';
import '../bloc/post_bloc/event.dart';
import '../bloc/post_bloc/state.dart';
import '../services/api_service.dart';
import '../utility/user_store.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool? isLoading=false;
  AppBloc? appBloc;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    appBloc = BlocProvider.of<AppBloc>(context);

    Provider.of<UserStore>(context,listen: false).mixpanel!.track('Opened Login Screen', properties: {});
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor: const Color(0xffD8D6D6),
      body: Container(
       height:MediaQuery.of(context).size.height,
        child: Center(
          child: SingleChildScrollView(
            child: BlocListener<AppBloc, AppState>(
              listener: (context,state) async {
                if(state is LoadingState || state is InitialState){
                  setState(() {
                    isLoading=true;
                  });
                }else if(state is SignInPostedState) {
                  setState(() {
                    isLoading=false;
                  });

                  Flushbar(
                    message:'Login Successful',
                    flushbarStyle: FlushbarStyle.GROUNDED,
                    duration: Duration(seconds: 3),
                  ).show(context);
                  Provider.of<UserStore>(context,listen:false).fetchCurrentUser();
                  Provider.of<UserStore>(context,listen: false).mixpanel!.track('Login Success');


                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BlocProvider(
                      create: (_) => AppBloc(apiService: ApiService()),
                      child:     DashboardScreen(),
                    )),
                  );

                }
                else if(state is LoadFailureState){
                  Flushbar(
                    message:'Incorrect credentials',
                    flushbarStyle: FlushbarStyle.GROUNDED,
                    duration: Duration(seconds: 3),
                  ).show(context);

                  setState(() {
                    isLoading=false;
                  });
                }
                else {
                  setState(() {
                    isLoading=false;
                  });
                }
              },
              child: SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  color: const Color(0xffD8D6D6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 50,
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
                      RegisterForm(txt: 'Email',controller: emailController,  inputType: TextInputType.phone,
                      ),
                      RegisterForm(txt: 'Password',controller: passwordController,isObscure:true),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
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
                            appBloc!.add(SignInEvent(
                                email: emailController.text,
                                password: passwordController.text,

                            ));
                          },
                          child: isLoading!?SizedBox(
                              width: 25,
                              height: 25,
                              child: CircularProgressIndicator(color:Colors.white)) : const Text(
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
                          height: 45,
                        ),
                      ),
                      const SizedBox(height: 18),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) =>   BlocProvider(
                                create: (_) => AppBloc(apiService: ApiService()),
                                child:     RegistrationScreen(),
                              )));
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
                      ),



                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
