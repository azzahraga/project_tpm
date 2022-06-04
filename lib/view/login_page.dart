import 'package:flutter/material.dart';
import 'package:project_tpm/helper/hive_database.dart';
import 'package:project_tpm/view/register_page.dart';

import '../navbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void validateAndSave() {
    final FormState? form = _formKey.currentState;
    if(form != null){
      if (form.validate()) {
        print('Form is valid');
      } else {
        print('Form is invalid');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFB0BEC5),
        padding: EdgeInsets.all(18),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 150),
              Text('Log in',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50),
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: "Enter your username",
                  prefixIcon: const Icon(Icons.account_circle_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                validator: (value) => value!.isEmpty ? 'Username cannot be blank':null,
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  prefixIcon: const Icon(Icons.lock_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                obscureText: true,
                validator: (value) => value!.isEmpty ? 'Password cannot be blank' : null,
              ),
              SizedBox(height: 30),
              _buildLoginButton(),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton( onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    },
                    child: const Text(' Sign up!'),
                  ),
                ],
              ),
              // _buildRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }


  Widget _commonSubmitButton({
    required String labelButton,
    required Function(String) submitCallback,
  }){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        child: Text(labelButton),
        onPressed: () {
          submitCallback(labelButton);
        },
      ),
    );
  }

  Widget _buildLoginButton() {
    return _commonSubmitButton(
      labelButton: "Log In",
      submitCallback: (value) {
        validateAndSave();
        String currentUsername = _usernameController.value.text;
        String currentPassword = _passwordController.value.text;

        _processLogin(currentUsername, currentPassword);
      },
    );
  }

  void _processLogin(String username, String password) async {
    final HiveDatabase _hive = HiveDatabase();
    bool found = false;

    found = _hive.checkLogin(username, password);

    if(!found) print("Login Failed");
    else{
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Nav(),
        ),
      );
    }
  }

  Widget _buildRegisterButton() {
    return _commonSubmitButton(
      labelButton: "Register",
      submitCallback: (value) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RegisterPage(),
          ),
        );
      },
    );
  }
}





































