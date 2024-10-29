import 'package:flutter/widgets.dart';

class BindingService {
  // This method ensures that the provided callback runs after the current frame has been rendered.
  static void runAfterBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback(); // Execute the provided callback after the build completes
    });
  }
}
