import 'package:ecommerce_app/inner_screens/upload_product_form.dart';
import 'package:ecommerce_app/screens/landing_page.dart';
import 'package:flutter/material.dart';

import 'bottom_bar.dart';

class MainScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [LandingPage(), UploadProductForm()],
    );
  }
}
