import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:focial/screens/posts/new_post_viewmodel.dart';
import 'package:focial/services/finder.dart';
import 'package:focial/services/user.dart';
import 'package:focial/utils/assets.dart';
import 'package:focial/utils/helpers.dart';
import 'package:stacked/stacked.dart';

class NewPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentUser = find<UserData>().currentUser;

    return ViewModelBuilder<NewPostViewModel>.reactive(
      viewModelBuilder: () => NewPostViewModel(),
      onModelReady: (m) => m.init(context),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'New post',
            style:  TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            FlatButton(
              onPressed: model.post,
              child: const Text(
                'post',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 14.0,
                      backgroundColor: Colors.white,
                      backgroundImage: CachedNetworkImageProvider(
                        currentUser.photoUrl != null ? currentUser.photoUrl.getAssetURL() : Assets.defaultProfilePicture,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Text(
                      "${currentUser.firstName} ${currentUser.lastName}".replaceAll("null", ""),
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                CupertinoScrollbar(
                  child: TextField(
                    controller: model.captionController,
                    maxLines: 5,
                    maxLength: 512,
                    scrollPhysics: const BouncingScrollPhysics(),
                    style: const TextStyle(fontSize: 18.0),
                    decoration: InputDecoration(
                      errorText: model.captionError,
                      contentPadding: const EdgeInsets.all(16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      hintText: 'How are you feeling today man',
                      counterText: "",
                    ),
                  ),
                ),

                const SizedBox(height: 16.0),
                // images
                imagesList(model)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget imagesList(NewPostViewModel model) {
    final List<Widget> images = <Widget>[];
    for (final element in model.images) {
      images.add(
        Card(
          elevation: 4.0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.blue,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: CachedNetworkImage(
            height: 80.0,
            width: 80.0,
            fit: BoxFit.contain,
            imageUrl: element.getAssetURL(),
          ),
        ),
      );
    }

    return SizedBox(
      height: 80.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [...images, addImageButton(model)],
      ),
    );
  }

  Widget addImageButton(NewPostViewModel model) {
    return GestureDetector(
      onTap: model.addImage,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        // margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: const [
              Icon(
                Icons.add_photo_alternate,
                color: Colors.grey,
                size: 28.0,
              ),
              SizedBox(height: 8.0),
              Text(
                'Add Image',
                style: TextStyle(fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
