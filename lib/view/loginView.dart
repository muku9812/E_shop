import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practise/utilities/routes/routesName.dart';
import 'package:practise/utilities/utilities.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ignore: non_constant_identifier_names
  void Login() {
    if (_emailController.text.isEmpty) {
      Utils.flushBarErrorMessage('Please enter email.', context);
    } else if (_passwordController.text.isEmpty) {
      Utils.flushBarErrorMessage("Please enter password.", context);
    } else {
      _auth
          .signInWithEmailAndPassword(
              email: _emailController.text.toString(),
              password: _passwordController.text.toString())
          .then((value) {
        Utils.toastMessage('login successfull.');
        Navigator.pushReplacementNamed(context, RoutesName.home);
      }).onError((error, stackTrace) {
        final snackBar = SnackBar(
          content: Text(error.toString()),
        );

        // Show the SnackBar
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white38),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    label: const Text('Email'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  label: const Text('Password'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black))),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: InkWell(
                  onTap: () {
                    Login();
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green),
                    child: const Center(child: Text('Login')),
                  ),
                ),
              )),
          Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, RoutesName.register);
                  },
                  child: Container(
                    height: 50,
                    width: 190,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                        border: Border.all(color: Colors.black)),
                    child: const Center(child: Text('Register now')),
                  ),
                ),
              )),
        ],
      )),
    );
  }
}
