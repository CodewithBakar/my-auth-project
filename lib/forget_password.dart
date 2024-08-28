import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  var email = "";
  TextEditingController emailcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  reset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Password reset email has been send",
            style: TextStyle(fontSize: 40),
          )));
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "No user found on that email",
          style: TextStyle(fontSize: 40),
        )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          margin: EdgeInsets.only(top: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Password Recovery",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                "Enter your mail",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    wordSpacing: 5,
                    color: Colors.white),
              ),
              SizedBox(
                height: 40,
              ),
              Form(
                key: _formkey,
                child: Container(
                  height: 50,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: TextFormField(
                    controller: emailcontroller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 30,
                      ),
                      hintText: "Enter your E-Mail",
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  if(_formkey.currentState!.validate()){
                    setState(() {
                      email=emailcontroller.text;
                    });
                    reset();
                  }
                },
                child: Container(
                  height: 45,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Send E mail",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50,),
              Container(
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?", style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        wordSpacing: 5,
                        color: Colors.white),),
                    TextButton(onPressed: (){},
                        child: Text("Create", style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            wordSpacing: 5,
                            color: Colors.blueGrey.shade300),))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
