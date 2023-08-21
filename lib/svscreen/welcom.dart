import 'package:flutter/material.dart';
import 'package:flutter_application_1/svscreen/signin.dart';

class welcom extends StatefulWidget {
  const welcom({super.key});

  @override
  State<welcom> createState() => _welcomState();
}

class _welcomState extends State<welcom> {
    final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        // leading: IconButton(
        // onPressed: () {
        //   Navigator.of(context).pop();
        //  },
        // icon: Icon(Icons.arrow_back_ios),
        //  ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 400,
                height: 300,
                child: Image.asset("assets/Illustration 1.jpg"),

                //_LoginscreenState
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: 400,
                color: Colors.white,
                child: Center(
                  child: Text(
                    " Let’s Take Care of Them ",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 100,
                width: 400,
                color: Colors.white,
                child: Center(
                  child: Text(
                    "    This is the best choice to please your      beloved pet, well yeah let’s do it. ",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => signin()),
                    );
                    
                  }
                  ;
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
                        child: Text("next",
                            style:
                                TextStyle(color: Colors.white, fontSize: 30))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}