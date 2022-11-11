import 'dart:developer';

import 'package:as_traders_customer_entry/hooks/text_field.dart';
import 'package:as_traders_customer_entry/view_model/view_home_screen/view_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

late AnimationController _animationController;

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );
    _animationController.repeat();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<ViewHomeScreen>(context, listen: false);
      provider.onGetDistrictResponse();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ViewHomeScreen>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer entry"),
        backgroundColor: Colors.red,
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.clear_all_outlined)),
        ],
      ),
      body: provider.isProgress == false
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        provider.image == null
                            ? Align(
                                alignment: AlignmentDirectional.center,
                                child: Container(
                                    height: 150.0,
                                    width: 150.0,
                                    alignment: Alignment.topLeft,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(80.0),
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                    ),
                                    child: Center(
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.camera_alt,
                                        ),
                                        color: Colors.grey,
                                        onPressed: () =>
                                            provider.imageFromCamera(),
                                      ),
                                    )),
                              )
                            : Align(
                                alignment: AlignmentDirectional.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.file(provider.image!,
                                      height: 150, width: 150),
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    CustomTextField(
                      name: "Customer fist name",
                      icon: const Icon(Icons.person_outline),
                      obsecureText: false,
                      type: TextInputType.text,
                      customController: provider.firstNameController,
                    ),
                    const SizedBox(height: 20.0),
                    CustomTextField(
                      name: "Customer last name",
                      icon: const Icon(
                        Icons.person_outline,
                      ),
                      obsecureText: false,
                      type: TextInputType.text,
                      customController: provider.lastNameController,
                    ),
                    const SizedBox(height: 20.0),
                    CustomTextField(
                      name: "Customer E-mail (Optional)",
                      icon: const Icon(Icons.email_outlined),
                      obsecureText: false,
                      type: TextInputType.text,
                      customController: provider.emailController,
                    ),
                    const SizedBox(height: 20.0),
                    CustomTextField(
                      name: "Customer aadhar number (Optional)",
                      icon: const Icon(Icons.confirmation_number_outlined),
                      obsecureText: false,
                      type: TextInputType.text,
                      customController: provider.audhaarController,
                    ),
                    const SizedBox(height: 20.0),
                    CustomTextField(
                      name: "Customer mobile number",
                      icon: const Icon(Icons.mobile_friendly),
                      obsecureText: false,
                      type: TextInputType.text,
                      customController: provider.phoneNumberController,
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              hint: const Text("Select District"),
                              value: provider.districtValue,
                              onChanged: (dynamic value) {
                                log(value);
                                provider.districtValue = value;
                                provider.area = null;
                                provider.onGetDistrictByAreaResponse(
                                    district: value, context: context);
                              },
                              items: provider.districtDropDown),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              hint: const Text("Select Area"),
                              value: null,
                              onChanged: (dynamic value) {
                                log(value);
                                provider.areaValue = value;
                              },
                              items: provider.areaDropDown),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      controller: provider.addressController,
                      cursorColor: Colors.red,
                      maxLines: 5,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(fontWeight: FontWeight.normal),
                      decoration: InputDecoration(
                        label: const Text("Customer address"),
                        labelStyle: const TextStyle(color: Colors.grey),
                        focusColor: Colors.red,
                        prefixIcon: const Icon(Icons.streetview_outlined),
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            provider.validation(context);
                          },
                          child: const Text("Register")),
                    )
                  ],
                ),
              ),
            )
          : Center(
              child: Container(
                height: 150.0,
                width: 150.0,
                alignment: Alignment.center,
                child: RotationTransition(
                  child: Image.asset("assets/images/asTraders.png"),
                  turns: _animationController,
                ),
              ),
            ),
    );
  }
}
