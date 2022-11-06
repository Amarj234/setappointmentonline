import 'package:cement/servise.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'autotp.dart';


class regForm extends StatefulWidget {

  const regForm({Key? key}) : super(key: key);

  @override
  _regFormState createState() => _regFormState();
}




class _regFormState extends State<regForm> {
  Serves serves=Serves();

  final name  = TextEditingController();
  final mobile = TextEditingController();
  final  pass  =  TextEditingController();
  final  cpass  =  TextEditingController();
  final  otp  =  TextEditingController();


  Future Registerf() async{
    final uri = Uri.parse(serves.url+"index.php");
    var request = http.MultipartRequest('POST',uri);
    request.fields['name'] =  name.text;
    request.fields['email'] = mobile.text;
    request.fields['pass'] =  pass.text;
    request.fields['pass'] =  cpass.text;
    var response = await request.send();

    if (response.statusCode == 200) {
      print('Image Uploded');
    }else{
      print('Image Not Uploded');
    }
  }


  void _sendDataToSecondScreen(BuildContext context) {
    String Name1 = name.text;
    String mobile1 = mobile.text;
    String pass1 = pass.text;
    String cpass1 = cpass.text;


    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => autoOtp(name1: Name1,mobile1:mobile1,pass1:pass1,cpass1:cpass1),
        ));
  }



  bool sendotp =true;
  bool otpbox =false;
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

        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Card(

            shadowColor: Colors.blue,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Column(mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Center(

                      child: SizedBox(
                          height: 100,
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _formKey,
                        child: Center(
                          child:Column(
                            children: [
                              TextFormField(
                                controller: name,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border:  OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      borderSide: BorderSide(color: Colors.blue)),
                                  labelText: "Name",
                                  hoverColor: Colors.black12,
                                  hintText: "Enter Name",
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: mobile,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
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
                                height: 10,
                              ),

                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                obscureText: true,
                                decoration: InputDecoration(

                                  border:  OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      borderSide: BorderSide(color: Colors.blue)),
                                  labelText: "Password",
                                  hoverColor: Colors.black12,
                                  hintText: "Enter Password",
                                ),
                                controller: pass,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  if(value==pass.text){
                                    return null;
                                  }else{
                                    return 'Password not match';
                                  }

                                },
                                obscureText: true,
                                decoration: InputDecoration(

                                  border:  OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      borderSide: BorderSide(color: Colors.blue)),
                                  labelText: "Confirm Password",
                                  hoverColor: Colors.black12,
                                  hintText: "Enter Password",
                                ),
                                controller: cpass,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(onPressed: (){
                                if (_formKey.currentState!.validate()) {
                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.
                                  _sendDataToSecondScreen(context);
                                  ScaffoldMessenger.of(context).showSnackBar(

                                    const SnackBar(content: Text('Processing Data')),


                                  );
                                }


                              },
                                  child: Text('Register')),

                              SizedBox(
                                height: 20,
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Text('Allready Register',style: TextStyle(color: Colors.black),),
                                  TextButton(onPressed: (){

                                    Navigator.pop(context);
                                  }, child: Text('Click')),
                                ],
                              ),



                            ],
                          ) ,
                        ),
                      ),
                    )



                  ],
                ),

              ),
            ),
          ),
        ),
      ),
    );
  }
}
