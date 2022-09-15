
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class fbfst extends StatefulWidget {
  const fbfst({Key? key}) : super(key: key);

  @override
  State<fbfst> createState() => _fbfstState();
}

class _fbfstState extends State<fbfst> {
  TextEditingController email= TextEditingController();
  TextEditingController pass=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("email paas"),),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(8.0),
            child: TextField(onChanged: (value) {

            },
              controller: email,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter Email",
                hintText: "Email",
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(8.0),
            child: TextField(onChanged: (value) {

            },
              controller: pass,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter Password",
                hintText: "Password",
              ),
            ),
          ),
          ElevatedButton(onPressed: () async {
            try {
              UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: email.text,
                password:pass.text,
              );

              print(credential);


            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                print('The password provided is too weak.');
              } else if (e.code == 'email-already-in-use') {
                print('The account already exists for that email.');
              }
            } catch (e) {
              print(e);
            }
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => fbfst(),));

          }, child: Text("Register")),
          ElevatedButton(onPressed: () async {
            try {
              final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                email:email.text,
                password:pass.text
              );

              print(credential);
            } on FirebaseAuthException catch (e) {
              if (e.code == 'user-not-found') {
                print('No user found for that email.');
              } else if (e.code == 'wrong-password') {
                print('Wrong password provided for that user.');
              }
            }

          }, child:Text("LOGIN"))
        ],
      ),

    );
  }
}
