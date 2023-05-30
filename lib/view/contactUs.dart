import 'package:flutter/material.dart';
import 'package:practise/controller/contactUsProvider.dart';
import 'package:practise/utilities/routes/routesName.dart';
import 'package:practise/utilities/utilities.dart';
import 'package:provider/provider.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  late ContactUsProvider contactUsProvider;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _nameNode = FocusNode();
  final FocusNode _emailNdode = FocusNode();
  final FocusNode _descriptionNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    contactUsProvider = Provider.of<ContactUsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        excludeHeaderSemantics: false,
        bottomOpacity: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://images.unsplash.com/photo-1614849286521-4c58b2f0ff15?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80'),
                fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 20, left: 10),
                child: Text(
                  'Contact Us',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 6),
                child: TextFormField(
                  focusNode: _nameNode,
                  controller: _nameController,
                  onFieldSubmitted: (value) {
                    Utils.fieldFocusChange(context, _nameNode, _emailNdode);
                  },
                  decoration: InputDecoration(
                      labelText: 'Name',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.black))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your Name";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 8, bottom: 6),
                child: TextFormField(
                  focusNode: _emailNdode,
                  controller: _emailController,
                  onFieldSubmitted: (value) {
                    Utils.fieldFocusChange(
                        context, _emailNdode, _descriptionNode);
                  },
                  decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.black))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your email";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 8, bottom: 16),
                child: TextFormField(
                  focusNode: _descriptionNode,
                  controller: _descriptionController,
                  maxLines: 6,
                  minLines: 3,
                  decoration: InputDecoration(
                      labelText: 'Feedback',
                      prefixIcon: const Icon(Icons.message),
                      hoverColor: Colors.transparent,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.black))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter Feedback";
                    }
                  },
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    contactUsProvider
                        .addData(_nameController.text, _emailController.text,
                            _descriptionController.text)
                        .then((value) {
                      Utils.toastMessage('Send Feedback.');
                      Navigator.pushReplacementNamed(context, RoutesName.home);
                    }).onError((error, stackTrace) {
                      Utils.flushBarErrorMessage(error.toString(), context);
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green,
                    ),
                    child: Center(
                        child: contactUsProvider.loading == false
                            ? const Text(
                                'Send',
                                style: TextStyle(fontSize: 20),
                              )
                            : const CircularProgressIndicator()),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
