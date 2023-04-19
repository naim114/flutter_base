import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/model/app_settings_model.dart';
import 'package:flutter_base/src/services/app_settings_services.dart';
import 'package:flutter_base/src/widgets/editor/single_input_editor.dart';
import 'package:flutter_base/src/widgets/editor/image_uploader.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../../services/helpers.dart';

class AppSettings extends StatelessWidget {
  const AppSettings({super.key});

  @override
  Widget build(BuildContext context) {
    void colorPicker({Color initialColor = CustomColor.primary}) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Pick a color'),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: initialColor, //default color
                  onColorChanged: (Color color) {
                    //on color picked
                  },
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text('DONE'),
                  onPressed: () {
                    Navigator.of(context).pop(); //dismiss the color picker
                  },
                ),
              ],
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: CustomColor.neutral2,
          ),
        ),
        title: Text(
          "Application Settings",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: getColorByBackground(context),
          ),
        ),
      ),
      body: StreamBuilder<AppSettingsModel?>(
        stream: AppSettingsServices().getAppSettingsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            AppSettingsModel? appSettings = snapshot.data;
            return appSettings == null
                ? const Center(child: CircularProgressIndicator())
                : ListView(
                    children: [
                      ListTile(
                        title: const Text("Application name"),
                        trailing: Text(appSettings.applicationName),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SingleInputEditor(
                              appBarTitle: 'Edit Application Name',
                              textFieldLabel: 'Application Name',
                              onCancel: () => Navigator.pop(context),
                              onConfirm: () {},
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        title: const Text("Copyright URL"),
                        trailing: Text(appSettings.urlCopyright),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SingleInputEditor(
                              appBarTitle: 'Edit Copyright URL',
                              textFieldLabel: 'Copyright URL',
                              onCancel: () => Navigator.pop(context),
                              onConfirm: () {},
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        title: const Text("Privacy Policy URL"),
                        trailing: Text(appSettings.urlPrivacyPolicy),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SingleInputEditor(
                              appBarTitle: 'Edit Privacy Policy URL',
                              textFieldLabel: 'Privacy Policy URL',
                              onCancel: () => Navigator.pop(context),
                              onConfirm: () {},
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        title: const Text("Terms & Condition URL"),
                        trailing: Text(appSettings.urlTermCondition),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SingleInputEditor(
                              appBarTitle: 'Edit Terms & Condition URL',
                              textFieldLabel: 'Terms & Condition URL',
                              onCancel: () => Navigator.pop(context),
                              onConfirm: () {},
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        title: const Text("Logo Main"),
                        trailing: const Text(
                          "Tap to change logo",
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        onTap: () async {
                          File imgFile =
                              await downloadImage(appSettings.logoMainURL);

                          if (context.mounted) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ImageUploader(
                                  appBarTitle: "Upload Logo Main",
                                  fit: null,
                                  imageFile: imgFile,
                                  height: 300,
                                  width: 300,
                                  onCancel: () => Navigator.pop(context),
                                  onConfirm: (imageFile, uploaderContext) {},
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      ListTile(
                        title: const Text("Logo Favicon"),
                        trailing: const Text(
                          "Tap to change logo favicon",
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        onTap: () async {
                          File imgFile =
                              await downloadImage(appSettings.logoFaviconURL);

                          if (context.mounted) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ImageUploader(
                                  appBarTitle: "Upload Logo Favicon",
                                  fit: null,
                                  imageFile: imgFile,
                                  height: 300,
                                  width: 300,
                                  onCancel: () => Navigator.pop(context),
                                  onConfirm: (imageFile, uploaderContext) {},
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  );
          }
        },
      ),
    );
  }
}
