import 'package:as_traders_customer_entry/hooks/custom_sales_widget.dart';
import 'package:as_traders_customer_entry/view_model/view_sales_list/vm_sales_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_model/view_update/vm_update.dart';
import '../update/update_screen.dart';

class SalesList extends StatefulWidget {
  const SalesList({Key? key}) : super(key: key);

  @override
  State<SalesList> createState() => _SalesListState();
}

late AnimationController _animationController;

class _SalesListState extends State<SalesList> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );
    _animationController.repeat();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<VmSalesList>(context, listen: false);
      provider.onGettingList();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<VmSalesList>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Customer List"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: provider.customerList != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: provider.customerList!.length,
                        itemBuilder: (context, index) => Card(
                              elevation: 5,
                              color: Theme.of(context).cardColor,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(provider
                                            .customerList![index].customerId),
                                        const SizedBox(width: 10.0),
                                        Image.network(
                                            provider.customerList![index]
                                                    .customerImageUrl ??
                                                "http://joyhoney.in/uploads/user.png",
                                            height: 100,
                                            width: 100),
                                      ],
                                    ),
                                    const SizedBox(height: 10.0),
                                    CustomSalesWidget(
                                        key1: "First name",
                                        value: provider.customerList![index]
                                            .customerFirstName),
                                    const SizedBox(height: 10.0),
                                    CustomSalesWidget(
                                        key1: "Last name",
                                        value: provider.customerList![index]
                                            .customerLastName),
                                    const SizedBox(height: 10.0),
                                    CustomSalesWidget(
                                        key1: "Phone number",
                                        value: provider.customerList![index]
                                                .customerPhoneNumber.isEmpty
                                            ? "Not Specified"
                                            : provider.customerList![index]
                                                .customerPhoneNumber),
                                    const SizedBox(height: 10.0),
                                    CustomSalesWidget(
                                        key1: "E-mail",
                                        value: provider.customerList![index]
                                                .customerEmail!.isEmpty
                                            ? "Not specified"
                                            : provider.customerList![index]
                                                .customerEmail!),
                                    const SizedBox(height: 10.0),
                                    CustomSalesWidget(
                                        key1: "Aadhar Number",
                                        value: provider.customerList![index]
                                                .customerAdharNo!.isEmpty
                                            ? "Not specified"
                                            : provider.customerList![index]
                                                .customerAdharNo!),
                                    const SizedBox(height: 10.0),
                                    CustomSalesWidget(
                                        key1: "Customer District",
                                        value: provider.customerList![index]
                                                .districtName ??
                                            "Not Specified"),
                                    const SizedBox(height: 10.0),
                                    CustomSalesWidget(
                                        key1: "Customer Area",
                                        value: provider.customerList![index]
                                                .areaName ??
                                            "Not specified"),
                                    const SizedBox(height: 10.0),
                                    CustomSalesWidget(
                                        key1: "Address",
                                        value: provider.customerList![index]
                                                .customerAddress ??
                                            "Not specified"),
                                    const SizedBox(height: 10.0),
                                    CustomSalesWidget(
                                        key1: "Remarks",
                                        value: provider.customerList![index]
                                                .customerRemark ??
                                            "Not specified"),
                                    const SizedBox(height: 10.0),
                                    CustomSalesWidget(
                                        key1: "Status",
                                        value: provider
                                            .customerList![index].customerCity),
                                    const SizedBox(height: 20.0),
                                    Center(
                                      child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChangeNotifierProvider(
                                                            create: (BuildContext
                                                                    context) =>
                                                                VmUpdate(),
                                                            child: UpdateScreen(
                                                                customerList: provider
                                                                        .customerList![
                                                                    index]))));
                                          },
                                          child: const Text("Modify")),
                                    )
                                  ],
                                ),
                              ),
                            )),
                  )
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
      ),
    );
  }
}
