import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var usernameController = TextEditingController();
    var passwordController = TextEditingController();

    return Scaffold(
      //App bar
      appBar: AppBar(
        backgroundColor: Color(0xFF851229),
        title: const Text("Firewatch",
          style: TextStyle(
            color: Color(0xFFd0d2d6),
            fontSize: 18,
            fontWeight: FontWeight.bold,
            ),
        ),
        centerTitle: true,
      ),

      //Body
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          SizedBox(height: 5),

          //Image
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 255,
            child: Image.asset("assets/sept.png"),
          ),

          //spacing
          const SizedBox(height: 40,),

          //Form information
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              decoration: const BoxDecoration(
              //TODO change colour of box if needed
              color: Colors.white70,
              boxShadow: [
                BoxShadow(
                  blurRadius: 8,
                  color: Colors.black26,
                  offset: Offset(0,-3),
                ),
              ]

            ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: <Widget>[
                    Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            //username form field
                            TextFormField(
                              controller: usernameController,
                              validator: (val) => val == "" ? "Please enter your username" : null,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                                hintText: "Username...",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: Colors.white
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color: Colors.white60,
                                    )
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color: Colors.white60,
                                    )
                                ),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color: Colors.white60,
                                    )
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),

                            const SizedBox(height: 20),

                            //password form field
                            TextFormField(
                              controller: passwordController,
                              validator: (val) => val == "" ? "Please enter your password" : null,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                ),
                                hintText: "Password...",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color: Colors.white60,
                                    )
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color: Colors.white60,
                                    )
                                ),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color: Colors.white60,
                                    )
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),

                            const SizedBox(height: 20,),

                            //Submit button
                            Material(
                              color: Color(0xFF851229),
                              child: InkWell(
                                onTap: (){

                                },
                                borderRadius: BorderRadius.circular(30),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 28,
                                  ),
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Color(0xFFd0d2d6),
                                      fontSize: 16,


                                    )
                                  )
                                )
                              )
                            )
                          ],
                        ),
                      )

                  )
                ],


                ),
              ),
            ),
          ),


          const SizedBox(height: 10),

          //New user?
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "New user?",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              TextButton(
                onPressed: (){

                },
                child: const Text(
                    "Register here",
                style: TextStyle(
                  color: Colors.blue,
                  ),
                ),
              ),
              const Text(".",
                style: TextStyle(
                  fontSize: 16,
                ),
              )
            ]
            )

        ],
      ),
    );
  }
}
