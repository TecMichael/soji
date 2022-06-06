import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
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
import '../utility/user_store.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool ischecked = true;
  bool? isLoading=false;
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
    return  Scaffold(
      backgroundColor: const Color(0xffD8D6D6),
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          child: BlocListener<AppBloc, AppState>(
            listener: (context,state){
              if(state is LoadingState || state is InitialState){
                setState(() {
                  isLoading=true;
                });
              }else if(state is SignUpPostedState){
                setState(() {
                  isLoading=false;
                });

                Flushbar(
                  message:'Account Created',
                  flushbarStyle: FlushbarStyle.GROUNDED,
                  duration: const Duration(seconds: 3),
                ).show(context);
                // Navigator.pushNamed(context, LoginSuccessScreen.routeName);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => BlocProvider(
                    create: (_) => AppBloc(apiService: ApiService()),
                    child:     const LoginScreen(),
                  )),
                );
                Provider.of<UserStore>(context,listen: false).mixpanel!.track('Account Create Success');

              }
              else if(state is LoadFailureState){
                Flushbar(
                  message:'Oops! could not create you account at this time',
                  flushbarStyle: FlushbarStyle.GROUNDED,
                  duration: const Duration(seconds: 3),
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
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                color: const Color(0xffD8D6D6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
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
                      height: 50,
                      child: Text(
                        "Lets help you to get started",
                        style: TextStyle(
                          color: Color(0x99000000),
                          fontSize: 16,
                        ),
                      ),
                    ),
                     RegisterForm(
                      txt: 'Enter your first name',
                       controller: firstnameController,
                    ),
                    RegisterForm(
                      txt: 'Enter your last name',
                      controller: lastnameController,
                    ),
                     RegisterForm(
                      txt: 'Email',
                       controller: emailController,
                       inputType: TextInputType.emailAddress,

                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: (){
                              showCountryPicker(
                                context: context,
                                showPhoneCode: true,
                                countryListTheme: CountryListThemeData(
                                  flagSize: 25,
                                  backgroundColor: Colors.white,
                                  textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
                                  bottomSheetHeight: 600, // Optional. Country list modal height
                                  //Optional. Sets the border radius for the bottomsheet.
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                  ),
                                  //Optional. Styles the search field.
                                  inputDecoration: InputDecoration(
                                    labelText: 'Search',
                                    hintText: 'Start typing to search',
                                    prefixIcon: const Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: const Color(0xFF8C98A8).withOpacity(0.2),
                                      ),
                                    ),
                                  ),
                                ),
                                onSelect: (Country country) {
                                    setState(() {
                                      selectedCountry= country;
                                    });
                                },
                              );
                            },
                            child: Container(
                              height: 50,
                              padding: const EdgeInsets.all(8.0),
                              margin: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30)
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(selectedCountry==null?'Country':'+'+selectedCountry!.phoneCode,style: TextStyle(
                                        color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500)),
                                    Icon(Icons.keyboard_arrow_down_sharp,color: Colors.grey,)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                         Expanded(
                           flex: 3,
                           child: RegisterForm(
                            txt: 'Phone Number',
                             controller: phoneController,
                             inputType: TextInputType.phone,
                    ),
                         ),
                       ],
                     ),
                     RegisterForm(
                      txt: 'Password',
                       controller: passwordController,
                         isObscure:true
                    ),
                     RegisterForm(
                      txt: 'Confirm password',
                       controller: countryController,
                         isObscure:true
                    ),
                    // const RegisterForm(
                    //   txt: 'Country',
                    // ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BlocProvider(
                            create: (_) => AppBloc(apiService: ApiService()),
                            child:     TermsAndConditionsScreen(),
                          )),
                        );

                      },
                      child: Padding(
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
                    ),
                    const SizedBox(height: 38),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70),
                      child: MaterialButton(
                        elevation: 10,
                        onPressed: () {
                          if(ischecked){
                          appBloc!.add(SignUpEvent(
                              email: emailController.text,
                              password: passwordController.text,
                              firstname: firstnameController.text,
                              lastname: lastnameController.text,
                              phone: phoneController.text,
                              confirmPassword: confirmPasswordController.text,
                            ccode: selectedCountry!.phoneCode
                          ));
                          }else{
                            Flushbar(
                              message:'Please accept terms and conditions',
                              flushbarStyle: FlushbarStyle.GROUNDED,
                              duration: const Duration(seconds: 3),
                            ).show(context);
                          }
                        },
                        child: isLoading!?const SizedBox(
                          width: 25,
                            height: 25,
                            child: const CircularProgressIndicator(color:Colors.white)) :const Text(
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
                        height: 45,
                      ),
                    ),
                    const SizedBox(height: 28),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) =>   BlocProvider(
                              create: (_) => AppBloc(apiService: ApiService()),
                              child:     const LoginScreen(),
                            )));
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
