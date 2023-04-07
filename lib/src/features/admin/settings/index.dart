import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      body: ListView(
        children: [
          ListTile(
            title: const Text("Application name"),
            trailing: const Text("Application name"),
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
            trailing: const Text("https://github.com/naim114"),
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
            trailing: const Text("https://github.com/naim114"),
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
            trailing: const Text("https://github.com/naim114"),
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
            title: const Text("Logo"),
            trailing: const Text(
              "Tap to change logo",
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ImageUploader(
                  appBarTitle: "Upload Logo",
                  onCancel: () => Navigator.pop(context),
                  onConfirm: (imageFile) {},
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text("Primary color"),
            trailing: SizedBox(
              width: 20.0,
              height: 20.0,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: CupertinoColors.systemGrey)),
                child: const DecoratedBox(
                  decoration: BoxDecoration(color: CustomColor.primary),
                ),
              ),
            ),
            onTap: () => colorPicker(initialColor: CustomColor.primary),
          ),
          ListTile(
            title: const Text("Secondary color"),
            trailing: SizedBox(
              width: 20.0,
              height: 20.0,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: CupertinoColors.systemGrey)),
                child: const DecoratedBox(
                  decoration: BoxDecoration(color: CustomColor.secondary),
                ),
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Neutral 1 color"),
            trailing: SizedBox(
              width: 20.0,
              height: 20.0,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: CupertinoColors.systemGrey)),
                child: const DecoratedBox(
                  decoration: BoxDecoration(color: CustomColor.neutral1),
                ),
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Neutral 2 color"),
            trailing: SizedBox(
              width: 20.0,
              height: 20.0,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: CupertinoColors.systemGrey)),
                child: const DecoratedBox(
                  decoration: BoxDecoration(color: CustomColor.neutral2),
                ),
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Neutral 3 color"),
            trailing: SizedBox(
              width: 20.0,
              height: 20.0,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: CupertinoColors.systemGrey)),
                child: const DecoratedBox(
                  decoration: BoxDecoration(color: CustomColor.neutral3),
                ),
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Semantic 1 color"),
            trailing: SizedBox(
              width: 20.0,
              height: 20.0,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: CupertinoColors.systemGrey)),
                child: const DecoratedBox(
                  decoration: BoxDecoration(color: CustomColor.semantic1),
                ),
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Semantic 2 color"),
            trailing: SizedBox(
              width: 20.0,
              height: 20.0,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: CupertinoColors.systemGrey)),
                child: const DecoratedBox(
                  decoration: BoxDecoration(color: CustomColor.semantic2),
                ),
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Danger color"),
            trailing: SizedBox(
              width: 20.0,
              height: 20.0,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: CupertinoColors.systemGrey)),
                child: const DecoratedBox(
                  decoration: BoxDecoration(color: CustomColor.danger),
                ),
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Success color"),
            trailing: SizedBox(
              width: 20.0,
              height: 20.0,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: CupertinoColors.systemGrey)),
                child: const DecoratedBox(
                  decoration: BoxDecoration(color: CustomColor.success),
                ),
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
