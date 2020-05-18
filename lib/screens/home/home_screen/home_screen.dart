import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:stacked/stacked.dart';

import 'home_screen_viewmodel.dart';
import '../chat_screen/chat_screen.dart';
import '../settings_screen/settings_screen.dart';

class HomeScreen extends StatelessWidget {
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
              SizedBox(
                width: 12.0,
              ),
              Text(
                "PaperPlane",
                style: Theme.of(context).textTheme.headline5,
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
        body: IndexedStack(
          children: [
            ChatScreen(),
            Center(
              child: Text("Contacts"),
            ),
            SettingsScreen(),
          ],
          index: model.currentPage,
        ),
      ),
    );
  }
}
