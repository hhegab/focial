import 'dart:io';

import 'package:flutter/material.dart';
import 'package:focial/services/finder.dart';
import 'package:focial/services/user.dart';
import 'package:focial/utils/theme.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfileViewModel extends ChangeNotifier {
  // BuildContext _context;
  PickedFile pp;
  PickedFile cp;
  final userData = find<UserData>();
  Status status = Status.loaded;

  Future<void> pickProfilePicture() async {
    // ignore: invalid_use_of_visible_for_testing_member
    pp = await ImagePicker.platform.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pp != null) {
      final File croppedFile = await ImageCropper.cropImage(
        sourcePath: pp.path.toString(),
        androidUiSettings: const AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: AppTheme.primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
        iosUiSettings: const IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      );
      if (croppedFile != null) {
        userData.updateProfilePicture(croppedFile.path);
      }
    }
  }

  Future<void> pickCoverPicture() async {
    // ignore: invalid_use_of_visible_for_testing_member
    cp = await ImagePicker.platform.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (cp != null) {
      final File croppedFile = await ImageCropper.cropImage(
        sourcePath: cp.path.toString(),
        androidUiSettings: const AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: AppTheme.primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.ratio16x9,
          lockAspectRatio: true,
        ),
        iosUiSettings: const IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      );
      if (croppedFile != null) {
        userData.updateCoverPicture(croppedFile.path);
      }
    }
  }

  void init(BuildContext context) {
    // _context = context;
  }
}
