import 'package:as_traders_customer_entry/view_model/vm_signin/vm_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

late AnimationController _animationController;

class _SignInScreenState extends State<SignInScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<VmSignIn>(context, listen: true);
    return Scaffold(
      body: provider.isProgress == false
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: "1",
                      child: SizedBox(
                        height: 100.0,
                        width: 100.0,
                        child: Image.asset("assets/images/asTraders.png"),
                      ),
                    ),
                    const Text(
                      "A S Traders",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                const Text("Login",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0)),
                const SizedBox(height: 10.0),
                const Text("Customer registration",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0)),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Theme.of(context).cardColor,
                    elevation: 2.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: provider.phone,
                              cursorColor: Colors.red,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal),
                              decoration: InputDecoration(
                                label: const Text("Phone Number"),
                                labelStyle: const TextStyle(color: Colors.grey),
                                focusColor: Colors.red,
                                prefixIcon: const Icon(
                                  Icons.phone_outlined,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: provider.password,
                              cursorColor: Colors.red,
                              obscureText: true,
                              textInputAction: TextInputAction.done,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal),
                              decoration: InputDecoration(
                                label: const Text("Password"),
                                labelStyle: const TextStyle(color: Colors.grey),
                                prefixIcon: const Icon(
                                  Icons.password_outlined,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (provider.phone.text.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Please Enter mobile number"),
                          ));
                        } else if (provider.password.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Please Password")));
                        } else {
                          provider.onGetResponse(context: context);
                        }
                      },
                      child: const Text(
                        "Sign In",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
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
