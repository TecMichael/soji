import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:roomies_app/screens/home_screen.dart';
import 'package:roomies_app/screens/splash_screen.dart';
import 'package:caller/caller.dart';
import 'package:telephony/telephony.dart';
import 'screens/home_screen.dart';
import 'services/navigator_service.dart';
import 'services/notification_service.dart';
import 'utility/user_store.dart';

onBackgroundMessage(SmsMessage message)  {
  //Handle background message
  // You can also call other plugin in here
  NotificationService.searchData(message.address);
  print(
      '[ Message ] Ougoing call ended ${message.address}');
}

void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService.configLocalNotification();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge).then(
        (_) => runApp(  MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => UserStore()),
          ],
          child:  MyApp(),
        ),)
  );

}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Telephony telephony = Telephony.instance;

  @override
  void initState() {
    super.initState();

    if(Platform.isAndroid){
      telephony.listenIncomingSms(
          onNewMessage: (SmsMessage message) {
          },
          listenInBackground: true,
          onBackgroundMessage: onBackgroundMessage
      );}
    Provider.of<UserStore>(context,listen: false).initMixPanel();

  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.navigatorKey, // set property
      theme: ThemeData(
        primaryColor: Colors.deepOrangeAccent
      ),
      // debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
