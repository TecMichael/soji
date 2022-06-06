// import 'dart:io';
//
// import 'package:caller/caller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:roomies_app/main.dart';
// import 'package:roomies_app/services/notification_service.dart';
//
// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
// Future<void> callerCallbackHandler(
// CallerEvent event,
//     String number,
// int duration,
// ) async {
// print("New event received from native $event");
// switch (event) {
// case CallerEvent.incoming:{
//
// NotificationService.searchNumber(number);
// print(
// '[ Caller ] Incoming call ended, number: $number, duration $duration s');
// }
// break;
// case CallerEvent.outgoing:{
//   NotificationService.searchNumber(number);
// print(
// '[ Caller ] Ougoing call ended, number: $number, duration: $duration s');
// }
// break;
// }
// }
//
//
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
//   bool? hasPermission;
//
//   @override
//   void initState() {
//     super.initState();
//     _checkPermission();
//
//   }
//
//
//   Future<void> _checkPermission() async {
//     final permission = await Caller.checkPermission();
//     print('Caller permission $permission');
//     setState(() => hasPermission = permission);
//   }
//
//   Future<void> _requestPermission() async {
//     await Caller.requestPermissions();
//     await _checkPermission();
//   }
//
//   Future<void> _stopCaller() async {
//     await Caller.stopCaller();
//   }
//
//   Future<void> _startCaller() async {
//     if (hasPermission != true) return;
//     await Caller.initialize(callerCallbackHandler);
//   }
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Text(hasPermission == true ? 'Has permission' : 'No permission'),
//         ElevatedButton(
//           onPressed: () => _requestPermission(),
//           child: Text('Ask Permission'),
//         ),
//         ElevatedButton(
//           onPressed: () => _startCaller(),
//           child: Text('Start caller'),
//         ),
//         ElevatedButton(
//           onPressed: () => _stopCaller(),
//           child: Text('Stop caller'),
//         ),
//       ],
//     ),);
//   }
// }
