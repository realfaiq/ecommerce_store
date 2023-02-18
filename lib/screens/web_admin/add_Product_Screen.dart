import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_store/utils/styles.dart';
import 'package:ecommerce_store/widgets/ecoButton.dart';
import 'package:ecommerce_store/widgets/textField.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = 'addproduct';

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _productDetailsController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _serialCodeController = TextEditingController();
  TextEditingController _isOnSaleController = TextEditingController();

  bool isOnSale = false;
  bool isPopular = false;
  bool isFavorite = false;

  List categories = [
    "GROCERIES",
    "COSMETICS",
    "ELECTRONICS",
    "PHARMACY",
    "GARMENTS"
  ];

  String? selectedValue;
  final imagePicker = ImagePicker();
  List<XFile> images = [];
  List<String> imageURLS = [];
  bool isSaving = false;
  bool isUploading = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Column(
              children: [
                const Text(
                  'Add Product',
                  style: EcommerceStore.boldStyle,
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonFormField(
                      hint: const Text('Choose Category'),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(20),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return "Category must be Selected";
                        } else {
                          return null;
                        }
                      },
                      value: selectedValue,
                      items: categories
                          .map((e) => DropdownMenuItem<String>(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value;
                        });
                      }),
                ),
                EcoTextField(
                  controller: _productNameController,
                  hintText: 'Enter Product Name',
                ),
                EcoTextField(
                  controller: _productDetailsController,
                  hintText: 'Enter Product Details',
                  maxLines: 5,
                ),
                EcoTextField(
                  controller: _priceController,
                  hintText: 'Enter Price',
                ),
                EcoTextField(
                  controller: _serialCodeController,
                  hintText: 'Enter Serail Code',
                ),
                EcoButton(
                  title: "PICK IMAGES",
                  onPress: () {
                    pickImage();
                  },
                  isLogIn: true,
                ),
                // EcoButton(
                //   title: "UPLOAD IMAGES",
                //   isLoading: isUploading,
                //   onPress: () {
                //     uploadImages();
                //   },
                //   isLogIn: true,
                // ),
                Container(
                  height: 45.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20.sp),
                  ),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                              ),
                              child: Image.network(
                                File(images[index].path).path,
                                height: 200,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    images.removeAt(index);
                                  });
                                },
                                icon: const Icon(Icons.cancel_outlined))
                          ],
                        ),
                      );
                    },
                    itemCount: images.length,
                  ),
                ),
                EcoButton(
                  title: 'SAVE',
                  isLogIn: true,
                  onPress: () {
                    save();
                  },
                  isLoading: isSaving,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  save() async {
    setState(() {
      isSaving = true;
    });
    await uploadImages();
    await FirebaseFirestore.instance
        .collection('products')
        .add({'images': imageURLS}).whenComplete(() {
      setState(() {
        isSaving = false;
        images.clear();
        imageURLS.clear();
      });
    });
  }

  pickImage() async {
    final List<XFile>? pickImage = await imagePicker.pickMultiImage();
    if (pickImage != null) {
      setState(() {
        images.addAll(pickImage);
      });
    } else {
      print('No Images selected');
    }
  }

  Future postImages(XFile? imageFile) async {
    setState(() {
      isUploading = true;
    });
    String? urls;
    Reference ref =
        FirebaseStorage.instance.ref().child('images').child(imageFile!.name);
    if (kIsWeb) {
      await ref.putData(await imageFile.readAsBytes(),
          SettableMetadata(contentType: "image/jpeg"));
      urls = await ref.getDownloadURL();
      setState(() {
        isUploading = false;
      });
      return urls;
    }
  }

  uploadImages() async {
    for (var image in images) {
      await postImages(image).then((downLoadUrl) => imageURLS.add(downLoadUrl));
    }
  }
}
