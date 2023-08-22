import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SaveImageToPhone {
  saveImage(String url, BuildContext context) async {
    try {
      await GallerySaver.saveImage(url).then((value) {
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.success(
            message: "Good job, your release is successful. Have a nice day",
          ),
        );
      });
    } catch (e) {
      //
    }
  }
}
