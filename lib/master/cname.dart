import 'dart:convert';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../servise.dart';
class cnameMaster extends StatefulWidget {
  const cnameMaster({Key? key, required this.pagrid}) : super(key: key);
  final String pagrid;
  @override
  State<cnameMaster> createState() => _cnameMasterState();
}

class _cnameMasterState extends State<cnameMaster> {
  final _formKey = GlobalKey<FormState>();
  final name =TextEditingController();
String uid ='0';
  String button ='Save';

  void initState() {
    super.initState();
    allPerson();
  }

  List<DataRow> state2=[];
  Serves serves=Serves();

  Future allPerson() async {
    print('Showdata');
state2=[];
    final uri = Uri.parse(serves.url+"cement/master/Engineer.php");
    var response = await http.post(uri,body: {
      'showdata':"",
      'databash':"${widget.pagrid}",
    });

    var state= json.decode(response.body);
    setState(() {
      state.forEach((item) {
        state2.add( DataRow(

            cells: [

              DataCell(Text(item['id'])),
              DataCell(Text(item['name'])),
              DataCell(IconButton(
                icon: Icon(Icons.create,color: Colors.green,), onPressed: () {
Update(item['id'],item['name']);
              },
              )),
              DataCell(
                  IconButton(
                    icon: Icon(Icons.delete,color: Colors.red,), onPressed: () {
                      _Delete(item['id']);
                  },
                  )
              ),
            ]
        ),
        );
      }
      );
    });
  }
 void Update(upid,value){
    print(upid);
    setState(() {
      button="Update";
      name.text=value;
      uid=upid;
    });

 }


  _Delete(id) async{
    print('dele');
    var url2 = Uri.parse(serves.url+"cement/master/Engineer.php");
    var response = await http.post(url2, body: {
      'id':id,
      'delete':"",
    'databash':"${widget.pagrid}",
    });

    if (response.statusCode == 200) {

      var check =jsonDecode(response.body);

      if(check==1){

        setState(() {

        });
        allPerson();
      }else{
        setState(() {
          SnackBar(content: Text('Not insert'));
        });
      }
    }

  }


  Future Savedata() async{

    print('savedata');
    var url2 = Uri.parse(serves.url+"cement/master/Engineer.php");
    var response = await http.post(url2, body: {
      'name':name.text,
      'uid':uid,
      'databash':"${widget.pagrid}",
    });
    print(url2);
    if (response.statusCode == 200) {

      var check3 =jsonDecode(response.body);

      if(check3==1){
        allPerson();
        setState(() {
          name.text="";
uid='0';
          button="Save";
        });
      }else{
        setState(() {
          SnackBar(content: Text('Not insert'));
        });
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringUtils.capitalize('${widget.pagrid} Master')),

      ),
      body: SafeArea(

        child: Card(

          shadowColor: Colors.blue,
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
crossAxisAlignment: CrossAxisAlignment.center,
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
                            controller: name,
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
                              labelText: StringUtils.capitalize('${widget.pagrid} Name'),
                              hoverColor: Colors.black12,
                              hintText: 'Enter'+StringUtils.capitalize('${widget.pagrid} Name'),

                            ),
                            keyboardType:TextInputType.text ,

                          ),
                          SizedBox(
                            height: 20,
                          ),

                          ElevatedButton(onPressed: (){
                            Savedata();
                          },
                              child: Text(button)),


SizedBox(
  height: 20,
),
                          SizedBox(
                            height:  MediaQuery.of(context).size.height/3,
                            child: SingleChildScrollView(

                              scrollDirection: Axis.vertical,
                             // physics: NeverScrollableScrollPhysics(),
                              child: DataTable(

                                decoration: BoxDecoration(
                                  border:Border(

                                      right: Divider.createBorderSide(context, width: 5.0),
                                      left: Divider.createBorderSide(context, width: 5.0)
                                  ),

                                ),
                                columns: [
                                  DataColumn(label: Text('Id')),
                                  DataColumn(label: Text('Name')),
                                  DataColumn(label: Text('Edit')),
                                  DataColumn(label: Text('Delete')),
                                ],
                                rows: state2,
                              ),
                            ),
                          )



                        ],
                      ),
                    ) ,
                  ),
                )



              ],
            ),

          ),
        ),
      ),
    );
  }
}
