import 'package:flutter/material.dart';
import 'package:flutter_base/src/widgets/appbar/appbar_confirm_cancel.dart';

class UpdateEmail extends StatefulWidget {
  const UpdateEmail({
    super.key,
    this.includeAuth = true,
  });

  final bool includeAuth;

  @override
  State<UpdateEmail> createState() => _UpdateEmailState();
}

class _UpdateEmailState extends State<UpdateEmail> {
  final TextEditingController newEmailController = TextEditingController();
  final TextEditingController oldEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
            Text(widget.includeAuth
                ? "Enter new email, old email and password then click submmit button at top right."
                : "Enter new email then click submmit button at top right."),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                controller: newEmailController,
                decoration: const InputDecoration(labelText: 'New Email'),
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
              ),
            ),
            widget.includeAuth
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: oldEmailController,
                      decoration: const InputDecoration(labelText: 'Old Email'),
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
                      decoration: const InputDecoration(labelText: 'Password'),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
