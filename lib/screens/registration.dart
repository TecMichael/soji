import 'dart:ui';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:roomies_app/screens/dashboard.dart';
import 'package:roomies_app/screens/login_screen.dart';
import 'package:country_picker/country_picker.dart';
import 'package:roomies_app/screens/terms_and_conditions.dart';
import '../bloc/post_bloc/bloc.dart';
import '../bloc/post_bloc/event.dart';
import '../bloc/post_bloc/state.dart';
import '../components/register_form.dart';
import '../services/api_service.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool ischecked = true;
  bool? isLoading = false;
  bool remember = false;
  final List<String?> errors = [];

  AppBloc? appBloc;

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  Country? selectedCountry;

  @override
  void initState() {
    super.initState();
    appBloc = BlocProvider.of<AppBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/soji_logo.png',
          scale: 5,
          height: 45,
          width: 115,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xffff6600)),
      ),
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          child: BlocListener<AppBloc, AppState>(
            listener: (context, state) {
              if (state is LoadingState || state is InitialState) {
                setState(() {
                  isLoading = true;
                });
              } else if (state is SignUpPostedState) {
                setState(() {
                  isLoading = false;
                });

                Flushbar(
                  message: 'Account Created',
                  flushbarStyle: FlushbarStyle.GROUNDED,
                  duration: const Duration(seconds: 3),
                ).show(context);
                // Navigator.pushNamed(context, LoginSuccessScreen.routeName);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider(
                            create: (_) => AppBloc(apiService: ApiService()),
                            child: const LoginScreen(),
                          )),
                );
                // Provider.of<UserStore>(context,listen: false).mixpanel!.track('Account Create Success');

              } else if (state is LoadFailureState) {
                Flushbar(
                  message: 'Oops! could not create you account at this time',
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
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      child: Text(
                        "Welcome",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xffFF6600),
                          fontSize: 25,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5.84),
                    const SizedBox(
                      width: 231,
                      height: 40,
                      child: Text(
                        "Lets help you to get started",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0x99000000),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    RegisterForm(
                      txt: 'Enter your full name',
                      controller: firstnameController,
                    ),
                    const SizedBox(height: 5.84),
                    RegisterForm(
                      txt: 'Enter your Email',
                      controller: emailController,
                      inputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 5.84),
                    RegisterForm(
                      txt: 'Phone Number',
                      controller: phoneController,
                      inputType: TextInputType.phone,
                    ),
                    const SizedBox(height: 5.84),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () {
                              showCountryPicker(
                                context: context,
                                showPhoneCode: true,
                                countryListTheme: CountryListThemeData(
                                  flagSize: 25,
                                  backgroundColor: Colors.white,
                                  textStyle: const TextStyle(
                                      fontSize: 16, color: Colors.blueGrey),
                                  bottomSheetHeight:
                                      600, // Optional. Country list modal height
                                  //Optional. Sets the border radius for the bottomsheet.
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                  ),
                                  //Optional. Styles the search field.
                                  inputDecoration: InputDecoration(
                                    labelText: 'Search',
                                    hintText: 'Start typing to search',
                                    prefixIcon: const Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: const Color(0xFF8C98A8)
                                            .withOpacity(0.2),
                                      ),
                                    ),
                                  ),
                                ),
                                onSelect: (Country country) {
                                  setState(() {
                                    selectedCountry = country;
                                  });
                                },
                              );
                            },
                            child: Container(
                              height: 50,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              margin:
                                  const EdgeInsets.only(left: 12, right: 10),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Text(
                                          selectedCountry == null
                                              ? 'Country'
                                              : '+' +
                                                  selectedCountry!.phoneCode,
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                    const Spacer(),
                                    // const SizedBox(width: 150),
                                    const Icon(
                                      Icons.arrow_drop_down,
                                      size: 35,
                                      color: Color(0xffFF6600),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.84),

                    RegisterForm(
                        txt: 'Password',
                        controller: passwordController,
                        isObscure: true),
                    const SizedBox(height: 5.84),

                    RegisterForm(
                        txt: 'Confirm password',
                        controller: countryController,
                        isObscure: true),
                    // const RegisterForm(
                    //   txt: 'Country',
                    // // ),                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(right: 15, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => BlocProvider(
                                            create: (_) => AppBloc(
                                                apiService: ApiService()),
                                            child: const LoginScreen(),
                                          )));
                            },
                            child: RichText(
                              text: const TextSpan(
                                text: 'Already have an account?',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey),
                                children: [
                                  TextSpan(
                                    text: ' Sign In',
                                    style: TextStyle(
                                        color: Color(0xffFF6600),
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 38),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70),
                      child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xffff6600).withOpacity(0.4),
                                blurRadius: 9.5,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: MaterialButton(
                            // elevation: 10,
                            onPressed: () {
                              if (ischecked) {
                                appBloc!.add(SignUpEvent(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    firstname: firstnameController.text,
                                    lastname: lastnameController.text,
                                    phone: phoneController.text,
                                    confirmPassword:
                                        confirmPasswordController.text,
                                    ccode: selectedCountry!.phoneCode));
                              } else {
                                Flushbar(
                                  message: 'Please accept terms and conditions',
                                  flushbarStyle: FlushbarStyle.GROUNDED,
                                  duration: const Duration(seconds: 3),
                                ).show(context);
                              }
                            },
                            child: isLoading!
                                ? const SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: CircularProgressIndicator(
                                        color: Colors.white))
                                : Text(
                                    "Next",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                        color: Colors.white),
                                  ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                            color: const Color(0xffFF6600),
                            minWidth: double.infinity,
                            height: 55,
                          )),
                    ),
                    const SizedBox(height: 10),
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
 // RegisterForm(
                    //     txt: 'Password',
                    //     controller: passwordController,
                    //     isObscure: true),
                    // RegisterForm(
                    //     txt: 'Confirm password',
                    //     controller: countryController,
                    //     isObscure: true),
                    // // const RegisterForm(
                    // //   txt: 'Country',
                    // // // ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => BlocProvider(
                    //                 create: (_) =>
                    //                     AppBloc(apiService: ApiService()),
                    //                 child: TermsAndConditionsScreen(),
                    //               )),
                    //     );
                    //   },
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(horizontal: 50),
                    //     child: Row(
                    //       children: [
                    //         Checkbox(
                    //           value: ischecked,
                    //           onChanged: (value) {
                    //             setState(() => ischecked = value!);
                    //           },
                    //           activeColor: Colors.black,
                    //           checkColor: Colors.white,
                    //         ),
                    //         const Text(
                    //           "Terms and Conditions",
                    //           style: TextStyle(
                    //             color: Colors.black,
                    //             fontSize: 14,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                 