import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

class MyGooglePay extends StatelessWidget {
  final double total;

  const MyGooglePay({
    Key? key,
    required this.total,
  }) : super(key: key);
  void onGooglePayResult(paymentResult) {}

  void onError(Object? error) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
      ),
      body: Center(
        child: GooglePayButton(
          style: GooglePayButtonStyle.white,
          onPaymentResult: onGooglePayResult,
          onError: onError,
          paymentConfigurationAsset: "sample_payment_configuration.json",
          paymentItems: [
            PaymentItem(
              amount: "${total}",
              status: PaymentItemStatus.final_price,
              label: "Total",
            )
          ],
        ),
      ),
    );
  }
}
