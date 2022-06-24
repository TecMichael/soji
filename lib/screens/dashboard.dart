import 'dart:async';
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:call_log/call_log.dart';
import 'package:caller/caller.dart';
import 'package:clipboard_listener/clipboard_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:roomies_app/bloc/post_bloc/event.dart';
import 'package:roomies_app/components/progress_content.dart';
import 'package:roomies_app/model/responses/company_search_response.dart';
import 'package:roomies_app/screens/search_screen.dart';
import 'package:roomies_app/screens/splash_screen.dart';

import '../bloc/post_bloc/bloc.dart';
import '../bloc/post_bloc/state.dart';
import '../components/custom_dialog.dart';
import '../components/custom_exit_dialog.dart';
import '../services/api_service.dart';
import '../services/cache_helper.dart';
import '../services/notification_service.dart';
import 'package:shared_preferences_android/shared_preferences_android.dart';
import 'package:shared_preferences_ios/shared_preferences_ios.dart';
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> callerCallbackHandler(
  CallerEvent event,
  String number,
  int duration,
) async {
  if (Platform.isAndroid) {
    SharedPreferencesAndroid.registerWith();
  } else if (Platform.isIOS) {
    SharedPreferencesIOS.registerWith();
  }
  print("New event received from native $event");
  switch (event) {
    case CallerEvent.incoming:
      {
        NotificationService.searchData(number);
        print(
            '[ Caller ] Incoming call ended, number: $number, duration $duration s');
      }
      break;
    case CallerEvent.outgoing:
      {
        NotificationService.searchData(number);
        print(
            '[ Caller ] Ougoing call ended, number: $number, duration: $duration s');
      }
      break;
  }
}

class DashboardScreen extends StatefulWidget {
  final CompanySearchResponse? response;
  const DashboardScreen({Key? key, this.response}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  AppBloc? appBloc;

  Future<void> _checkPermission() async {
    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.sms,
      Permission.phone,
    ].request();

    if (await Permission.phone.request().isGranted) {
      _startCaller();
      print('starting caller');
    } else {
      // You can request multiple permissions at once.
      Map<Permission, PermissionStatus> statuses = await [
        Permission.sms,
        Permission.contacts,
        Permission.phone,
      ].request();
    }
  }

  Future<void> _requestPermission() async {
    await Caller.requestPermissions();
    await _checkPermission();
  }

  Future<void> _stopCaller() async {
    await Caller.stopCaller();
  }

  Future<void> _startCaller() async {
    await Caller.initialize(callerCallbackHandler);
  }

  @override
  void initState() {
    super.initState();

    appBloc = BlocProvider.of<AppBloc>(context);
    appBloc!.add(SearchUserRecordEvent(context: context));
    _checkPermission();

    ClipboardListener.addListener(() async {
      print(' clipboard');
      var text = "${(await Clipboard.getData(Clipboard.kTextPlain))!.text}";
      print(text + 'from clipboard');

      if (text.trim().isNotEmpty) {
        NotificationService.searchData(text);
      }
    });

    if (widget.response != null) {
      // attempt to show dialog
      Timer.run(() {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialogBox(
                result: widget.response!.response!.data![0],
              );
            });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      var result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => BlocProvider<AppBloc>(
                                  create: (context) =>
                                      AppBloc(apiService: ApiService()),
                                  child: const SearchScreen())));
                      if (result != null) {
                        appBloc!.add(SearchUserRecordEvent(context: context));
                      }
                    },
                    child: Container(
                      width: 55,
                      height: 50,
                      padding: const EdgeInsets.only(right: 15, left: 15),
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade400)),
                      child: Row(
                        children: [
                          Text(
                            'Search ',
                            style: TextStyle(color: Colors.grey.shade500),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            exitDialog(context);
          },
          icon:  SvgPicture.asset(
            'assets/loggy.svg',
            color: Color(0xffFF6600),
          ),
        ),
        title: Image.asset(
          'assets/soji_logo.png',
          height: 25,
        ),
        actions: [
          IconButton(
            onPressed: () {
              appBloc!.add(SearchUserRecordEvent(context: context));
            },
            icon:SvgPicture.asset(
              'assets/renew.svg',
              color: Color(0xffFF6600),
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocListener<AppBloc, AppState>(
              listener: (context, state) async {
                if (state is LoadingState || state is InitialState) {
                } else if (state is SignInPostedState) {
                } else if (state is UserSearchCompletedState) {
                  if (state.companySearchResponse!.response!.data!.isEmpty) {
                    Iterable<CallLogEntry> entries = await CallLog.get();
                    var numbers = [];
                    entries
                        .toSet()
                        .toList()
                        .take(10)
                        .toList()
                        .forEach((element) {
                      numbers.add(element.number);
                    });
                    await ApiService().searchCompanyByPhone(numbers.join(','));
                    appBloc!.add(SearchUserRecordEvent(context: context));
                  }
                } else if (state is LoadFailureState) {
                  Flushbar(
                    message: state.error,
                    flushbarStyle: FlushbarStyle.GROUNDED,
                    duration: const Duration(seconds: 3),
                  ).show(context);
                } else {}
              },
              child: BlocBuilder<AppBloc, AppState>(
                builder: (context, state) {
                  if (state is LoadingState || state is InitialState) {
                    return Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    color: Color.fromARGB(255, 177, 67, 34),
                                  ))),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (state is UserSearchCompletedState) {
                    if (state
                        .companySearchResponse!.response!.data!.isNotEmpty) {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: state
                                .companySearchResponse!.response!.data!.length,
                            itemBuilder: (ctx, pos) {
                              return ProgressContent(
                                  result: state.companySearchResponse!.response!
                                      .data![pos]);
                            }),
                      );
                    } else {
                      return Container();
                      // Expanded(
                      //   child: Center(
                      //     child: Column(
                      //        mainAxisAlignment: MainAxisAlignment.center,
                      //        crossAxisAlignment: CrossAxisAlignment.center,
                      //        children: [
                      //          SvgPicture.asset(
                      //            'assets/soji_empty.svg',
                      //            height: 100,
                      //          ),
                      //          const SizedBox(height: 10,),
                      //          const Text('No Records Yet')
                      //        ],
                      //      ),
                      //   ),
                      // );
                    }
                  } else if (state is LoadFailureState) {
                    return Container();
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  exitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CustomExitDialog(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 25),
              const Text(
                "Are you sure you want to exit the app?",
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: MaterialButton(
                  elevation: 0,
                  color: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    "Logout",
                    style: GoogleFonts.josefinSans(
                        textStyle: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    )),
                  ),
                  onPressed: () async {
                    try {
                      CacheHelper().signOut();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider<AppBloc>(
                                create: (context) =>
                                    AppBloc(apiService: ApiService()),
                                child: const SplashScreen()),
                          ));
                    } catch (e) {
                      print("SIGN OUT ENDED WITH AN ERROR");
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: MaterialButton(
                  elevation: 0,
                  color: const Color(0xffFF6600).withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    "Cancel",
                    style: GoogleFonts.josefinSans(
                        textStyle: const TextStyle(
                      fontSize: 16,
                      color: Color(0xffFF6600),
                      fontWeight: FontWeight.w800,
                    )),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
