import 'dart:convert';

import 'package:cement/servise.dart';
import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:http/http.dart' as http;

import 'Reg.dart';
import 'dashboard.dart';

class autoOtp extends StatefulWidget {

  const autoOtp({Key? key,required this.name1  , required this.mobile1,required this.pass1, required this.cpass1, }) : super(key: key);
  final String mobile1;
  final String name1;
  final String pass1;
  final String cpass1;

  @override
  _autoOtpState createState() => _autoOtpState();
}

class _autoOtpState extends State<autoOtp> {
  regForm regform=regForm();
  Serves serves=Serves();


  Future checkOtp(String code) async{


      var url2 = Uri.parse(serves.url+"cement/checkotp.php");

      var response = await http.post(url2, body: {
        'mobile': widget.mobile1,
        'otp':code,
      });

      if (response.statusCode == 200) {

        var check =jsonDecode(response.body);
        print(check);
        if(check==1){
          Savedata();
        }else{
          setState(() {
            SnackBar(content: Text('Wrrong Otp'));
          });


        }
        // Navigator.push(
        //   context,MaterialPageRoute(builder: (context)=> autoOtp()),
        // );
      }
    }



  Future Savedata() async{


    var url3 = Uri.parse(serves.url+"cement/register.php");
    var response = await http.post(url3, body: {
      'name': widget.name1,
      'mobile': widget.mobile1,
      'pass': widget.pass1,
      'cpass': widget.cpass1,


    });
    if (response.statusCode == 200) {
      var check1 =jsonDecode(response.body);
      if(check1==1){
      setsesiion();
        Navigator.push(
          context,MaterialPageRoute(builder: (context)=> dashbord()),
        );
      }else{
        setState(() {
          SnackBar(content: Text('Somthig Error'));
        });


      }
      // Navigator.push(
      //   context,MaterialPageRoute(builder: (context)=> autoOtp()),
      // );
    }
  }

  setsesiion()async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    prefs.setInt('token', 8382946376);
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();

_listenotp();
  }
  _listenotp() async{
    await SmsAutoFill().listenForCode;
    await sendotpf();
  }


  Future sendotpf() async{

    final  gencode= await SmsAutoFill().getAppSignature;
    if(widget.mobile1.length==10) {
      var url4 = Uri.parse(serves.url+"cement/sendotp.php");
      var response = await http.post(url4, body: {
        'mobile': widget.mobile1,
        'gencode':gencode,
      });
      if (response.statusCode == 200) {

        SnackBar(content: Text('OTP Sent on Your Mobile'));
        // Navigator.push(
        //   context,MaterialPageRoute(builder: (context)=> autoOtp()),
        // );
      }
    }
  }
  final codea  = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("OTP Verification",style: TextStyle(fontSize: 30),),
                SizedBox(
                  height: 10,
                ),
                Text('We Will Send Your One time Password '),
                Text(' On Your Mobile Number'),
                SizedBox(
                  height: 20,
                ),
                PinFieldAutoFill(
controller: codea,
                  decoration: UnderlineDecoration(
                    textStyle: TextStyle(fontSize: 20, color: Colors.black),
                    colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
                  ),

                  onCodeSubmitted: (code) {
                    checkOtp(code);
                  },
                  onCodeChanged: (code) {
                    if (code!.length == 6) {
                      checkOtp(code);

                    }
                  },
                ),
SizedBox(
  height: 20,
),
                ElevatedButton(onPressed: (){

                    checkOtp(codea.text);


                },
                    child: Text('VERIFY')
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
