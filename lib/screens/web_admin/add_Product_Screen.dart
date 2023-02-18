import 'dart:io';

import 'package:ecommerce_store/utils/styles.dart';
import 'package:ecommerce_store/widgets/ecoButton.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = 'addproduct';

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
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
                DropdownButtonFormField(
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
                EcoButton(
                  title: "PICK IMAGES",
                  onPress: () {
                    pickImage();
                  },
                  isLogIn: true,
                ),
                EcoButton(
                  title: "UPLOAD IMAGES",
                  onPress: () {},
                  isLogIn: true,
                ),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
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
}
