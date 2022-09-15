import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class insertpage extends StatefulWidget {
  Map? m;
  insertpage({this.m});


  @override
  State<insertpage> createState() => _insertpageState();
}

class _insertpageState extends State<insertpage> {

  TextEditingController name = TextEditingController();
  TextEditingController phon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("insert in datbase"),),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(8.0),
            child: TextField(onChanged: (value) {

            },
              controller: name,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter name",
                hintText: "Name",
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(8.0),
            child: TextField(onChanged: (value) {

            },
              controller: phon,
              maxLength: 10,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter Mobbile Number",
                hintText: "phon",
              ),
            ),
          ),
          ElevatedButton(onPressed: () {

            DatabaseReference ref = FirebaseDatabase.instance.ref('contactbook').push();

            String? userid = ref.key;
            String nam=name.text;
            String phn=phon.text;
            Map m = {"userid":userid,"name":nam,"contact":phn};
            ref.set(m);

            print(m);
           /* Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return viewpage();
            },));*/

          }, child:Text("INSERT"))
        ],

      ),
    );
  }
}
