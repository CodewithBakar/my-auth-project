import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xm/forget_password.dart';
import 'package:xm/main.dart';
import 'package:xm/signup_page.dart';
import 'package:xm/widgets/uihelper.dart';




class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var email='',password='';
  TextEditingController emailcontroller=new TextEditingController();
  TextEditingController passwordcontroller=new TextEditingController();
  final _formkey=GlobalKey<FormState>();

  login(String email,String password)async{
    if(email==null || email.isEmpty && password==null || password.isEmpty){
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter required credentials")));
    } else {
      try {
        UserCredential? usercredential =await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: "Home"),));
      }
      on FirebaseAuthException catch(e){
        if (e.code=="email-not-found"){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.grey,
              content: Text("Enter correct Email",style: Uihelper.headlineBoldStyle(),)));
        }else if(e.code=="wrong-password"){
          return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.grey,
              content: Text("Enter Correct password")));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),
              _forgotPassword(context),
              _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return const Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Enter your credential to login"),
      ],
    );
  }

  _inputField(context) {
    return Form(
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            validator: (value){
              if(value==null || value.isEmpty){
                return "Enter Email";
              } return null;
            },
            controller: emailcontroller,
            decoration: InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none
                ),
                fillColor: Colors.purple.withOpacity(0.1),
                filled: true,
                prefixIcon: const Icon(Icons.person)),
          ),
          const SizedBox(height: 10),
          TextFormField(
            validator: (value){
              if(value==null || value.isEmpty){
                return "Enter your password";
              } return null;
            },
            controller: passwordcontroller,
            decoration: InputDecoration(
              hintText: "Password",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Colors.purple.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.password),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              if(_formkey.currentState!.validate()){
                setState(() {
                  email=emailcontroller.text;
                  password=passwordcontroller.text;
                });
              }
              MyHomePage(title: "Home",);
            },
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.purple,
            ),
            child: const Text(
              "Login",
              style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Forgetpassword(),));
      },
      child: const Text("Forgot password?",
        style: TextStyle(color: Colors.purple),
      ),
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Dont have an account? "),
        TextButton(
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder:  (context) =>SignupPage(),) );

            },
            child: const Text("Sign Up", style: TextStyle(color: Colors.purple),)
        )
      ],
    );
  }
}