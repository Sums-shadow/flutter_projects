import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sums/auth/loginAuth.dart';

class LoginAuth extends StatefulWidget {
  @override
  _LoginAuthState createState() => _LoginAuthState();
}

class _LoginAuthState extends State<LoginAuth> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String phoneNumber;
  String verificationCode;

  TextEditingController otpController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String verificationId;

  Future<void> verifyPhone(phoneNo) async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      verificationId = verId;
    };

    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential auth) {
      firebaseAuth.signInWithCredential(auth).then((UserCredential value) {
        if (value.user != null) {
          User user = value.user;
          userAuthorized();
        } else {
          debugPrint('user not authorized');
        }
      }).catchError((error) {
        debugPrint('error : $error');
      });
    };

    final PhoneVerificationFailed veriFailed =
        (FirebaseAuthException exception) {
      print('${exception.message}');
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verifiedSuccess,
        verificationFailed: veriFailed);
  }

  void verifyOTP(String smsCode) async {
    var _authCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
    firebaseAuth
        .signInWithCredential(_authCredential)
        .then((UserCredential result) {
      User user = result.user;

      if (user != null) {
        userAuthorized();
      }

      ///go To Next Page
    }).catchError((error) {
      Navigator.pop(context);
    });
  }

  userAuthorized() {
    print('can go to next page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Auth"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(
              size: 70,
            ),
            TextField(
              controller: email,
            ),
            TextField(
              controller: pass,
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(hintText: 'Enter phone Number'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Enter OTP'),
              ),
            ),
            RaisedButton(
              child: Text("Connect"),
              onPressed: () {},
            ),
            RaisedButton(
              child: Text("Create Account"),
              onPressed: () {},
            ),
            RaisedButton(
              child: Text("Facebook"),
              onPressed: () {
                _sign(context);
              },
            ),
            RaisedButton(
              child: Text("Gmail"),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
            RaisedButton(
              child: Text("Github"),
              onPressed: () {},
            ),
            RaisedButton(
              child: Text("Phone"),
              onPressed: () {
                verifyPhone(phoneController.text.trim());
              },
            ),
            RaisedButton(
              child: Text("Anonyme"),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }

  Future _sign(context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        
        content: const Text('A SnackBar has been shown.'),
      ),
    );
  }
}
