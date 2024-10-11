import 'dart:ffi';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:first/component/textFied.dart';
import 'package:first/component/Mbuttom.dart';
import 'package:first/component/logo.dart';
import 'package:google_sign_in/google_sign_in.dart';
class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController email =TextEditingController();
  TextEditingController pass  =TextEditingController();
  GlobalKey<FormState> frm=GlobalKey();
  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null){
      return ;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context).pushReplacementNamed("home");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key:frm,
        child:ListView(
          padding:EdgeInsets.all(20),
          children: [
            Logo(image_name: "images/login3.jpg"),
            Text("Login" , style:TextStyle(fontSize:30 , fontWeight:FontWeight.bold)),
            Text("Login to continue using the app" ,
                style:TextStyle(fontSize:20, color:Colors.grey)),
            SizedBox(height:20),
            Text("Email" , style:TextStyle(fontSize:20 , fontWeight:FontWeight.bold)),
            SizedBox(height:10),
           CustField(hint:"Enter Your Email", controller: email ,
               valid:(val) {
             if (val == "") {
               return "Username can't be empty";
             }}
           ),
            SizedBox(height:10),
            Text("Password" , style:TextStyle(fontSize:20 , fontWeight:FontWeight.bold)),
            SizedBox(height:10),
            CustField(hint: "Enter Your Password", controller: pass, valid:(val) {
              if (val == "") {
                return "Username can't be empty";
              }}),
            InkWell(
              onTap:()async{
                if (email.text == ""){
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.rightSlide,
                    title: 'Error',
                    desc: 'Please Enter your email...',
                  ).show();
                  return;
                }
                try{
                await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.success,
                  animType: AnimType.rightSlide,
                  title: 'Error',
                  desc: 'Please Check Your email...',
                ).show();
                }catch(e){
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.rightSlide,
                    title: 'Error',
                    desc: 'Please enter the correct email..',
                  ).show();
                  print (e);
                }
              },
                child:Container(
                    margin:EdgeInsets.only(top:10 , bottom:20),
                    child:Text("Forget PassWord?" , textAlign:TextAlign.right ,
                        style:TextStyle(fontWeight:FontWeight.bold))
                )
            ),
            ButtonField(
              text: "LogIn",
              Fun_OnTop: () async {
                if (frm.currentState!.validate()) {
                  try {
                    // Sign in with email and password
                    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email.text,
                      password: pass.text,
                    );

                    // Check if email is verified
                    if (credential.user!.emailVerified) {
                      // If email is verified, navigate to home
                      Navigator.of(context).pushReplacementNamed("home");
                    } else {
                      // If email is not verified, send verification email and show dialog
                      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error',
                        desc: 'Email is not verified. A verification email has been sent to your inbox.',
                      ).show();
                    }
                  }
                  on FirebaseAuthException catch (e) {
                    if (e.code == "invalid-credential") {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error',
                        desc: 'The email or password is incorrect...',
                      ).show();
                    }
                  }
                } else {
                  // Show error if validation fails
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.rightSlide,
                    title: 'Error',
                    desc: 'Please fill in all fields.',
                  ).show();
                }
              },
            ),
            SizedBox(height:20),
            MaterialButton(
                height:40,
                color:Colors.black38 ,
                shape:RoundedRectangleBorder(
                  borderRadius:BorderRadius.circular(20),
                ),
                onPressed:(){
                  signInWithGoogle();
                },child:Row (
              mainAxisAlignment:MainAxisAlignment.center,
                children:[
                  Text("LogIn With Google ",
                      style: TextStyle(fontSize:25 , fontWeight:FontWeight.bold,color:Colors.white)),
                Image.asset("images/google.jpg" , height:30 , width:30)])),
            SizedBox(height:20),
            InkWell(
              onTap:(){
                Navigator.of(context).pushReplacementNamed("signup");
              },child:Center(
                child:Text.rich(TextSpan(
                children:[
                  TextSpan(text:"Don't have an account ?  " ,
                      style:TextStyle(fontSize:15) ),
                  TextSpan(text:"Register" , style:TextStyle(
                      fontSize:20,color:Colors.red,fontWeight:FontWeight.bold)),
                  ]
            ))))
          ],
        ),
      ),
    );
  }
}
