import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

import '../../../services/locator.dart';
import '../../../services/key_value/key_value_service.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final KeyValueService prefs = locator<KeyValueService>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 16.0,
        ),
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, i) => [
            InkWell(
              onTap: () {},
              child: Container(
                height: MediaQuery.of(context).size.width / 4.75,
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
                      width: MediaQuery.of(context).size.width / 4.75,
                      child: !prefs.getBool("hasPfp")
                          ? getLetterPfp(context, prefs)
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

                                return getLetterPfp(context, prefs);
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
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Feather.lock),
              title: Text("Privacy"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Feather.sun),
              title: Text("Appearance"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Feather.help_circle),
              title: Text("Help"),
              onTap: () {},
            ),
          ][i],
        ),
      ),
    );
  }

  Widget getLetterPfp(BuildContext context, KeyValueService prefs) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Center(
        child: Text(
          prefs.getString("myName").substring(0, 1).toUpperCase(),
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
