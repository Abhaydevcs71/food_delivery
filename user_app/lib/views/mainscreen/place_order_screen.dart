import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:user_app/global/global_instance.dart';
import 'package:user_app/global/global_vars.dart';
import 'package:user_app/paymentSystem/payment_config.dart';
import 'package:user_app/views/mainscreen/homescreen.dart';
import 'package:user_app/views/mainscreen/my_orders_screen.dart';

class PlaceOrderScreen extends StatefulWidget {
  String? addressId;
  double? totalAmount;
  String? sellerUid;

  PlaceOrderScreen({
    super.key,
    this.addressId,
    this.totalAmount,
    this.sellerUid,
  });

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
   String orderId = DateTime.now().microsecondsSinceEpoch.toString();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/pay_now.png"),
          const SizedBox(
            height: 30,
          ),
          paymentResult != ""
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    setState(() {
                      paymentResult = "";
                      orderId = "";
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyOrdersScreen()));
                    commonViewModel.showSnackBar(
                        "Congratulations, Order has been placed successfully.",
                        context);
                  },
                  child: const Text("Order Placed Successfully, OK"),
                )
              : Platform.isIOS
                  ? ApplePayButton(
                      paymentConfiguration:
                          PaymentConfiguration.fromJsonString(defaultApplePay),
                      paymentItems: [
                        PaymentItem(
                          label: 'Total',
                          amount: widget.totalAmount.toString(),
                          status: PaymentItemStatus.final_price,
                        ),
                      ],
                      style: ApplePayButtonStyle.black,
                      width: double.infinity,
                      height: 50,
                      type: ApplePayButtonType.buy,
                      margin: const EdgeInsets.only(top: 15.0),
                      onPaymentResult: (result) async {
                        print("Payment Result = $result");

                        setState(() {
                          paymentResult = result.toString();
                        });

                        //save order details to database
                        await orderViewModel.saveOrderDetailsToDatabase(
                            widget.addressId,
                            widget.totalAmount,
                            widget.sellerUid,
                            orderId,
                            );
                        cartViewModel.clearCartNow(context);
                      },
                      loadingIndicator: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      ),
                    )
                  : GooglePayButton(
                      paymentConfiguration:
                          PaymentConfiguration.fromJsonString(defaultGooglePay),
                      paymentItems: [
                        PaymentItem(
                          label: 'Total',
                          amount: widget.totalAmount.toString(),
                          status: PaymentItemStatus.final_price,
                        ),
                      ],
                      type: GooglePayButtonType.pay,
                      margin: const EdgeInsets.only(top: 15.0),
                      onPaymentResult: (result) async {
                        print("Payment Result = $result");

                        setState(() {
                          paymentResult = result.toString();
                        });

                        //save order details to database
                        await orderViewModel.saveOrderDetailsToDatabase(
                          widget.addressId,
                          widget.totalAmount,
                          widget.sellerUid,
                          orderId,
                        );
                        cartViewModel.clearCartNow(context);
                      },
                      loadingIndicator: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      ),
                    ),
        ],
      ),
    );
  }
}
