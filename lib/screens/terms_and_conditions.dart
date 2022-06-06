import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../utility/user_store.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<TermsAndConditionsScreen> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    Provider.of<UserStore>(context,listen: false).mixpanel!.track('Terms and Condition');

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text('Terms and Conditions',style: TextStyle(color: Colors.black87),),
        leading: IconButton(
          icon:Icon(Icons.arrow_back_ios_rounded,color: Colors.black,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: WebView(
        initialUrl: 'https://www.sojiare.com/terms',
      ),
    );
  }
}