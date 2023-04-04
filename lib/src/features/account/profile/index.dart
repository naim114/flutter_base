import 'package:country/country.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/model/user_model.dart';
import 'package:flutter_base/src/services/helpers.dart';
import 'package:flutter_base/src/services/user_services.dart';
import 'package:flutter_base/src/widgets/appbar/appbar_confirm_cancel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:network_info_plus/network_info_plus.dart';

import '../../../widgets/editor/image_uploader.dart';

class Profile extends StatefulWidget {
  final Widget bottomWidget;
  final UserModel user;

  const Profile({
    super.key,
    this.bottomWidget = const SizedBox(),
    required this.user,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  String countryDropdownValue = Countries.abw.number;

  @override
  void initState() {
    nameController.text = widget.user.name ?? "";
    phoneController.text = widget.user.phone ?? "";
    addressController.text = widget.user.address ?? "";
    birthdayController.text = widget.user.birthday != null
        ? DateFormat('dd/MM/yyyy')
            .format(widget.user.birthday ?? DateTime.now())
        : "";

    countryDropdownValue = widget.user.country.number;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarConfirmCancel(
        onCancel: () => Navigator.pop(context),
        onConfirm: () async {
          dynamic result = await UserServices().updateDetails(
            id: widget.user.id,
            name: nameController.text,
            birthday: birthdayController.text == ""
                ? null
                : DateFormat('dd/MM/yyyy').parse(birthdayController.text),
            phone: phoneController.text,
            address: addressController.text,
            countryNumber: countryDropdownValue,
          );

          if (result == true && context.mounted) {
            Fluttertoast.showToast(msg: "Details sucessfully updated.");
            Fluttertoast.showToast(
                msg: "Close application and reopen it if no changes happen.");
            Navigator.of(context).pop();
          }
        },
        title: "Edit Profile",
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: ListView(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                  ),
                  // Birthday
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: birthdayController,
                      readOnly: true,
                      decoration: const InputDecoration(labelText: 'Birthday'),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now());

                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('dd/MM/yyyy').format(pickedDate);
                          setState(
                              () => birthdayController.text = formattedDate);
                        } else {
                          setState(() => birthdayController.text =
                              DateFormat('dd/MM/yyyy').format(DateTime.now()));
                        }
                      },
                    ),
                  ),
                  // Phone Number
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: phoneController,
                      decoration:
                          const InputDecoration(labelText: 'Phone Number'),
                    ),
                  ),
                  // Address
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: addressController,
                      decoration: const InputDecoration(labelText: 'Address'),
                    ),
                  ),
                  // Country
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      elevation: 0,
                      value: countryDropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      decoration: const InputDecoration(labelText: 'Country'),
                      onChanged: (String? value) {
                        print(value);
                        setState(() => countryDropdownValue = value!);
                      },
                      items: Countries.values.map<DropdownMenuItem<String>>(
                        (Country country) {
                          return DropdownMenuItem<String>(
                            value: country.number,
                            child: Text(
                              country.isoShortName,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        },
                      ).toList(),
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
