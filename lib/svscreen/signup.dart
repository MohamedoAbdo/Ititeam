import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/svscreen/hoam.dart';
import 'package:flutter_application_1/svscreen/signin.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {

  final _forKey =GlobalKey<FormState>();
  bool ispassword = true;
  TextEditingController emailcontroller =TextEditingController();
  TextEditingController passwordcontroller =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
         leading: IconButton(
         onPressed: () {
           Navigator.of(context).pop();
          },
         icon: Icon(Icons.arrow_back_ios),
          ),
      ),
      body: Form(
        key: _forKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40,left: 10,bottom: 5),
                child: Text('Create New Account',
                  style: TextStyle(fontSize:40 ,fontWeight: FontWeight.bold),),
              ),
              
              // Text full name
              Padding(
                padding: const EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 10),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Full Name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder()),
                ),
              ),
              //Text phone
              Padding(
                padding: const EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 10),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value){
                    if(value == null || value.length < 11){
                      return 'Enter valid phone';
                    }
                  },
                  decoration: InputDecoration(labelText: 'Phone',
                      prefixIcon: Icon(Icons.mobile_friendly),
                      border: OutlineInputBorder()),
                ),
              ),

              SizedBox(
                height: 5,
              ),
              // bottom email
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: emailcontroller,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value){
                    if(value == null || value.contains('@gmail.com') ==false){
                      return 'Enter valid Email';
                    }
                  },
                  decoration: InputDecoration(labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder()),
                ),
              ),

              SizedBox(
                height: 5,
              ),
              // bottom password
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordcontroller,
                  obscureText: ispassword,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value){
                    if(value == null || value.length <8){
                      return 'Enter valid password';
                    }
                  },
                  decoration: InputDecoration(labelText: 'password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon:ispassword ? IconButton(icon: Icon(Icons.visibility_off),
                      onPressed:(){
                        setState(() {
                          ispassword = !ispassword;
                        });
                      } ,):IconButton(icon: Icon(Icons.visibility),
                        onPressed:(){
                          setState(() {
                            ispassword = !ispassword;
                          });
                        } ,),
                      border: OutlineInputBorder()),
                ),
              ),
              // bottom create
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  //padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: 350,

                  child: MaterialButton(onPressed: () async {
                       if(_forKey.currentState!.validate()) {
                         bool result =await fireBaseSingUp(emailcontroller.text, passwordcontroller.text);
                         if(result == true){
                           ScaffoldMessenger.of(context).showSnackBar(
                             const SnackBar(content: Text('success')),
                           );

                           Navigator.push(context, MaterialPageRoute(
                               builder: (context) => hoam()));
                         }

                       }
                  },
                    child: Text('Create an account',
                      style: TextStyle(color: Colors.white, fontSize: 20),),),
                ),
              ),
               
               Text(
              "Have an account? ",
                    style: TextStyle(
                     fontSize: 15,

                    )
                  ),
                 
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => signin()),
                );
               },
                
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 80,
                  height: 20,
                  
                  child: Center(
                      child: Text("sign in",
                          style: TextStyle(color: Colors.orange, fontSize: 15))),
                ),
              ),
            ),

             

            
           

            ],
          ),
        ),
      ),
    );
  }
  Future<bool> fireBaseSingUp(String email ,String password) async {
    try {
      UserCredential usercredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if(usercredential.user !=null){
        return true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
  }
