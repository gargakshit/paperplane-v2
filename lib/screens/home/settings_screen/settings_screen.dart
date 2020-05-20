import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

import 'my_profile_screen/my_profile_screen.dart';
import '../../../services/locator.dart';
import '../../../services/key_value/key_value_service.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final KeyValueService prefs = locator<KeyValueService>();

    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: false,
      //   automaticallyImplyLeading: false,
      //   titleSpacing: 32,
      //   title: Text(
      //     "Settings",
      //     style: Theme.of(context).textTheme.headline5,
      //   ),
      // ),
      body: Container(
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, i) => [
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => MyProfileScreen(
                      myName: prefs.getString("myName"),
                      myId: prefs.getString("myId"),
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 24.0,
                  horizontal: 32.0,
                ),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          prefs.getString("myName"),
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          prefs.getString("myId"),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Container(
                      width: 56,
                      child: !prefs.getBool("hasPfp")
                          ? getLetterPfp(
                              context,
                              prefs.getString("myName"),
                              56,
                            )
                          : FutureBuilder<Directory>(
                              future: getApplicationDocumentsDirectory(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(9999),
                                    child: Image.file(
                                      File(join(snapshot.data.path, "pfp.png")),
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                }

                                return getLetterPfp(
                                  context,
                                  prefs.getString("myName"),
                                  56,
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            ListTile(
              leading: Icon(Feather.bell),
              title: Text("Notifications"),
              contentPadding: EdgeInsets.symmetric(horizontal: 32),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Feather.lock),
              title: Text("Privacy"),
              contentPadding: EdgeInsets.symmetric(horizontal: 32),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Feather.sun),
              title: Text("Appearance"),
              contentPadding: EdgeInsets.symmetric(horizontal: 32),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Feather.help_circle),
              title: Text("Help"),
              contentPadding: EdgeInsets.symmetric(horizontal: 32),
              onTap: () {},
            ),
          ][i],
        ),
      ),
    );
  }

  Widget getLetterPfp(BuildContext context, String name, double size) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(9999),
      ),
      width: size,
      height: size,
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
    );
  }
}
