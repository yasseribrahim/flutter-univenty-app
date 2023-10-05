import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:univenty/screens/home_screen.dart';
import 'package:univenty/auth.dart';
import 'package:univenty/toast.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  Map userData = {};
  final Auth auth = new Auth();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final List<String> titles = <String>['Mr', 'Doctor', 'Professor'];
  String dropdownValue = "Mr";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                child: Container(
                  width: 300,
                  height: 150,
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(2.0),
              child: const Text(
                "Registration",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF7343A5),
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: 'Enter Full Name')
                                  ]),
                                  decoration: const InputDecoration(
                                      hintText: 'Enter Full Name',
                                      labelText: 'Full Name',
                                      prefixIcon: Icon(
                                        Icons.account_box,
                                        //color: Colors.green,
                                      ),
                                      errorStyle: TextStyle(fontSize: 18.0),
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(9.0)))))),
                          Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(
                                controller: controllerEmail,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: 'Enter email address'),
                                    EmailValidator(
                                        errorText:
                                            'Please correct email filled'),
                                  ]),
                                  decoration: const InputDecoration(
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
                                              Radius.circular(9.0)))))),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: TextFormField(
                              controller: controllerPassword,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'Please enter Password'),
                                MinLengthValidator(8,
                                    errorText:
                                        'Password must be atlist 8 digit'),
                                PatternValidator(r'(?=.*?[#!@$%^&*-])',
                                    errorText:
                                        'Password must be atlist one special character')
                              ]),
                              decoration: const InputDecoration(
                                hintText: 'Password',
                                labelText: 'Password',
                                prefixIcon: Icon(
                                  Icons.key,
                                  color: Colors.green,
                                ),
                                errorStyle: TextStyle(fontSize: 18.0),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(9.0))),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: FormField<String>(
                              builder: (FormFieldState<String> state) {
                                return InputDecorator(
                                  decoration: InputDecoration(
                                      labelStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                                      errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                                      hintText: 'Please select title',
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                  isEmpty: dropdownValue == '',
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: dropdownValue,
                                      isDense: true,
                                      onChanged: (String? value) {
                                        // This is called when the user selects an item.
                                        setState(() {
                                          dropdownValue = value!;
                                        });
                                      },
                                      items: titles.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                );
                              },
                            )
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Container(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    textStyle: const TextStyle(fontSize: 20),
                                    backgroundColor: Color(0xFF0389C3)),
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    var toaster = new Toaster();
                                    auth.handleSignUp(controllerEmail.text, controllerPassword.text)
                                      .then((User user) {
                                        toaster.show("Successfully Login");
                                          Navigator.push(context, new MaterialPageRoute(builder: (context) => new HomeScreen()));
                                    }).catchError((e) => toaster.show(e.toString()));
                                  }
                                },
                                child: Text(
                                  'Registration',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 22),
                                ),
                              ),
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                            ),
                          )
                        ]),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
