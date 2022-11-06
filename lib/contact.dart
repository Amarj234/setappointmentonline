import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'addfeed.dart';

class showcontact extends StatefulWidget {
  const showcontact({Key? key}) : super(key: key);

  @override
  State<showcontact> createState() => _showcontactState();
}

class _showcontactState extends State<showcontact> {






  List<Contact> contactlist=[];
  void  chooseContact() async{
    if (await Permission.contacts.request().isGranted) {
      List<Contact> contacts = await ContactsService.getContacts();
      setState(() {
        contactlist=contacts;

      });
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chooseContact();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('All contact'),
        ),
        body: SafeArea(
          child:     ListView.builder(
            shrinkWrap: true,
            itemCount: contactlist.length,
            itemBuilder: (_,index){
              Contact contact=contactlist[index];
              return InkWell(
                onTap: (){
                  addfeeds();

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
    );
  }
}





