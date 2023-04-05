import 'package:flutter/material.dart';
import '../../../widgets/appbar/appbar_confirm_cancel.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({
    super.key,
    this.includeAuth = true,
  });
  final bool includeAuth;

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool _submitted = false;

  @override
  void dispose() {
    newPasswordController.dispose();
    oldPasswordController.dispose();
    emailController.dispose();
    super.dispose();
  }

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
          children: [
            Text(widget.includeAuth
                ? "Enter new password, email and old password then click submmit button at top right."
                : "Enter new password then click submmit button at top right."),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'New Password',
                ),
                obscureText: true,
              ),
            ),
            widget.includeAuth
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: [AutofillHints.email],
                    ),
                  )
                : const SizedBox(),
            widget.includeAuth
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Old Password',
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
