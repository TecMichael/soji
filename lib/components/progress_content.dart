import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:roomies_app/model/responses/company_search_response.dart';
import 'package:roomies_app/model/responses/search_history_response.dart';
import 'package:roomies_app/screens/verify_screen.dart';

import '../bloc/post_bloc/bloc.dart';
import '../screens/report_screen.dart';
import '../services/api_service.dart';
import '../utility/helper.dart';

class ProgressContent extends StatefulWidget {
  final UserSearchHistory? result;
  const ProgressContent({
    Key? key,
    this.result
  }) : super(key: key);

  @override
  State<ProgressContent> createState() => _ProgressContentState();
}

class _ProgressContentState extends State<ProgressContent> {
  var resolvedTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     resolvedTime =   Helper.getCustomFormattedDateTime(widget.result!.createdAt!, 'MM/dd/yy');

  }
  @override
  Widget build(BuildContext context) {
    var type =widget.result!.searchType;

    return Padding(
      padding: const EdgeInsets.only(top:10),
      child: Container(

        padding:  const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xfffffefe),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 7,
              blurRadius: 5,
              offset: const Offset(1, 2), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if(widget.result!.isScam!.toLowerCase()=='no')
                  CircleAvatar(
                    radius: 20,
                    backgroundColor:Colors.green.withOpacity(0.1),
                    child:  Icon( Icons.verified_user,color: Colors.green),
                  )
                  else if(widget.result!.isScam!.toLowerCase()=='yes')
                  CircleAvatar(
                    radius: 20,
                    backgroundColor:Color(0xffFF6600).withOpacity(0.1),
                    child:  Icon( Icons.not_interested,color: Color(0xffFF6600)),
                  )
                else if(widget.result!.isScam!.toLowerCase()=='disclaimer')
                    CircleAvatar(
                      radius: 20,
                      backgroundColor:Colors.grey.withOpacity(0.1),
                      child:  Icon( Icons.flag_outlined,color: Colors.grey),
                    )
                  else
                    CircleAvatar(
                      radius: 20,
                      backgroundColor:Colors.grey.withOpacity(0.1),
                      child:  Icon( Icons.flag_outlined,color: Colors.grey),
                    ),


                // CircularPercentIndicator(
                //   radius: 25.0,
                //   lineWidth: 5.0,
                //   percent: double.parse(widget.result!.prediction!)/100,
                //   center: new Text('${widget.result!.prediction!}%',style: const TextStyle(fontSize: 10),),
                //   progressColor: const Color(0xffFF6600),
                //   backgroundColor: Colors.grey.shade100,
                // ),
                SizedBox(width: 20),
                Expanded(

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right:5.0),
                            child: Icon(
                              type!.toLowerCase()=='email'?Icons.email: type.toLowerCase()=='phonenumber'?Icons.phone:type.toLowerCase()=='link'?Icons.link_sharp:Icons.insert_drive_file,
                              color:  Colors.black45,
                              size: 15,
                            ),
                          ),
                           Text(
                            widget.result!.search!,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                        ],
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                            text: '${resolvedTime}',
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black38,
                                fontWeight: FontWeight.w400)),
                      ),
                    ],
                  ),
                ),
                InkResponse(
                    onTap: (){
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return FractionallySizedBox(
                            heightFactor: 0.7,
                            child: Column(
                              children: [

                                Container(height: 10),
                                Container(height: 3,width: 80,color: Colors.grey,),
                                Container(height: 30),
                                ListTile(
                                  leading: const Icon(Icons.flag,color:Colors.redAccent),
                                  title: const Text('Flag',style: TextStyle(color: Colors.redAccent),),
                                  tileColor: Colors.redAccent.withOpacity(0.1),
                                  subtitle: Text('Flag ${widget.result!.search} as a fraudulent ${widget.result!.searchType!.toLowerCase()}',style: const TextStyle(fontSize: 12,color: Colors.redAccent),),
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
                                                title: '${widget.result!.search!}',
                                                document: '${widget.result!.search!}',
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
                                  subtitle: Text('Confirm ${widget.result!.search} as a verified ${widget.result!.searchType!.toLowerCase()}',style: const TextStyle(fontSize: 12,color: Colors.green),),
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
                                                title: '${widget.result!.search!}',
                                                document: '${widget.result!.search!}',
                                              )),
                                        );
                                      },
                                    );
                                  },
                                ),

                              ],
                            ),
                          );
                        },
                      );

                    },
                    child: const Icon(Icons.more_vert_outlined)),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
