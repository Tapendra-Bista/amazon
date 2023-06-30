import 'dart:convert';
import 'dart:io';
import 'package:amazon/common/flash.dart';
import 'package:amazon/constans/cons.dart';
import 'package:amazon/url/url.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flashtoast/flash_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../common/appbar.dart';
import '../../common/expandtextfield.dart';
import '../../common/materialb.dart';
import '../../common/textfield.dart';
import "package:http/http.dart" as http;
import 'package:cloudinary_public/cloudinary_public.dart';

final cloudinary = CloudinaryPublic("tbistaxmok1", "s580a5rg", cache: true);
// CLOUDINARY_URL=cloudinary://447427762892173:Ycy1WVPtxfi5pY7czf-hsIE6pFg@tbistaxmok1
class Createpage extends StatefulWidget {
  const Createpage({super.key});
  @override
  State<Createpage> createState() => _CreatepageState();
}

class _CreatepageState extends State<Createpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(

          // to maintained appbar hieght
          preferredSize: const Size.fromHeight(85),
          child: Customappbar(
            forappbar: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10)
                          .copyWith(top: 50),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(
                              CupertinoIcons.back,
                              size: 26,
                            )),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 45, left: 100),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Add Product",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              imageslist.isNotEmpty
                  ? CarouselSlider(
                      items: imageslist
                          .map((e) => Builder(builder: (context) {
                                return Image.file(
                                  e,
                                  fit: BoxFit.cover,
                                  height: 200,
                                );
                              }))
                          .toList(),
                      options: CarouselOptions(
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 10),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 500),
                          viewportFraction: 1,
                          height: 200))
                  : DottedBorder(
                      color: Colors.black.withOpacity(0.7),
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(13),
                      dashPattern: const [10, 3],
                      child: GestureDetector(
                        onTap: () {
                          pickImage();
                        },
                        child: Container(
                          height: 165,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Globalvariable.backgroundcolor,
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.folder_open_outlined,
                                size: 60,
                                color: Colors.black.withOpacity(0.7),
                              ),
                              Text(
                                "Select product images",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.grey.shade500),
                              )
                            ],
                          ),
                        ),
                      )),
              const SizedBox(
                height: 15,
              ),
              Customtextfield(
                  keyboardtype: TextInputType.multiline,
                  controller: _productname,
                  myhint: "Product Name",
                  boolvalue: false),
              const SizedBox(
                height: 15,
              ),
              Customexpandtext(
                controller: _productdiscription,
                hinttext: "Discription",
              ),
              const SizedBox(
                height: 15,
              ),
              Customtextfield(
                  keyboardtype: TextInputType.number,
                  controller: _productprice,
                  myhint: "Price",
                  boolvalue: false),
              const SizedBox(
                height: 15,
              ),
              Customtextfield(
                  keyboardtype: TextInputType.number,
                  controller: _productquantity,
                  myhint: "Quantity",
                  boolvalue: false),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.black.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(7)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    iconEnabledColor: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                    menuMaxHeight: 285,
                    dropdownColor: Globalvariable.backgroundcolor,
                    value: curentcatergory,
                    items: category
                        .map<DropdownMenuItem<String>>((String myvalue) =>
                            DropdownMenuItem<String>(
                              value: myvalue,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 11),
                                child: Center(
                                  child: Text(
                                    myvalue,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black.withOpacity(0.6)),
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (mydropstring) {
                      setState(() {
                        curentcatergory = mydropstring ?? "";
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Custommaterialbutton(
                  width: double.infinity,
                  function: () {
                    setState(() {
                      postsell(context);
                    });
                  },
                  name: 'Sell',
                  color: Globalvariable.secondarycolor,
                  borderclr: Colors.black.withOpacity(0.3),
                  radius: 7)
            ],
          ),
        ),
      ),
    );
  }

  final TextEditingController _productdiscription = TextEditingController();
  final TextEditingController _productprice = TextEditingController();
  final TextEditingController _productquantity = TextEditingController();
  final TextEditingController _productname = TextEditingController();
  String curentcatergory = "Catergory";
  List<String> category = [
    "Catergory",
    'Mobiles',
    "Electronics",
    'Fashion',
    'Home',
    'Mini Tv',
    'Deals',
    'Beauty',
    'Books',
    'Appliances',
    'Grocery',
    'Essentials',
  ];

  Future<List<File>> pickImage() async {
    try {
      final photo = await FilePicker.platform
          .pickFiles(allowMultiple: true, type: FileType.image);

      if (photo != null && photo.files.isNotEmpty) {
        for (int i = 0; i < photo.files.length; i++) {
          imageslist.add(File(photo.files[i].path ?? ""));
          CloudinaryResponse response =
              await cloudinary.uploadFile(      
                CloudinaryFile.fromFile(
            imageslist[i].path,
            resourceType: CloudinaryResourceType.Image,
            folder:"flutter amazon/images"
          ),
          uploadPreset: "s580a5rg",
          );
          imageurl.add(response.secureUrl);
        }
      }
    } catch (error) {
      debugPrint(error.toString());
    }
    return imageslist;
  }

  List<String> imageurl = [];
  List<File> imageslist = [];

//  post data for sell
  Future postsell(context) async {
    if (imageslist.isNotEmpty &&
        _productdiscription.text.isNotEmpty &&
        _productname.text.isNotEmpty &&
        _productprice.text.isNotEmpty &&
        _productquantity.text.isNotEmpty &&
        curentcatergory.isNotEmpty) {
      var client = http.Client();
      var sellboby = {
        "image":imageurl,
        "productname": _productname.text,
        "discription": _productdiscription.text,
        "price": _productprice.text,
        "quantity": _productquantity.text,
        "catergory": curentcatergory,
      };
      try {
        var response = await client.post(
          Uri.parse(postsellurl),
          body: jsonEncode(sellboby),
          headers: {"Content-Type": "application/json"},
        );
        var jsresponse = jsonDecode(response.body.toString());
        if (response.statusCode == 200) {
          imageslist.clear();
          _productdiscription.clear();
          _productname.clear();
          _productquantity.clear();
          category.clear();
          _productprice.clear();

          flashfunction(context, "New sell", jsresponse['message'].toString(),
              FlashType.success);
          Navigator.pop(context);
        } else {
          flashfunction(context, "Invalid", jsresponse['message'].toString(),
              FlashType.error);
        }
      } catch (error) {
        debugPrint(error.toString());
      }
    }
  }
}
