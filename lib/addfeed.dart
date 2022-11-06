import 'dart:convert';
import 'package:contacts_service/contacts_service.dart';
import 'package:cement/servise.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
class addfeeds extends StatefulWidget {

  const addfeeds( {Key? key}) : super(key: key);


  @override
  State<addfeeds> createState() => _addfeedsState();
}

class _addfeedsState extends State<addfeeds> {




  Serves serves=Serves();
  final _formKey = GlobalKey<FormState>();
  final eggname  = TextEditingController();
  final mobile = TextEditingController();
  final  date  =  TextEditingController();
  final  customername  =  TextEditingController();
  final  contactorname  =  TextEditingController();
  final contactormobile = TextEditingController();
  final visiteggname  = TextEditingController();
  final eggmobile = TextEditingController();
  final  place  =  TextEditingController();
  final  city  =  TextEditingController();
  final  satage  =  TextEditingController();
  final  nofstorey  =  TextEditingController();
  final  cementbrand  =  TextEditingController();
  final revisitnew =TextEditingController();
  final remark  = TextEditingController();
  final notifydate = TextEditingController();
  final  alarmdate  =  TextEditingController();



  Future Registerf() async{
    final uri = Uri.parse(serves.url+"savedata.php");
    var request = http.MultipartRequest('POST',uri);
    request.fields['loginid'] =  mobile.text;
    request.fields['mobile'] = mobile.text;
    request.fields['engineername'] =  eggname.text;
    request.fields['customername'] =  customername.text;
    request.fields['contactormabile'] =  contactormobile.text;
    request.fields['contactorname'] = contactorname.text;
    request.fields['place'] = place.text;
    request.fields['city'] =  city.text;
    request.fields['stageifcost'] =  satage.text;
    request.fields['noofstorey'] =  nofstorey.text;
    request.fields['cementbrand'] =  cementbrand.text;
    request.fields['visitengname'] = visiteggname.text;
    request.fields['visitengmobile'] =  visiteggname.text;
    request.fields['nammeetinge'] =  mobile.text;
    request.fields['savedate'] =  date.text;
    request.fields['notificatindate'] = notifydate.text;
    request.fields['remark'] =  remark.text;

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Image Uploded');
    }else{
      print('Image Not Uploded');
    }
  }

  var selectedDate;
int? setnum;

List<String> state=[];

 void allCity() async {
    final uri = Uri.parse(serves.url+"cement/master/showmaster.php");
    var response = await http.post(uri,body: {
      'showcity':"",
    });
    var state1 = json.decode(response.body);
    print(state1);
    setState(() {
      state1.forEach((value)=>
          state.add(
            value['name']
          ),
      );
    });

  }

  List<String> state12=[];

  void allengineer() async {
    final uri = Uri.parse(serves.url+"cement/master/showmaster.php");
    var response = await http.post(uri,body: {
      'showengineer':"",
    });
    var showengineer = json.decode(response.body);
    print(showengineer);
    setState(() {
      showengineer.forEach((value)=>
          state12.add(
              value['name']
          ),
      );

    });

  }

  List<String> Place=[];

   void allplace() async {

    final uri = Uri.parse(serves.url+"cement/master/showmaster.php");
    var response = await http.post(uri,body: {
      'showplace':"",
    });
    print('place1');
    var place1 = json.decode(response.body);
//print(place1);
    setState(() {
      place1.forEach((value)=>
          Place.add(
              value['name']
          ),
      );
    });

  }

  List<String> Cement=[];

 void allCement() async {
    final uri = Uri.parse(serves.url+"cement/master/showmaster.php");
    var response = await http.post(uri,body: {
      'showcement':"",
    });
    var Cement1 = json.decode(response.body);

    setState(() {
      Cement1.forEach((value)=>
          Cement.add(
              value['name']
          ),
      );
    });

  }
  List<Contact> contactlistfilter=[];
  List<Contact> contactlist=[];
  void  chooseContact() async{
    if (await Permission.contacts.request().isGranted) {
      List<Contact> contacts = await ContactsService.getContacts();
      setState(() {
        contactlist=contacts;
        showMyDialog();
        Searchcontroller.addListener(() {
          filterContacts();
        });
      });
    }
  }

TextEditingController Searchcontroller=TextEditingController();



