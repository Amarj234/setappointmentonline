import 'dart:convert';

import 'package:cement/servise.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cement/Reg.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard.dart';
import 'notification/home_view.dart';
import 'notification/notification.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home:  LoginForm(),


      ),
        providers: [
        ChangeNotifierProvider(create: (_) => NotificationService())
    ]
    );


  }
}

 
class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  Serves serves=Serves();

  final mobile = TextEditingController();
  final  password  =  TextEditingController();

  Future Savedata() async{

print('savedata');
    var url3 = Uri.parse(serves.url+"cement/login.php");

    var response = await http.post(url3, body: {

      'mobile': mobile.text,
      'pass': password.text,



    });

    if (response.statusCode ==200) {
     
    }
  }


  setsesiion() async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    prefs.setInt('token', 8382946376);
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rkd Cement'),
        leading: IconButton(
          icon: Icon(Icons.menu), onPressed: () {  },
        ),
      ),
      body: SafeArea(

        child: Card(

          shadowColor: Colors.blue,
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(

                  child: SizedBox(
                      height: 200,
                      width: 180,
                      child:CircleAvatar(radius: (80),
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius:BorderRadius.circular(80),
                            child: Image.asset('assets/images.png'),
                          )
                      )
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  child: Center(
                    child:Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: mobile,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Mobile';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border:  OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: Colors.blue)),
                              labelText: "Mobile",
                              hoverColor: Colors.black12,
                              hintText: "Enter Mobile",

                            ),
                            keyboardType:TextInputType.number ,
                            maxLength: 10,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: password,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Mobile';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border:  OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: Colors.blue)),
                              labelText: "Password",
                              hoverColor: Colors.black12,
                              hintText: "Enter Password",

                            ),
                            keyboardType:TextInputType.text ,
                            maxLength: 10,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(onPressed: (){

                            Savedata();
                          },
                              child: Text('Login')),

                          SizedBox(
                            height: 20,
                          ),
                          TextButton(onPressed: (){
                            Navigator.push(
                              context,MaterialPageRoute(builder: (context)=> HomePage()),
                            );

                          }, child: Text('Forgate Password')),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Text('New User',style: TextStyle(color: Colors.black),),
                              TextButton(onPressed: (){
                                Navigator.push(
                                  context,MaterialPageRoute(builder: (context)=> regForm()),
                                );

                              }, child: Text('Click')),
                            ],
                          ),



                        ],
                      ),
                    ) ,
                  ),
                ),



              ],
            ),

          ),
        ),
      ),
    );
  }
}
