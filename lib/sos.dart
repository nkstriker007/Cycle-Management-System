// importing dependencies
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
// cupertino package was unuses
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';


// function to trigger the app build
_makingPhoneCall() async {
  var url = Uri.parse("tel:112");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}
_call() async{
  var val=await FlutterPhoneDirectCaller.callNumber("+91 9498019327");
}
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SOS'),
        backgroundColor: Colors.red,
      ), // AppBar
      body: SafeArea(
        child: Center(
          child: Column(
            children: [ //Container
              Container(
                height:100,
              )
              ,const Text(
                'CLICK BELOW',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),//TextStyle
              ),//Text
              Container(
                height: 20.0,
              ),
              const Text(
                'FOR SOS HELP',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 20.0,
              ),
              IconButton(
                icon:Lottie.asset("assets/sos_button.json",
                    height:300,
                    width:300),
                onPressed: _call,
                style: ButtonStyle(
                  padding:
                  MaterialStateProperty.all(const EdgeInsets.all(5.0)),
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(color: Colors.red),
                  ),
                ),
              ), // ElevatedButton
            ],
          ),
        ),
      ),
    );
  }
}


