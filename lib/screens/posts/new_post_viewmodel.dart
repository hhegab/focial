import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show BuildContext, ChangeNotifier, Colors, FocusScope, TextEditingController;
import 'package:focial/models/post_feed.dart';
import 'package:focial/services/api.dart';
import 'package:focial/services/finder.dart';
import 'package:focial/services/post_feed.dart';
import 'package:focial/utils/overlays.dart';
import 'package:focial/utils/theme.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ots/ots.dart';

class NewPostViewModel extends ChangeNotifier {
  BuildContext _context;
  PickedFile postPicture;
  List<String> _images = [];
  final TextEditingController captionController = TextEditingController();
  String _captionError;
  final imagePicker = ImagePicker();

  void init(BuildContext context) {
    _context = context;
    _listen();
  }

  void _listen() {
    captionController.addListener(() {
      if (captionController.text.isNotEmpty) {
        captionError = null;
      } else {
        captionError = "Write something to post";
      }
    });
  }

  Future<void> post() async {
    if (images.isEmpty && captionController.text.isEmpty) {
      captionError = "Write something to post";
    } else {
      FocusScope.of(_context).requestFocus(FocusNode());
      captionError = null;
      showLoader();
      final response = await find<PostFeedService>().newPost(PostFeed(caption: captionController.text, images: images));
      if (response.isSuccessful) {
        // todo: update posts count in profile after successful post
        Navigator.of(_context).pop();
      } else {
        AppOverlays.showError('Post failed', "Unable to publish your post, please try later");
      }
      hideLoader();
    }
  }

  Future<void> addImage() async {
    postPicture = await imagePicker.getImage(source: ImageSource.gallery, imageQuality: 80);

    if (postPicture != null) {
      final File croppedFile = await ImageCropper.cropImage(
        sourcePath: postPicture.path.toString(),
        // aspectRatio: CropAspectRatio(ratioX: 3, ratioY: 2),
        androidUiSettings: const AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: AppTheme.primaryColor,
          toolbarWidgetColor: Colors.white,
          // initAspectRatio: CropAspectRatioPreset.ratio3x2,
          // lockAspectRatio: true,
        ),
        iosUiSettings: const IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      );
      if (croppedFile != null) {
        showLoader();
        final response = await find<APIService>().api.uploadPostImage(croppedFile.path);
        hideLoader();
        if (response.isSuccessful) {
          _images.add(response.body["url"].toString());
          notifyListeners();
          debugPrint(images.toString());
        }
      }
    }
  }

  List<String> get images => _images;

  set images(List<String> value) {
    _images = value;
    notifyListeners();
  }

  String get captionError => _captionError;

  set captionError(String value) {
    _captionError = value;
    notifyListeners();
  }
}
