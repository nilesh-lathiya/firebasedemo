import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'googlsign.dart';

class logingoogl extends StatefulWidget {
  const logingoogl({Key? key}) : super(key: key);

  @override
  State<logingoogl> createState() => _logingooglState();
}

class _logingooglState extends State<logingoogl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("LOGIN WITH GOOGLE"),),
      body: Column(
        children: [
          ElevatedButton(onPressed: () {
            signInWithGoogle().then((value) {
              print(value);
              debugPrint("$value");
            });

          }, child:Text("LOGIN WITH GOOGLE")),
          ElevatedButton(onPressed: () async {
            await GoogleSignIn().signOut().then((value) {
              print("Logout");
            });


          }, child:Text("LOG out"))
        ],
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
