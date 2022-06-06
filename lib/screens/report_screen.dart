import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roomies_app/components/register_form.dart';
import 'package:roomies_app/screens/pop_screen.dart';

import '../bloc/post_bloc/bloc.dart';
import '../bloc/post_bloc/event.dart';
import '../bloc/post_bloc/state.dart';

class ReportScreen extends StatefulWidget {
  final String? document;
  final String? title;
  const ReportScreen({Key? key,this.title,this.document}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  bool? isLoading=false;
  AppBloc? appBloc;
  TextEditingController narrationController = TextEditingController();
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
            message:'You have successfully flagged this number',
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
              title: Text('Flag ' + widget.title!, style: TextStyle(
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
                   padding: const EdgeInsets.all(8.0),
                   child: Text(
                    "Are you sure you want to flag ${widget.title} as a suspicious phone number",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w400,
                    ),
                ),
                 ),

                Divider(),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Report Reasons",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      selectedOption=0;
                      narrationController.text='I was scammed through the number or email';
                    });
                  },
                  child: Container(
                    color: selectedOption==0? Color(0xffFF6600): Colors.grey.shade300,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20),

                    child:  Text(
                      "I was scammed through the number or email",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: selectedOption==0? Colors.white:Colors.black,
                        fontSize: 13,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      selectedOption=1;
                      narrationController.text= "I received a suspicious phone call or SMS through this number";


                    });
                  },
                  child: Container(
                    color: selectedOption==1? Color(0xffFF6600): Colors.grey.shade300,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20),

                    child:  Text(
                      "I received a suspicious phone call or SMS through this number",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: selectedOption==1? Colors.white:Colors.black,
                        fontSize: 13,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 5,),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      selectedOption=2;
                      narrationController.clear();
                    });
                  },
                  child: Container(
                    color: selectedOption==2? Color(0xffFF6600): Colors.grey.shade300,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20),

                    child:  Text(
                      "Others",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: selectedOption==2? Colors.white:Colors.black,
                        fontSize: 13,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: selectedOption==2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric( vertical: 10),
                    child: Column(
                      children: [
                        TextFormField(
                          controller:narrationController,
                          style: const TextStyle(color: Colors.black),
                          minLines: 1,
                          maxLines: 3,
                          decoration:  InputDecoration(
                            isDense: true,
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 30.0, horizontal: 25.0),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText:
                                'Give Reasons',
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
                          appBloc!.add(SaveUserReport
                            (data: widget.document,narration: narrationController.text,context: context,amount:'0.00'));

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
