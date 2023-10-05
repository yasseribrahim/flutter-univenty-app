import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:univenty/screens/home_screen.dart';
import 'package:univenty/screens/login_screen.dart';
import 'package:univenty/screens/registration_screen.dart';
import 'package:univenty/auth.dart';
import 'package:univenty/toast.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  Map userData = {};
  final _formkey = GlobalKey<FormState>();
  final authHandler = new Auth();
  final controllerEmail = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controllerEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Center(
                child: Container(
                  width: 300,
                  height: 300,
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                              controller: controllerEmail,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: 'Enter email address'),
                                    EmailValidator(
                                        errorText:
                                            'Please correct email filled'),
                                  ]),
                                  decoration: InputDecoration(
                                      hintText: 'Email',
                                      labelText: 'Email',
                                      prefixIcon: Icon(
                                        Icons.email,
                                        //color: Colors.green,
                                      ),
                                      errorStyle: TextStyle(fontSize: 18.0),
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(9.0)))))
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    textStyle: const TextStyle(fontSize: 20),
                                    backgroundColor: Colors.green),
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    var toaster = new Toaster();
                                     authHandler.handleResetPassword(controllerEmail.text)
                                      .then((void v) {
                                        toaster.show("Successfully Rest Password, Please Login Now");
                                          Navigator.push(context, new MaterialPageRoute(builder: (context) => new LoginScreen()));
                                    }).catchError((e) => toaster.show(e.toString()));
                                  }
                                },
                                child: const Text(
                                  'Send Link',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 22),
                                ),
                              ),
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                            ),
                          ),
                        ]
                      ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
