import 'package:flutter/material.dart';
import 'package:app/Tools/auth.dart';
import 'package:app/models/user.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({Key? key, required this.userObj}) : super(key: key);
  final User userObj;

  @override
  _FormLoginWidgetState createState() => _FormLoginWidgetState();
}

// This is the private State class that goes with MyStatefulWidget.
class _FormLoginWidgetState extends State<FormLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailInputController = TextEditingController();
  final pwdInputController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailInputController.dispose();
    pwdInputController.dispose();
    super.dispose();
  }

  void updateUserObj(String tok) {
    widget.userObj.email = emailInputController.text;
    widget.userObj.token = tok;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: emailInputController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
                    hintText: "Email adress",
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.white,
                    )),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: pwdInputController,
                obscureText: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
                    hintText: "Password",
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.white,
                    )),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    if (_formKey.currentState!.validate()) {
                      var x = await userConnection(emailInputController.text, pwdInputController.text);
                      setState(() => {updateUserObj(x)});
                      // for debug purposes
                      // print("@: ${widget.userObj.email} Jwt: ${widget.userObj.token}");
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ));
  }
}
