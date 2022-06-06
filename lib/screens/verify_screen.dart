import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roomies_app/components/register_form.dart';
import 'package:roomies_app/screens/pop_screen.dart';

import '../bloc/post_bloc/bloc.dart';
import '../bloc/post_bloc/event.dart';
import '../bloc/post_bloc/state.dart';

class VerifyScreen extends StatefulWidget {
  final String? document;
  final String? title;
  const VerifyScreen({Key? key,this.title,this.document}) : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  bool? isLoading=false;
  AppBloc? appBloc;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  int? selectedOption=-1;

  @override
  void initState() {
    super.initState();
    appBloc = BlocProvider.of<AppBloc>(context);

  }

  @override
  Widget build(BuildContext context) {
    return  BlocListener<AppBloc, AppState>(
      listener: (context,state){
        if(state is LoadingState || state is InitialState){
          setState(() {
            isLoading=true;
          });
        }else if(state is SignInPostedState){
          setState(() {
            isLoading=false;
          });
          Navigator.of(context).pop();

          Flushbar(
            message:'You have successfully verified this number',
            flushbarStyle: FlushbarStyle.GROUNDED,
            duration: Duration(seconds: 3),
          ).show(context);


        }
        else if(state is LoadFailureState){
          Flushbar(
            message:state.error,
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
      child: Scaffold(
        backgroundColor:  Colors.white,
        appBar  : AppBar(
          centerTitle:true,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,

          elevation: 0,
          title: Text('Verify ' + widget.title!, style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
          ),),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [


                Padding(
                  padding: const EdgeInsets.symmetric( vertical: 10),
                  child: Column(
                    children: [
                      TextFormField(
                        controller:nameController,
                        style: const TextStyle(color: Colors.black),
                        maxLines: 1,
                        decoration:  InputDecoration(
                          isDense: true,
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText:
                          'Company Name',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              borderSide: BorderSide(color: Colors.grey)),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(height:10),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric( vertical: 0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller:emailController,
                        style: const TextStyle(color: Colors.black),
                        maxLines: 1,
                        decoration:  InputDecoration(
                          isDense: true,
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText:
                          'Company Email',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              borderSide: BorderSide(color: Colors.grey)),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(height:10),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: MaterialButton(
                        elevation: 10,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child:  Text(
                          "Close",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xfffffbfb),
                            fontSize: 14,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        color:  Colors.grey,
                        height: 45,
                        minWidth: 150,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: MaterialButton(
                        elevation: 10,
                        onPressed: () {
                          appBloc!.add(VerifyUser
                            (content: widget.document,name: nameController.text,email: emailController.text,context: context));

                        },
                        child: isLoading!?SizedBox(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(color:Colors.white)) :  Text(
                          "Submit",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xfffffbfb),
                            fontSize: 14,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        color: const Color(0xffFF6600),
                        height: 45,
                        minWidth: 150,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
