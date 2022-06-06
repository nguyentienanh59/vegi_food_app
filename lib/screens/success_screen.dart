import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegi_food_app/config/colors.dart';
import 'package:vegi_food_app/providers/product_provider.dart';
import 'package:vegi_food_app/screens/home/home_screen.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/payment_success.gif"),
            const Text("Payment Success!"),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                  fixedSize: const Size(200, 50),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  )),
              onPressed: () async {
                final productProvider =
                    Provider.of<ProductProvider>(context, listen: false);
                productProvider.fatchHerbsProductData();
                productProvider.fatchFreshProductData();
                productProvider.fatchRootProductData();
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
              child: const Text("Done"),
            )
          ],
        ),
      ),
    );
  }
}
