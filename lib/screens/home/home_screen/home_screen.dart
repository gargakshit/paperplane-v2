import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:stacked/stacked.dart';

import 'home_screen_viewmodel.dart';
import '../chat_screen/chat_screen.dart';

class HomeScreen extends StatelessWidget {
  final String name;
  final bool hasPfp;
  final String pfpPath;

  HomeScreen({this.name, this.hasPfp, this.pfpPath});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeScreenViewModel>.reactive(
      viewModelBuilder: () => HomeScreenViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9999),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.grey[400]
                          : Colors.grey[900],
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: !hasPfp
                    ? Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Center(
                          child: Text(
                            name.substring(0, 1).toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Theme.of(context).canvasColor,
                            ),
                          ),
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(9999),
                        child: Image.file(
                          File(pfpPath),
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Text(
                "PaperPlane",
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: model.setPage,
          currentIndex: model.currentPage,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Feather.message_square),
              title: Text("Chat"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Feather.users),
              title: Text("Contacts"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Feather.settings),
              title: Text("Settings"),
            ),
          ],
        ),
        body: PageTransitionSwitcher(
          transitionBuilder: (
            Widget child,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: [
            ChatScreen(),
            Center(
              child: Text("Contacts"),
            ),
            Container(
              alignment: Alignment.center,
              child: Text("Settings"),
            ),
          ][model.currentPage],
        ),
      ),
    );
  }
}
