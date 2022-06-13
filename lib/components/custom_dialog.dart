
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roomies_app/model/responses/company_search_response.dart';

import '../bloc/post_bloc/bloc.dart';
import '../screens/report_screen.dart';
import '../screens/verify_screen.dart';
import '../services/api_service.dart';

class CustomDialogBox extends StatefulWidget {
  final SearchResultModel? result;
  final String? message;

  const CustomDialogBox({Key? key,this.result,this.message}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child:widget.result!.isScam!.toLowerCase()=='disclaimer'?emptyBox(context): contentBox(context),
    );
  }
  emptyBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 20,top: 35
              +29, right: 20,bottom: 20
          ),
          margin: const EdgeInsets.only(top: 35),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(color: Colors.black,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: SingleChildScrollView(
            child:
            Center(child: Column(
              children: [
                const SizedBox(
                    height: 20,
                    child: Text('Search Result ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.grey),)),

                SizedBox(
                    height: 50,
                    child: Text(widget.result!.description!,textAlign: TextAlign.center, style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500),)),

                Column(
                  children: [

                    Container(height: 10),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.flag,color:Colors.redAccent),
                      title: const Text('Flag',style: TextStyle(color: Colors.redAccent),),
                      tileColor: Colors.redAccent.withOpacity(0.1),
                      subtitle: Text('Flag ${widget.result!.searchedContent} as a scam',style: const TextStyle(fontSize: 12,color: Colors.redAccent),),
                      onTap: (){
                        Navigator.of(context).pop();
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return FractionallySizedBox(
                              heightFactor: 0.9,
                              child: BlocProvider<AppBloc>(
                                  create: (context) => AppBloc(apiService: ApiService()),
                                  child:  ReportScreen(
                                    title: widget.result!.searchedContent!,
                                    document: widget.result!.searchedContent!,
                                  )),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 20,),
                    ListTile(
                      leading: const Icon(Icons.verified_user,color: Colors.green,),
                      title: const Text('Verify',style: TextStyle(color: Colors.green),),
                      tileColor: Colors.green.withOpacity(0.1),
                      subtitle: Text('Confirm ${widget.result!.searchedContent} as a verified company',style: const TextStyle(fontSize: 12,color: Colors.green),),
                      onTap: (){
                        Navigator.of(context).pop();

                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,

                          builder: (context) {
                            return  FractionallySizedBox(
                              heightFactor: 0.9,
                              child: BlocProvider<AppBloc>(
                                  create: (context) => AppBloc(apiService: ApiService()),
                                  child:  VerifyScreen(
                                    title: widget.result!.searchedContent!,
                                    document: widget.result!.searchedContent!,
                                  )),
                            );
                          },
                        );
                      },
                    ),

                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close',style: TextStyle(fontSize: 18),)),
                ),

              ],
            ))

          ),
        ),
        const Positioned(
          left: 20,
          right: 20,
          child: CircleAvatar(
            backgroundColor:Colors.grey,
            radius: 35,
            child:  ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(35)),
                child:  Icon(Icons.hourglass_empty,color: Colors.white,)
            ),
          ),
        ),
      ],
    );
  }

  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 20,top: 35
              +29, right: 20,bottom: 20
          ),
          margin: const EdgeInsets.only(top: 35),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(color: Colors.black,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: SingleChildScrollView(
            child:widget.result!.isScam!.toLowerCase()=='yes'?
            Center(child: Column(
              children: [
                const SizedBox(
                    height: 20,
                    child: Text('Search Result ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.grey),)),
                SizedBox(
                    height: 30,
                    child: Text(widget.result!.searchedContent!,textAlign: TextAlign.center,style: const TextStyle(fontSize: 13,fontWeight: FontWeight.w400,color: Colors.grey),)),

                SizedBox(
                  height: 50,
                    child: Text(widget.result!.description!,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500),)),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close',style: TextStyle(fontSize: 18),)),
                ),

              ],
            )):
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: [
                    const Text('Business Name:'),
                    Expanded(child: Text(widget.result!.dataset!.companyName!,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500),)),
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    const Text('Phone:'),
                    Expanded(child:  Text(widget.result!.dataset!.phoneNumber!,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),),
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    const Text('Email:'),
                    Expanded(child: Text(widget.result!.dataset!.email!,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
                        ),
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    const Text('Website:'),
                    Expanded(child: Text(widget.result!.dataset!.website!,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    const Text('City:'),
                    Expanded(child: Text(widget.result!.dataset!.city!,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),              const SizedBox(height: 22,),

                Text(widget.result!.isScam!.toLowerCase()=='no'?'No scam records associated with this company' :'We have found some suspicious records about this company',style: TextStyle(fontSize: 14,color:widget.result!.isScam!.toLowerCase()=='no'?Colors.green: Colors.red,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),

                Align(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close',style:  TextStyle(fontSize: 18),)),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          child: CircleAvatar(
            backgroundColor:widget.result!.isScam!.toLowerCase()=='no'?Colors.green: Colors.red,
            radius: 35,
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(35)),
                child: Icon(widget.result!.isScam!.toLowerCase()=='no'? Icons.done:Icons.error_outline,color: Colors.white,)
            ),
          ),
        ),
      ],
    );
  }
}