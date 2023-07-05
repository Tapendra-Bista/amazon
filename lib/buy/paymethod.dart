import 'dart:io';
import 'package:amazon/buy/configuration.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

class Gpay extends StatefulWidget {
  const Gpay({super.key});

  @override
  State<Gpay> createState() => _GpayState();
}

class _GpayState extends State<Gpay> {
  final _paymentItems = [
    const PaymentItem(
        amount: "99.9", label: "Total", status: PaymentItemStatus.final_price)
  ];
  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult);
  }

  void onApplePayResult(paymentResult) {
    debugPrint(paymentResult);
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? GooglePayButton(      
            childOnError: const Text("Error"),
            onError: (error) => debugPrint("error occur at $error"),
            height: 50,
            width: 200,
            loadingIndicator: const Center(
              child: CircularProgressIndicator(),
            ),
          
            type: GooglePayButtonType.pay,
            paymentConfiguration:
                PaymentConfiguration.fromJsonString(defaultGooglePay),
            onPaymentResult: onGooglePayResult,
            paymentItems: _paymentItems)
        : ApplePayButton(
            height: 50,
            width: 200,
            loadingIndicator: const Center(
              child: CircularProgressIndicator(),
            ),
            style: ApplePayButtonStyle.black,
            type: ApplePayButtonType.buy,
            paymentConfiguration:
                PaymentConfiguration.fromJsonString(defaultApplePay),
            onPaymentResult: onApplePayResult,
            paymentItems: _paymentItems,
            
                        childOnError: const Text("Error"),
            onError: (error) => debugPrint("error occur at $error"),
            
            );
  }
}
