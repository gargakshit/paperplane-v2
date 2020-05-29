import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'my_profile_screen/my_profile_screen.dart';
import '../../../services/locator.dart';
import '../../../services/key_value/key_value_service.dart';
import '../../../widgets/letter_pfp.dart';
import '../../../utils/is_dark.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final KeyValueService prefs = locator<KeyValueService>();

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              // actions: [
              //   FlatButton(
              //     child: Text("BACK"),
              //     onPressed: () {
              //       Navigator.of(context).pop();
              //     },
              //   )
              // ],
              backgroundColor: Theme.of(context).canvasColor,
              content: Container(
                height: 240,
                width: 180,
                child: Center(
                  child: QrImage(
                    data: jsonEncode({
                      "type": "user",
                      "name": prefs.getString("myName"),
                      "id": prefs.getString("myId"),
                    }),
                    size: 256,
                    foregroundColor:
                        isDark(context) ? Colors.white : Colors.black,
                  ),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
              ),
            ),
          );
        },
        label: Text("SHOW QR CODE"),
        icon: Icon(FontAwesome.qrcode),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: 8,
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
                padding: EdgeInsets.only(
                  bottom: 24.0,
                  top: MediaQuery.of(context).padding.top + 24.0,
                  left: 32.0,
                  right: 32.0,
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
                          ? LetterPfp(
                              name: prefs.getString("myName"),
                              size: 56,
                            )
                          : FutureBuilder<Directory>(
                              future: getApplicationDocumentsDirectory(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(9999),
                                    child: Image.file(
                                      File(
                                        join(snapshot.data.path, "pfp.png"),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                }

                                return LetterPfp(
                                  name: prefs.getString("myName"),
                                  size: 56,
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
              leading: Icon(Feather.download_cloud),
              title: Text("Backups"),
              contentPadding: EdgeInsets.symmetric(horizontal: 32),
              onTap: () {},
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
            ListTile(
              leading: Icon(Feather.info),
              title: Text("About"),
              contentPadding: EdgeInsets.symmetric(horizontal: 32),
              onTap: () {},
            ),
          ][i],
        ),
      ),
    );
  }
}