@override
  void initState() {
    // TODO: implement initState
    super.initState();
    allCity();
    allengineer();
    allplace();
    allCement();

  }
  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }
  filterContacts() {
    List<Contact> _contacts = [];
    _contacts.addAll(contactlist);
    if (Searchcontroller.text.isNotEmpty) {
      _contacts.retainWhere((contact) {
        String searchTerm = Searchcontroller.text.toLowerCase();
        String searchTermFlatten = flattenPhoneNumber(searchTerm);
        String contactName = contact.displayName!.toLowerCase();
        bool nameMatches = contactName.contains(searchTerm);
        if (nameMatches == true) {
          return true;
        }

        if (searchTermFlatten.isEmpty) {
          return false;
        }

        var phone = contact.phones!.firstWhere((phn) {
          String phnFlattened = flattenPhoneNumber(phn.value.toString());
          return phnFlattened.contains(searchTermFlatten);
        }, );

        return phone != null;
      });
    }
    setState(() {
      contactlist=[];
      contactlist = _contacts;
     // showMyDialog();
      print(contactlist);
    });
  }
  List Mettig=[{
    '1': 'next Meeting',
    '0': 'Fainl',
  }
  ];
  String? stateval;

  @override
  Widget build(BuildContext context) {


    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Customer Details'),
        ),
        body: SafeArea(
          child:  SafeArea(

            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Card(

                    shadowColor: Colors.blue,
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
                                    Row(
                                      children: [
                                        Flexible(
                                          child: TextFormField(
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
                                              counter: Offstage(),
                                            ),
                                            keyboardType:TextInputType.number ,
                                            maxLength: 10,
                                          ),
                                        ),
                                        IconButton(onPressed: (){
                                          chooseContact();
                                          setnum=1;
                                        }, icon: Icon(Icons.contact_phone))
                                      ],
                                    ),




                                    SizedBox(
                                      height: 10,
                                    ),


                                    DropdownSearch<String>(
                                        mode: Mode.MENU,
                                        showSearchBox: true,
                                        showSelectedItems: true,
                                        items: state12,

                                        popupItemDisabled: (String s) => s.startsWith('I'),
                                        onChanged: print,
                                        selectedItem: "Select City"),
                                    SizedBox(
                                      height: 10,
                                    ),

                                    DateTimeField(
                                        initialDate: DateTime.now(),
                                        decoration: InputDecoration(
                                          border:  OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                              borderSide: BorderSide(color: Colors.blue)),
                                          labelText: "Date",
                                          hoverColor: Colors.black12,
                                          hintText: "Select Date",
                                          prefixIcon: Icon(Icons.date_range)
                                        ),

                                        selectedDate: selectedDate,
                                        onDateSelected: (DateTime value) {
                                          setState(() {
                                            selectedDate = value;
                                          });
                                        }),
                                          SizedBox(
                                            height: 10,
                                          ),
                                    addtextFilds(name:"Customer Name" ,hinttext:"Enter Customer Name", controll:customername),


                                    SizedBox(
                                      height: 10,
                                    ),

                                    Row(
                                      children: [
                                        Flexible(
                                          child: TextFormField(
                                            controller: contactormobile,
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
                                              labelText: "Customer Mobile",
                                              hoverColor: Colors.black12,
                                              hintText: "Enter Customer Mobile",
                                              counter: Offstage(),
                                            ),
                                            keyboardType:TextInputType.number ,
                                            maxLength: 10,
                                          ),
                                        ),
                                        IconButton(onPressed: (){
                                          chooseContact();
setnum=2;
                                        }, icon: Icon(Icons.contact_phone))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    addtextFilds(name:"Conttactor Name" ,hinttext:"", controll:contactorname),

                                    SizedBox(
                                      height: 10,
                                    ),

                                    DropdownSearch<String>(
                                        mode: Mode.MENU,
                                        showSearchBox: true,
                                        showSelectedItems: true,
                                        items: Place,

                                        popupItemDisabled: (String s) => s.startsWith('I'),
                                        onChanged: print,
                                        selectedItem: "Select Place"),



                                    SizedBox(
                                      height: 10,
                                    ),



                                    DropdownSearch<String>(
                                        mode: Mode.MENU,
                                        showSearchBox: true,
                                        showSelectedItems: true,
                                        items: state,

                                        popupItemDisabled: (String s) => s.startsWith('I'),
                                        onChanged: print,
                                        selectedItem: "Select City"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    addtextFilds(name:"Stage of work" ,hinttext:"Enter Stage of work", controll:satage),

                                    SizedBox(
                                      height: 10,
                                    ),
                                    addtextFilds(name:"No of Storey" ,hinttext:"Enter no of Storey", controll:nofstorey),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    DropdownSearch<String>(

                                        mode: Mode.MENU,
                                        showSearchBox: true,
                                        showSelectedItems: true,
                                        items: Cement,

                                        popupItemDisabled: (String s) => s.startsWith('I'),
                                        onChanged: (value){

                                        },
                                        selectedItem: "Select Brand"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    addtextFilds(name:"Visit Egg Name" ,hinttext:"Visit Egg Name", controll:visiteggname),

                                    SizedBox(
                                      height: 10,
                                    ),
                                    addtextFilds(name:"Visit Egg Mobile" ,hinttext:"Enter Visit Egg Mobile", controll:nofstorey),
                                    Container(
                                      width: 400,
                                      margin: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          border: Border.all(


                                          ),
                                          borderRadius: BorderRadius.circular(10)),
                                      child:   DropdownButton<String>(
                                          hint: stateval==null ? Text('Select Value') :Text(stateval!),
                                    
                                        disabledHint: Text('Select State fist'),
                                        items: [
                                          DropdownMenuItem(

                                            value: 'Final',
                                            child: Text('Final'),
                                          ),
                                          DropdownMenuItem(
                                            value: 'Next Meeting',
                                            child: Text('Next Meeting'),
                                          ),

                                        ],
                                          onChanged: (_value)=>{

                                            setState(() {
                                              stateval=_value!;

                                            }),

                                          }

                                      ),
                                    ),

                                    SizedBox(
                                      height: 10,
                                    ),

                                    DateTimeField(
                                        initialDate: DateTime.now(),
                                        decoration: InputDecoration(
                                            border:  OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                borderSide: BorderSide(color: Colors.blue)),
                                            labelText: "Date",
                                            hoverColor: Colors.black12,
                                            hintText: "Select Date",
                                            prefixIcon: Icon(Icons.date_range)
                                        ),

                                        selectedDate: selectedDate,
                                        onDateSelected: (DateTime value) {
                                          setState(() {
                                            selectedDate = value;
                                          });
                                        }),

                                    SizedBox(
                                      height: 10,
                                    ),
                            TextFormField(
                              maxLines: 8,
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
                                labelText: 'Remark',
                                hoverColor: Colors.black12,
                                hintText: 'Enter Remark',
                              ),
                            ),


                                    SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(onPressed: (){
                                      if (_formKey.currentState!.validate()) {
                                        // If the form is valid, display a snackbar. In the real world,
                                        // you'd often call a server or save the information in a database.

                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Processing Data')),


                                        );
                                      }


                                    },
                                        child: Text('Save')),




                                  ],
                                ) ,
                              ),
                            ),
                          ),



                          SizedBox(
                            height: 200,
                          ),
                        ],
                      ),

                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget addtextFilds({required String name ,required String hinttext,required TextEditingController controll, }){
   return  TextFormField(
     controller: controll,
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
       labelText: name,
       hoverColor: Colors.black12,
       hintText: hinttext,
     ),
   );



  }
    showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Contact List'),

          content: Column(
            children: [
              SizedBox(
                height: 30,
                child: TextField(
                  onChanged: (v){
                    filterContacts();
                  },
                  controller: Searchcontroller,
                  decoration: new InputDecoration(
                    icon: new Icon(Icons.search),
                    labelText: "Seach Contact",
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: 350,
                  width: 200,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: contactlist.length,
                    itemBuilder: (_,index){
                      Contact contact=contactlist[index];
                      return InkWell(
                        onTap: (){
                       setState(() {
                         if(setnum==1) {
                           mobile.text =
                               contact.phones!.elementAt(0).value.toString();
                           customername.text = contact.displayName.toString();
                         }else{
                           contactormobile.text =
                               contact.phones!.elementAt(0).value.toString();
                           contactorname.text=contact.displayName.toString();
                         }

                         Navigator.of(context).pop();

                       });

                        },
                        child: ListTile(
                          title: Text(contact.displayName.toString()),
                          subtitle: Text(contact.phones!.elementAt(0).value.toString()),
                          leading: (contact.avatar != null && contact.avatar!.length > 0)
                              ? CircleAvatar(
                            backgroundImage: MemoryImage(contact.avatar!),
                          )
                              : CircleAvatar(
                              child: Text(contact.initials(),
                                  style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors.transparent),
                        ),
                      ) ;

                    },
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cencel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
