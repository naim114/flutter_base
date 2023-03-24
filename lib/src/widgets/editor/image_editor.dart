import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../appbar/appbar_confirm_cancel.dart';

// ignore: must_be_immutable
class SingleImageUploader extends StatefulWidget {
  final void Function() onCancel;
  final void Function() onConfirm;
  final String appBarTitle;
  final double width;
  final double height;
  dynamic imageFile;

  SingleImageUploader({
    super.key,
    required this.onCancel,
    required this.onConfirm,
    this.width = 200,
    this.height = 200,
    this.appBarTitle = "Upload Image",
    this.imageFile,
  });

  @override
  State<SingleImageUploader> createState() => ImageFileEditorState();
}

class ImageFileEditorState extends State<SingleImageUploader> {
  var imagePicker;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarConfirmCancel(
        onCancel: widget.onCancel,
        onConfirm: widget.onConfirm,
        title: widget.appBarTitle,
        context: context,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () => showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Wrap(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.image),
                        title: const Text('Upload Image from Gallery'),
                        onTap: () => uploadImage(ImageSource.gallery),
                      ),
                      ListTile(
                        leading: const Icon(Icons.camera),
                        title: const Text('Upload Image from Camera'),
                        onTap: () => uploadImage(ImageSource.camera),
                      ),
                    ],
                  );
                },
              ),
              child: widget.imageFile != null
                  ? Image.file(
                      widget.imageFile,
                      width: widget.width,
                      height: widget.height,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: widget.width,
                      height: widget.height,
                      decoration: const BoxDecoration(
                        color: CupertinoColors.inactiveGray,
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[800],
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 30,
              ),
              child: Text(
                'Image resolution is ${widget.width.toInt()} x ${widget.height.toInt()}. Tap image to upload new image. Tap top right to confirm changes. ',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> uploadImage(ImageSource source) async {
    XFile image = await imagePicker.pickImage(
      source: source,
      imageQuality: 50,
      preferredCameraDevice: CameraDevice.front,
    );

    setState(() {
      widget.imageFile = File(image.path);
    });
  }
}
