import 'package:country/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/services/helpers.dart';
import 'package:flutter_base/src/widgets/appbar/appbar_confirm_cancel.dart';
import 'package:intl/intl.dart';

import '../../../widgets/editor/image_uploader.dart';

class Profile extends StatefulWidget {
  final Widget bottomWidget;
  const Profile({
    super.key,
    this.bottomWidget = const SizedBox(),
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<Country> list = Countries.values;
  TextEditingController dateinput = TextEditingController();
  String dropdownValue = Countries.mys.number;

  @override
  void initState() {
    dateinput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarConfirmCancel(
        onCancel: () => Navigator.pop(context),
        onConfirm: () {},
        title: "Edit Profile",
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Column(
          children: [
            // Profile Picture
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Wrap(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.image_outlined),
                          title: const Text('New profile picture'),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ImageUploader(
                                appBarTitle: "Upload New Profile Picture",
                                onCancel: () => Navigator.of(context).pop(),
                                onConfirm: () {},
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.delete_outline,
                            color: CustomColor.danger,
                          ),
                          title: const Text(
                            'Remove current picture',
                            style: TextStyle(color: CustomColor.danger),
                          ),
                          onTap: () {},
                        ),
                      ],
                    );
                  },
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage:
                        AssetImage('assets/images/default-profile-picture.png'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Edit Profile Picture',
                      style: TextStyle(
                        color: CustomColor.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  // Name
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Name',
                      ),
                    ),
                  ),
                  // Birthday
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: dateinput,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Birthday',
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now());

                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('dd/MM/yyyy').format(pickedDate);
                          setState(() => dateinput.text = formattedDate);
                        } else {
                          setState(() => dateinput.text =
                              DateFormat('dd/MM/yyyy').format(DateTime.now()));
                        }
                      },
                    ),
                  ),
                  // Phone Number
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                      ),
                    ),
                  ),
                  // Country
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      elevation: 0,
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      decoration: const InputDecoration(
                        labelText: 'Country',
                      ),
                      onChanged: (String? value) {
                        print(value);
                        setState(() => dropdownValue = value!);
                      },
                      items:
                          list.map<DropdownMenuItem<String>>((Country country) {
                        return DropdownMenuItem<String>(
                          value: country.number,
                          child: Text(
                            country.isoShortName,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: widget.bottomWidget,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
