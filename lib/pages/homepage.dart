import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicallim_test/controllers/responsive_controller.dart';
import 'package:musicallim_test/pages/mobilehomepage.dart'; 
import 'package:musicallim_test/pages/tablethomepage.dart'; 

class ResponsiveHomepage extends StatelessWidget {
  ResponsiveHomepage({super.key});

  final ResponsiveController controller = Get.put(ResponsiveController());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        controller.updateScreenWidth(constraints.maxWidth);
        return Obx(() {
          if (controller.isMobile()) {
            return MobileHomePage();
          } else {
            return TabletHomePage();
          }
        });
      },
    );
  }
}