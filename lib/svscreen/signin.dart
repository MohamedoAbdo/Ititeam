import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/svscreen/hoam.dart';
import 'package:flutter_application_1/svscreen/signup.dart';
import 'package:flutter_application_1/svscreen/welcom.dart';

class signin extends StatefulWidget {
  const signin({super.key});

  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {
   final _formKey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
    TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
         onPressed: () {
           Navigator.of(context).pop();
          },
         icon: Icon(Icons.arrow_back_ios),
          ),
        
        
        
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(children: [
            
            Image.asset(
            "assets/Vector (2).jpg",
            width: 400,
            height: 85,
            
            ),
             Container(
                height: 100,
                width: 400,
                color: Colors.white,
                child: Center(
                  child: Text(
                    " Hello,Welcome Back! ",
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
              SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: emailcontroller,
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) {
                  if (value == null || value.contains("@") == false) {
                    return "Enter valld email";
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                                controller: passwordcontroller,
                decoration: InputDecoration(labelText: "password"),
                validator: (value) {
                  if (value == null || value.length < 8) {
                    return "Enter valld password";
                  }
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
             
          
                  
            InkWell(
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                bool result =await firebaselogin (emailcontroller.text,passwordcontroller.text);
                   if(result ==true){ 

                  //final SharedPreferences prefs = await SharedPreferences.getInstance();
                  // await prefs.setString('email', emailcontroller.text);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => hoam()),
                  );
                   }else{ 
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('login faild')),
                  );
                   }
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 400,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Center(
                      child: Text("login",
                          style: TextStyle(color: Colors.white, fontSize: 20))),
                ),
              ),
            ),
              SizedBox(
              height: 20,
            ),
              Text(
              "Don’t have an account? ",
                    style: TextStyle(
                     fontSize: 12,

                    )
                  ),
                 
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => signup()),
                );
               },
                
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 50,
                  height: 20,
                  
                  child: Center(
                      child: Text("Create ",
                          style: TextStyle(color: Colors.orange, fontSize: 15))),
                ),
              ),
            ),
             SizedBox(
              height: 40,
            ),
            
          ]
          ),
        ),
      ),
    );
  }
  Future<bool>firebaselogin(String email,String password)async{
    try {
  UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
   if(userCredential.user !=null){
    return true;
   }
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
  }
}
  return false;
  }
}