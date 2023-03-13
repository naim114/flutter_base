import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../widgets/appbar_confirm_cancel.dart';

class UpdatePassword extends StatelessWidget {
  const UpdatePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarConfirmCancel(
        title: "Update Password",
        onCancel: () => Navigator.pop(context),
        onConfirm: () {},
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
        child: ListView(
          children: const [
            Text(
                "Enter new password, email and old password then click submmit button at top right."),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'New Password',
                ),
                obscureText: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                autofillHints: [AutofillHints.email],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Old Password',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
