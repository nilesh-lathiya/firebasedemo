import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class otpdemo extends StatefulWidget {
  const otpdemo({Key? key}) : super(key: key);

  @override
  State<otpdemo> createState() => _otpdemoState();
}

class _otpdemoState extends State<otpdemo> {
  TextEditingController phon=TextEditingController();
  TextEditingController otpmsg=TextEditingController();
  String mverificationId = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("otp veryfication"),),
      body: Column(
        children: [
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
          ElevatedButton(onPressed: () async {
            String phone=phon.text;
            await FirebaseAuth.instance.verifyPhoneNumber(
              phoneNumber: '+91$phone',
              verificationCompleted: (PhoneAuthCredential credential) {},
              verificationFailed: (FirebaseAuthException e) {},
              codeSent: (String verificationId, int? resendToken) {
                mverificationId = verificationId;
              },
              codeAutoRetrievalTimeout: (String verificationId) {},
            );

          }, child: Text("SEND OTP")),
          Padding(padding: EdgeInsets.all(8.0),
            child: TextField(onChanged: (value) {


            },
              controller: otpmsg,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter OTP",
                hintText: "OTP",
              ),
            ),
          ),
          ElevatedButton(onPressed: () {

            String smsCode = otpmsg.text;
            PhoneAuthCredential credential = PhoneAuthProvider.credential(
                verificationId: mverificationId, smsCode: smsCode);
            // Sign the user in (or link) with the credential
            FirebaseAuth.instance
                .signInWithCredential(credential)
                .then((value) {
              print(value);
              if (value.user!.phoneNumber != null) {}
            });


          }, child:Text("VERYFY OTP"))

        ],
      ),
    );
  }
}
