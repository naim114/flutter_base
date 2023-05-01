import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../model/user_model.dart';
import '../../widgets/image/avatar.dart';

class Explore extends StatelessWidget {
  const Explore({
    super.key,
    required this.mainContext,
    this.user,
    this.onAvatarTap,
  });
  final BuildContext mainContext;
  final UserModel? user;
  final void Function()? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [SizedBox(width: MediaQuery.of(context).size.width * 0.1)],
        title: SizedBox(
          height: MediaQuery.of(context).size.height * 0.045,
          child: TextField(
            readOnly: false,
            autofocus: false,
            enabled: false,
            decoration: InputDecoration(
              fillColor: Theme.of(context).brightness == Brightness.dark
                  ? CupertinoColors.darkBackgroundGray
                  : Colors.white,
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
                borderSide: const BorderSide(
                  color: CupertinoColors.systemGrey,
                  width: 1.5,
                ),
              ),
              contentPadding: const EdgeInsets.all(0),
              prefixIcon: const Icon(Icons.search),
              hintText: 'Search news here',
            ),
          ),
        ),
        leading: GestureDetector(
          onTap: onAvatarTap,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              top: 10,
              bottom: 10,
            ),
            child: avatar(
              user: user!,
              width: MediaQuery.of(context).size.height * 0.05,
              height: MediaQuery.of(context).size.height * 0.05,
            ),
          ),
        ),
      ),
      body: Center(
        child: Text("oh my"),
      ),
    );
  }
}
