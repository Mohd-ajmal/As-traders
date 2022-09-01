import 'package:as_traders_customer_entry/routes/routes.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        cursorColor: Colors.red,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(fontWeight: FontWeight.normal),
                        decoration: InputDecoration(
                          label: const Text("Phone Number"),
                          labelStyle: const TextStyle(color: Colors.grey),
                          focusColor: Colors.red,
                          prefixIcon: const Icon(
                            Icons.phone_outlined,
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        cursorColor: Colors.red,
                        textInputAction: TextInputAction.done,
                        style: const TextStyle(fontWeight: FontWeight.normal),
                        decoration: InputDecoration(
                          label: const Text("Password"),
                          labelStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(
                            Icons.password_outlined,
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 2),
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
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, RouteManager.homeRoute, (route) => false),
                child: const Text(
                  "Sign In",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
