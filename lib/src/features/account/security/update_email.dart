import 'package:flutter/material.dart';
import 'package:flutter_base/src/model/user_model.dart';
import 'package:flutter_base/src/services/user_services.dart';
import 'package:flutter_base/src/widgets/appbar/appbar_confirm_cancel.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../services/helpers.dart';

class UpdateEmail extends StatefulWidget {
  const UpdateEmail({
    super.key,
    this.includeAuth = true,
    required this.user,
  });

  final bool includeAuth;
  final UserModel user;

  @override
  State<UpdateEmail> createState() => _UpdateEmailState();
}

class _UpdateEmailState extends State<UpdateEmail> {
  final TextEditingController newEmailController = TextEditingController();
  final TextEditingController oldEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _submitted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarConfirmCancel(
        title: "Update Email",
        onCancel: () => Navigator.pop(context),
        onConfirm: () async {
          setState(() => _submitted = true);

          if (widget.includeAuth) {
            if (_validateEmptyFieldWAuth() &&
                validateEmail(newEmailController) &&
                validateEmail(oldEmailController)) {
              final result = await UserServices().updateEmail(
                user: widget.user,
                oldEmail: oldEmailController.text,
                newEmail: newEmailController.text,
                password: passwordController.text,
                includeAuth: true,
              );

              if (result == true && context.mounted) {
                Fluttertoast.showToast(msg: "Email Updated!");
                Navigator.pop(context);
                Fluttertoast.showToast(
                    msg: "Close application and reopen if no changes happen.");
              }
            }
          } else {
            if (_validateEmptyField() && validateEmail(newEmailController)) {
              if (_validateEmptyField() && validateEmail(newEmailController)) {
                final result = await UserServices().updateEmail(
                  user: widget.user,
                  oldEmail: oldEmailController.text,
                  newEmail: newEmailController.text,
                  password: passwordController.text,
                  includeAuth: true,
                );

                if (result == true && context.mounted) {
                  Fluttertoast.showToast(msg: "Email Updated!");
                  Navigator.pop(context);
                  Fluttertoast.showToast(
                      msg:
                          "Close application and reopen if no changes happen.");
                }
              }
            }
          }
        },
        // onConfirm: () async {
        //   dynamic result = await UserServices().updateDetails(
        //     id: widget.user.id,
        //     name: nameController.text,
        //     birthday: birthdayController.text == ""
        //         ? null
        //         : DateFormat('dd/MM/yyyy').parse(birthdayController.text),
        //     phone: phoneController.text,
        //     address: addressController.text,
        //     countryNumber: countryDropdownValue,
        //     networkInfo: _networkInfo,
        //     deviceInfoPlugin: _deviceInfo,
        //   );

        //   if (result == true && context.mounted) {
        //     Fluttertoast.showToast(msg: "Details sucessfully updated.");
        //     Fluttertoast.showToast(
        //         msg: "Close application and reopen if no changes happen.");
        //     Navigator.of(context).pop();
        //   }
        // },
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
        child: ListView(
          children: [
            Text(widget.includeAuth
                ? "Enter new email, old email and password then click submmit button at top right."
                : "Enter new email then click submmit button at top right."),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                controller: newEmailController,
                decoration: InputDecoration(
                  labelText: 'New Email',
                  errorText: _submitted == true &&
                          newEmailController.text.isEmpty
                      ? "Input can't be empty"
                      : _submitted == true && !validateEmail(newEmailController)
                          ? "Please enter the correct email"
                          : null,
                ),
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
              ),
            ),
            widget.includeAuth
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: oldEmailController,
                      decoration: InputDecoration(
                        labelText: 'Old Email',
                        errorText: _submitted == true &&
                                oldEmailController.text.isEmpty
                            ? "Input can't be empty"
                            : _submitted == true &&
                                    !validateEmail(oldEmailController)
                                ? "Please enter the correct email"
                                : null,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                    ),
                  )
                : const SizedBox(),
            widget.includeAuth
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        errorText: _submitted == true &&
                                passwordController.text.isEmpty
                            ? "Input can't be empty"
                            : null,
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  bool _validateEmptyFieldWAuth() {
    return newEmailController.text.isEmpty ||
            oldEmailController.text.isEmpty ||
            passwordController.text.isEmpty
        ? false
        : true;
  }

  bool _validateEmptyField() {
    return newEmailController.text.isEmpty ? false : true;
  }
}
