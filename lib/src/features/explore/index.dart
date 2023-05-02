import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/services/news_services.dart';
import '../../model/user_model.dart';
import '../../widgets/image/avatar.dart';

class Explore extends StatefulWidget {
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
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: [SizedBox(width: MediaQuery.of(context).size.width * 0.1)],
          title: SizedBox(
            height: MediaQuery.of(context).size.height * 0.045,
            child: GestureDetector(
              onTap: () async {
                showDialog(
                  context: widget.mainContext,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );

                await NewsService().searchNews(
                  context: widget.mainContext,
                  user: widget.user!,
                );

                if (context.mounted) {
                  Navigator.of(widget.mainContext, rootNavigator: true).pop();
                }
              },
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
          ),
          leading: GestureDetector(
            onTap: widget.onAvatarTap,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                top: 10,
                bottom: 10,
              ),
              child: avatar(
                user: widget.user!,
                width: MediaQuery.of(context).size.height * 0.05,
                height: MediaQuery.of(context).size.height * 0.05,
              ),
            ),
          ),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_bike)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Icon(Icons.directions_car),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }
}
