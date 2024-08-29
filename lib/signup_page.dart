import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xm/login_page.dart';
import 'package:xm/main.dart';
import 'package:xm/service/auth.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var email='', name='', password='';
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  TextEditingController usernamecontroller=TextEditingController();
  TextEditingController confrmpasswordcontroller=TextEditingController();

  final _formkey=GlobalKey<FormState>();

  Future Signup(String email,String password)async{
    if(email.isEmpty &&password.isEmpty){
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.grey,
          content: Text("Enter all data")));
    } else{

      try {
        UserCredential userCredencial=await FirebaseAuth.instance.
        createUserWithEmailAndPassword(email: email, password: password);
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: "Home"),));
      }
      on FirebaseAuthException catch(e){
        if(e.code=="weak-password"){
          return ScaffoldMessenger.of(context).
                  showSnackBar(SnackBar(
              backgroundColor: Colors.grey,
              content: Text("Password provided is too weak")));
        }else if(e.code=="email-already-in-use"){
          return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please use another email")));
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const SizedBox(height: 60.0),

                    const Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Create your account",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    )
                  ],
                ),
                Form(key: _formkey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        validator:(value){
                          if(value!.isEmpty|| value==null){
                            return "Please Enter Your Name";
                          }
                          return null;
                        },
                        controller: usernamecontroller,
                        decoration: InputDecoration(
                            hintText: "Username",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none),
                            fillColor: Colors.purple.withOpacity(0.1),
                            filled: true,
                            prefixIcon: const Icon(Icons.person)),
                      ),

                      const SizedBox(height: 20),

                      TextFormField(
                        validator: (value){
                          if(value==null || value.isEmpty){
                            return "Please Enter Email";
                          } return null;
                        },
                        controller: emailcontroller,
                        decoration: InputDecoration(
                            hintText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none),
                            fillColor: Colors.purple.withOpacity(0.1),
                            filled: true,
                            prefixIcon: const Icon(Icons.email)),
                      ),       //email

                      const SizedBox(height: 20),

                      TextFormField(
                        validator: (value){
                          if(value==null || value.isEmpty){
                            return "Please Enter Password";
                          } else if(value.length<6){
                            return "Provided password is too weak";
                          }return null;
                        },
                        controller:  passwordcontroller,
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
                      ),   //password

                      const SizedBox(height: 20),

                      TextFormField(
                        validator:  (value){
                          if(value==null || value.isEmpty){
                            return "Enter password to confirm";
                          }else if(value !=passwordcontroller){
                            return "Password not matched";
                          } else null;
                        },
                        controller: confrmpasswordcontroller,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: Colors.purple.withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.password),
                        ),
                        obscureText: true,
                      ),  // confirm pasword
                    ],
                  ),
                ),
                Container(
                    padding: const EdgeInsets.only(top: 3, left: 3),

                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                           email=emailcontroller.text;
                           name=usernamecontroller.text;
                           password=passwordcontroller.text;
                        });
                        Signup(emailcontroller.text, passwordcontroller.text,);

                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.purple,
                      ),
                    )
                ),

                const Center(child: Text("Or")),

                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Colors.purple,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: () {
                      AuthMethods().signInWithGoogle(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 30.0,
                          width: 30.0,
                          decoration: const BoxDecoration(
                            // image: DecorationImage(
                            //     image:   AssetImage('assets/images/login_signup/google.png'),
                            //     fit: BoxFit.cover),
                            shape: BoxShape.circle,
                          ),
                        ),

                        const SizedBox(width: 18),

                        const Text("Sign In with Google",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.purple,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Already have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context,MaterialPageRoute(builder:  (context) =>LoginPage(),) );
                        },
                        child: const Text("Login", style: TextStyle(color: Colors.purple,),)
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}