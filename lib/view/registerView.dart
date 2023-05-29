import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practise/utilities/routes/routesName.dart';
import 'package:practise/utilities/utilities.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void register() {
    _auth
        .createUserWithEmailAndPassword(
            email: _emailController.text.toString(),
            password: _passwordController.text.toString())
        .then((value) {
      Navigator.pushReplacementNamed(context, RoutesName.home);
    }).onError((error, stackTrace) {
      final snackBar = SnackBar(
        content: Text(error.toString()),
      );

      // Show the SnackBar
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
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
                    if (_emailController.text.isEmpty) {
                      Utils.flushBarErrorMessage(
                          'Please enter email.', context);
                    } else if (_passwordController.text.isEmpty) {
                      Utils.flushBarErrorMessage(
                          'Please enter password.', context);
                    } else if (_passwordController.text.length < 6) {
                      Utils.flushBarErrorMessage(
                          'Password must be of 6 letter.', context);
                    } else {
                      register();
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green),
                    child: const Center(child: Text('Register')),
                  ),
                ),
              )),
          Center(
            child: InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, RoutesName.login);
                },
                child: const Text('Already have account.')),
          )
        ],
      )),
    );
  }
}
