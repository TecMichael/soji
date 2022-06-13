import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/post_bloc/bloc.dart';
import '../bloc/post_bloc/event.dart';
import '../bloc/post_bloc/state.dart';

class ReportScreen extends StatefulWidget {
  final String? document;
  final String? title;
  const ReportScreen({Key? key, this.title, this.document}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  bool? isLoading = false;
  AppBloc? appBloc;
  TextEditingController narrationController = TextEditingController();
  int? selectedOption = -1;

  @override
  void initState() {
    super.initState();
    appBloc = BlocProvider.of<AppBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state is LoadingState || state is InitialState) {
          setState(() {
            isLoading = true;
          });
        } else if (state is SignInPostedState) {
          setState(() {
            isLoading = false;
          });
          Navigator.of(context).pop();

          Flushbar(
            message: 'You have successfully flagged this number',
            flushbarStyle: FlushbarStyle.GROUNDED,
            duration: const Duration(seconds: 3),
          ).show(context);
        } else if (state is LoadFailureState) {
          Flushbar(
            message: state.error,
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
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Container(
            width: 70,
            height: 4,
            color: Colors.grey.shade300,
          ),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Flag',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffFF6600),
                  ),
                ),
                Text(
                  widget.title!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Are you sure you want to flag ${widget.title} as a suspicious phone number",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xff5E5E5E),
                      fontSize: 14,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 13),
                  child: const Text(
                    "Report Reasons",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 15,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedOption = 0;
                        narrationController.text =
                            'I was scammed through the number or email';
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: selectedOption == 0
                            ? const Color(0xffFF6600)
                            : Colors.white,
                        border: Border.all(
                          color: const Color(0xffFF6600),
                        ),
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20),
                      child: Text(
                        "I was scammed through the number or email",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: selectedOption == 0
                              ? Colors.white
                              : Colors.grey.shade500,
                          fontSize: 13,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedOption = 1;
                        narrationController.text =
                            "I received a suspicious phone call or SMS through this number";
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: selectedOption == 1
                            ? const Color(0xffFF6600)
                            : Colors.white,
                        border: Border.all(
                          color: const Color(0xffFF6600),
                        ),
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20),
                      child: Text(
                        "I was scammed through the number or email",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: selectedOption == 1
                              ? Colors.white
                              : Colors.grey.shade500,
                          fontSize: 13,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedOption = 2;
                      narrationController.clear();
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: selectedOption == 2
                          ? const Color(0xffFF6600)
                          : Colors.grey.shade300,
                    ),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 20),
                    child: Text(
                      "Others",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color:
                            selectedOption == 2 ? Colors.white : Colors.black,
                        fontSize: 13,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: selectedOption == 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: narrationController,
                          style: const TextStyle(color: Colors.black),
                          minLines: 1,
                          maxLines: 3,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 45.0, horizontal: 25.0),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Give Reasons',
                            focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide(color: Colors.grey)),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xffff6600).withOpacity(0.2),
                              blurRadius: 9.5,
                              offset: const Offset(1, 3),
                            ),
                          ],
                        ),
                        child: MaterialButton(
                          elevation: 10,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            "Cancel",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xfffffbfb),
                              fontSize: 14,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          color: Colors.grey,
                          height: 55,
                          minWidth: 150,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xffff6600).withOpacity(0.3),
                              blurRadius: 9.5,
                              offset: const Offset(1, 10),
                            ),
                          ],
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            appBloc!.add(SaveUserReport(
                                data: widget.document,
                                narration: narrationController.text,
                                context: context,
                                amount: '0.00'));
                          },
                          child: isLoading!
                              ? const SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: CircularProgressIndicator(
                                      color: Colors.white))
                              : const Text(
                                  "Submit",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xfffffbfb),
                                    fontSize: 14,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          color: const Color(0xffFF6600),
                          height: 55,
                          minWidth: 150,
                        ),
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
