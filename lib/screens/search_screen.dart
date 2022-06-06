import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:roomies_app/bloc/post_bloc/event.dart';
import 'package:roomies_app/components/register_form.dart';
import 'package:roomies_app/screens/pop_screen.dart';

import '../bloc/post_bloc/bloc.dart';
import '../bloc/post_bloc/state.dart';
import '../components/custom_dialog.dart';
import '../utility/user_store.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool? isLoading=false;
  AppBloc? appBloc;
  TextEditingController searchController = TextEditingController();
  int? isSelected=1;
  String hint='Phone Number';
  int lines = 1;
  TextInputType? inputType;
  bool? hasSearchHappened;
  @override
  void initState() {
    super.initState();
    appBloc = BlocProvider.of<AppBloc>(context);
    inputType = TextInputType.number;

  }

  @override
  Widget build(BuildContext context) {
    return  BlocListener<AppBloc, AppState>(
      listener: (context,state){
        if(state is LoadingState || state is InitialState){
          setState(() {
            isLoading=true;
          });
        }else if(state is CompanySearchedState){
          setState(() {
            isLoading=false;
            hasSearchHappened=true;
          });

            showDialog(context: context,
            builder: (BuildContext context){
            return CustomDialogBox(
            result: state.companySearchResponse!.response!.data![0],

            );});
        if(state.companySearchResponse!.response!.data![0].dataset!=null) {
          Provider
              .of<UserStore>(context, listen: false)
              .mixpanel!
              .track('Search Action', properties: {
            'content': state.companySearchResponse!.response!.data![0].dataset!
                .content
          });
        }
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
        backgroundColor:  Colors.grey.shade200,
            appBar  : AppBar(
      centerTitle:true,
      backgroundColor: Colors.white,
            leading: IconButton(
              icon:Icon(Icons.arrow_back_ios_rounded,color: Colors.black,),
              onPressed: (){
                Navigator.of(context).pop(hasSearchHappened);
              },
            ),
      elevation: 0,
              title: Text('Search', style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
              ),),
      ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // const Text(
              //   "Sojiare",
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     color: Colors.black,
              //     fontSize: 25,
              //     fontFamily: "Montserrat",
              //     fontWeight: FontWeight.w700,
              //   ),
              // ),


              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [

                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            isSelected=1;
                            hint='Phone number';
                            lines=1;
                            inputType = TextInputType.number;


                          });
                        },
                        child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: isSelected==1? Color(0xffFF6600):Colors.white
                            ),
                            child:Center(child: Text('Phone Number',style: TextStyle(color: isSelected==1?Colors.white:Colors.black),))
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            isSelected=2;
                            hint='Email';
                            lines=1;
                            inputType = TextInputType.emailAddress;

                          });
                        },
                        child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: isSelected==2? Color(0xffFF6600):Colors.white
                            ),
                            child:Center(child: Text('Email',style: TextStyle(color: isSelected==2?Colors.white:Colors.black),))
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            isSelected=0;
                            hint='Paste document text here';
                            lines=7;
                            inputType = TextInputType.text;

                          });
                        },
                        child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: isSelected==0? Color(0xffFF6600):Colors.white
                            ),
                            child:Center(child: Text('Documents',style: TextStyle(color: isSelected==0?Colors.white:Colors.black),))
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  controller: searchController,
                  // keyboardType: inputType,
                  style:  TextStyle(color: Colors.black),
                  minLines: lines,
                  maxLines: lines,
                  decoration:  InputDecoration(
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
                    fillColor: Colors.white,

                    filled: true,
                    hintText:hint,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                        borderSide: BorderSide(color: Colors.grey)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    hintStyle: TextStyle(
                        color: Colors.black45,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 30),
                child: MaterialButton(
                  elevation: 10,
                  onPressed: () {
                    appBloc!.add(SearchCompanyEvent(data: searchController.text,type: 0));
                  },
                  child: isLoading!?SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(color:Colors.white)) :  Text(
                    "Verify",
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
                  height: 50,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
