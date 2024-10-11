import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:first/component/textFied.dart';
import 'package:first/component/Mbuttom.dart';
import 'package:first/component/logo.dart';
class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}
class _SignupState extends State<Signup> {
  TextEditingController email = TextEditingController();
  TextEditingController pass=TextEditingController();
  TextEditingController user = TextEditingController();
  TextEditingController con_pass = TextEditingController();
  GlobalKey<FormState> frm=GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: frm,
        child:ListView(
          padding:EdgeInsets.all(20),
          children: [
            Logo(image_name: "images/login3.jpg"),
            Text("Register" , style:TextStyle(fontSize:30 , fontWeight:FontWeight.bold)),
            Text("Enter Your Personal Information" ,
                style:TextStyle(fontSize:20 , color:Colors.grey)),
            SizedBox(height:20),
            Text("Username" , style:TextStyle(fontSize:20 , fontWeight:FontWeight.bold)),
            SizedBox(height:10),
            CustField(hint:"Enter Your Username", controller: user, valid:(val) {
              if (val == "") {
                return "Username can't be empty";
              }}),
            SizedBox(height:10),
            Text("Email" , style:TextStyle(fontSize:20 , fontWeight:FontWeight.bold)),
            SizedBox(height:10),
            CustField(hint:"Enter Your Email", controller: email, valid:(val) {
              if (val == "") {
                return "Username can't be empty";
              }}),
            SizedBox(height:10),
            Text("Password" , style:TextStyle(fontSize:20, fontWeight:FontWeight.bold)),
            SizedBox(height:10),
            CustField(hint: "Enter Your Password", controller: pass, valid:(val) {
              if (val == "") {
                return "Username can't be empty";
              }}),
            SizedBox(height:10),
            Text("Confirm Password" , style:TextStyle(fontSize:20 , fontWeight:FontWeight.bold)),
            SizedBox(height:10),
            CustField(hint:"Enter Confirm Password", controller: con_pass, valid:(val) {
              if (val == "") {
                return "Username can't be empty";
              }}),
            SizedBox(height:20),
            ButtonField(
            text: "SignUp",
            Fun_OnTop: () async {
              if (frm.currentState!.validate()) {
                // Check if password and confirm password match
                if (pass.text != con_pass.text) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.rightSlide,
                    title: 'Error',
                    desc: 'Passwords do not match. Please try again.',
                  ).show();
                  return;  // Prevent further execution if password and confirm password  don't match
                }
                try {
                  final credential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: email.text,
                    password: pass.text,
                  );
                  Navigator.of(context).pushReplacementNamed("home");
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      title: 'Error',
                      desc: 'The password provided is too weak.',
                    ).show();
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.info,
                      animType: AnimType.rightSlide,
                      title: 'Error',
                      desc: 'The account already exists for that email.',
                    ).show();
                  }
                } catch (e) {
                  print(e);
                }
              }},
          ),
          SizedBox(height:20),

          ],
        ),
      ),
    );
  }
}
