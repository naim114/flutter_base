import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_base/src/widgets/appbar/appbar_confirm_cancel.dart';

class UpdateEmail extends StatelessWidget {
  const UpdateEmail({
    super.key,
    this.includeAuth = true,
  });

  final bool includeAuth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarConfirmCancel(
        title: "Update Email",
        onCancel: () => Navigator.pop(context),
        onConfirm: () {},
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
        child: ListView(
          children: [
            Text(includeAuth
                ? "Enter new email, old email and password then click submmit button at top right."
                : "Enter new email then click submmit button at top right."),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'New Email',
                ),
                keyboardType: TextInputType.emailAddress,
                autofillHints: [AutofillHints.email],
              ),
            ),
            includeAuth
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Old Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: [AutofillHints.email],
                    ),
                  )
                : const SizedBox(),
            includeAuth
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
