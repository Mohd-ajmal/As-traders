import 'package:as_traders_customer_entry/model/model_sales_list.dart';
import 'package:as_traders_customer_entry/view_model/view_update/vm_update.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../hooks/text_field.dart';

class UpdateScreen extends StatefulWidget {
  UpdateScreen({Key? key, required this.customerList}) : super(key: key);
  CustomerList customerList;

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<VmUpdate>(context, listen: false);
      provider.updateFN.text = widget.customerList.customerFirstName;
      provider.updateLN.text = widget.customerList.customerLastName;
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<VmUpdate>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Customer"),
        backgroundColor: Colors.red,
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10.0),
            CustomTextField(
              name: "Customer fist name",
              icon: const Icon(Icons.person_outline),
              obsecureText: false,
              type: TextInputType.text,
              customController: provider.updateFN,
            ),
            const SizedBox(height: 20.0),
            CustomTextField(
              name: "Customer last name",
              icon: const Icon(
                Icons.person_outline,
              ),
              obsecureText: false,
              type: TextInputType.text,
              customController: provider.updateLN,
            ),
            const SizedBox(height: 20.0),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => provider.onUpdateResponse(
                      context: context,
                      id: widget.customerList.customerId,
                      firstName: provider.updateFN.text,
                      lastName: provider.updateLN.text,
                      phoneNumber: widget.customerList.customerPhoneNumber,
                      mail: widget.customerList.customerEmail,
                      aadharNumber: widget.customerList.customerAdharNo,
                      customerDistrict: widget.customerList.customerDistrict,
                      customerArea: widget.customerList.customerCity,
                      customerAddress: widget.customerList.customerAddress,
                      reqBy: widget.customerList.regBy),
                  child: const Text("Register")),
            )
          ],
        ),
      ),
    );
  }
}
