import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ticketbooking/screens/bottom_bar.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';

import 'package:http/http.dart' as http;

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? _email = "";
  String? _pass = "";
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalFormKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) => _email = email,
            decoration: const InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              onSaved: (pass) => _pass = pass,
              decoration: const InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: () async {
                print(_email);
                print(_pass);
                if (validateAndSave()) {
                  try {
                    final response = await http.post(
                        headers: {
                          HttpHeaders.contentTypeHeader: 'application/json',
                        },
                        Uri.parse("http://10.0.2.2:4000/api/users/login"),
                        body: jsonEncode({"email": _email, "password": _pass}));
                    var data = jsonDecode(response.body);
                    if (data['token'].toString().isNotEmpty &&
                        data['email'] == _email) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Login Sucessful')));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const BottomBar();
                          },
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(data['msg']),
                      ));
                    }
                    print(response.body);
                  } catch (error) {
                    print(error);
                  }
                }
              },
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    form!.save();
    if (form.validate()) {
      if (_email!.isEmpty || _pass!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Email and password should not be empty")));
        return false;
      }
      return true;
    }
    return false;
  }
}
