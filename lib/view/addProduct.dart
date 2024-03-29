import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:practise/controller/productProvider.dart';
import 'package:practise/utilities/routes/routesName.dart';
import 'package:practise/utilities/utilities.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _image;
  Future _pickImageFromGallery() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        Utils.flushBarErrorMessage("Pick image.", context);
      }
    });
  }

  int _selectedValue = 1;
  bool latestProductOptionSelected = false;
  bool summerCollectionOptionSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 59, 173, 62),
        title: const Text('Add Product'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RadioListTile(
              title: Text('Add to summer collection'),
              value: 1,
              groupValue: _selectedValue,
              onChanged: (value) {
                setState(() {
                  _selectedValue = value!;
                  summerCollectionOptionSelected = true;
                });
              },
            ),
            RadioListTile(
              title: Text('Add to Latest product collection'),
              value: 2,
              groupValue: _selectedValue,
              onChanged: (value) {
                setState(() {
                  _selectedValue = value!;
                  latestProductOptionSelected = true;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _titleController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    hintText: 'Title',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _descriptionController,
                keyboardType: TextInputType.text,
                minLines: 3,
                maxLines: 6,
                decoration: InputDecoration(
                    hintText: 'Description',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Center(
              child: _image != null
                  ? SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.file(_image!.absolute),
                    )
                  : const SizedBox(
                      height: null,
                    ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: _pickImageFromGallery,
                child: const Text('Select Image'),
              ),
            ),
            Consumer<ProductProvider>(
              builder: (context, productProvider, child) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      if (_titleController.text.isEmpty) {
                        Utils.flushBarErrorMessage(
                            'Pleaase enter title.', context);
                      } else if (_descriptionController.text.isEmpty) {
                        Utils.flushBarErrorMessage(
                            'Please enter description.', context);
                      } else if (_image!.path.isEmpty) {
                        Utils.flushBarErrorMessage(
                            'Please select image.', context);
                      } else {
                        if (latestProductOptionSelected) {
                          productProvider
                              .addProduct(
                            _titleController.text,
                            _descriptionController.text,
                            _image!,
                          )
                              .then((value) {
                            Utils.toastMessage(
                                '${_titleController.text} added successfully to latest product collection');
                            Navigator.pushReplacementNamed(
                                context, RoutesName.home);
                          }).onError((error, stackTrace) {
                            Utils.flushBarErrorMessage(
                                error.toString(), context);
                          });
                        } else if (summerCollectionOptionSelected) {
                          productProvider
                              .addToSummerCollection(
                            _titleController.text,
                            _descriptionController.text,
                            _image!,
                          )
                              .then((value) {
                            Utils.toastMessage(
                                '${_titleController.text} added successfully to summer collection ');
                            Navigator.pushReplacementNamed(
                                context, RoutesName.home);
                          }).onError((error, stackTrace) {
                            Utils.flushBarErrorMessage(
                                error.toString(), context);
                          });
                        }
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: productProvider.loading == false
                              ? const Text(
                                  'Submit',
                                  style: TextStyle(fontSize: 20),
                                )
                              : const CircularProgressIndicator()),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
