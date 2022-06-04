import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_tpm/model/data_model.dart';
import 'package:project_tpm/helper/hive_database.dart';

import 'landingpage.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final HiveDatabase _hive = HiveDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meybelline"),
      ),
      body: Container(
        color: Color(0xFFB0BEC5),
        padding: EdgeInsets.all(18),
        child: Column(
          children: [
            SizedBox(height: 150),
            Text('Sign Up',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50),
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: 'Username',
                prefixIcon: const Icon(Icons.account_circle_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              validator: (String? value) {
                if (value!.trim().isEmpty) {
                  return 'Username is required';
                }
              },
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              validator: (String? value) {
                if (value!.trim().isEmpty) {
                  return 'Password is required';
                }
              },
            ),
            SizedBox(height: 30),
            _buildRegisterButton(),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Have an account?"),
                TextButton( onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                  );
                },
                  child: const Text(' Log In!'),
                ),
              ],
            ),
          ],
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

  Widget _buildRegisterButton() {
    return _commonSubmitButton(
      labelButton: "Sign Up",
      submitCallback: (value) {
        if (_usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
          _hive.addData(
              DataModel(
                  username: _usernameController.text,
                  password: _passwordController.text
              )
          );
          _usernameController.clear();
          _passwordController.clear();
          setState(() {});

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
              const HomePage(),
            ),
          );
        }
      },
    );
  }
}
