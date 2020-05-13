import 'dart:io';
import 'dart:math';

import 'package:aes_crypt/aes_crypt.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'package:paperplane/constants/onBoardingState.dart';
import 'package:paperplane/constants/api.dart';
import 'package:paperplane/main.dart';

class UpdateProfilePage extends StatefulWidget {
  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  File profilePhoto;
  TextEditingController nameController;
  bool isButtonVisible = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController();
    nameController.addListener(() {
      if (nameController.text.isNotEmpty) {
        setState(() {
          isButtonVisible = true;
        });
      } else {
        setState(() {
          isButtonVisible = false;
        });
      }
    });
  }

  pickPhoto() async {
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      profilePhoto = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      pickPhoto();
                    },
                    child: InkWell(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 5,
                        height: MediaQuery.of(context).size.width / 5,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(9999),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.grey[400]
                                  : Colors.grey[900],
                              spreadRadius: 12,
                              blurRadius: 64,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: profilePhoto == null
                              ? Icon(
                                  Feather.user,
                                  color: Theme.of(context).canvasColor,
                                  size: (MediaQuery.of(context).size.width /
                                          5) -
                                      (MediaQuery.of(context).size.width / 10),
                                )
                              : ClipRRect(
                                  child: Image.file(
                                    profilePhoto,
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(9999),
                                ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: "Enter your name",
                        filled: true,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 175),
                    opacity: isButtonVisible ? 1 : 0,
                    child: RaisedButton(
                      onPressed: !isLoading
                          ? () async {
                              if (isButtonVisible) {
                                setState(() {
                                  isLoading = true;
                                });

                                await Future.delayed(
                                  Duration(seconds: 1),
                                );

                                final prefs =
                                    await SharedPreferences.getInstance();

                                await prefs.setBool("hasPfp", false);

                                if (profilePhoto != null) {
                                  final password =
                                      "${Random.secure().nextInt(9999999)}-${Uuid().v4()}";

                                  final crypt = AesCrypt(password);
                                  crypt.setOverwriteMode(AesCryptOwMode.on);

                                  final docsDir =
                                      (await getApplicationDocumentsDirectory())
                                          .path;
                                  String encPath = join(docsDir, "pfp.aes");
                                  String pfpPath = join(docsDir, "pfp.jpg");

                                  await File(pfpPath).writeAsBytes(
                                    await profilePhoto.readAsBytes(),
                                  );

                                  await crypt.encryptFile(
                                      profilePhoto.path, encPath);

                                  await prefs.setString("pfpPass", password);
                                  await prefs.setBool("hasPfp", true);

                                  final eJWT = prefs.getString("eJWT");

                                  final dio = Dio();
                                  final response = await dio.post(
                                    "$mediaUrl/upload",
                                    data: FormData.fromMap(
                                      {
                                        "file": await MultipartFile.fromFile(
                                          encPath,
                                          filename: "pfp.jpg",
                                        ),
                                      },
                                    ),
                                    options: Options(
                                      headers: {
                                        "Authorization": eJWT,
                                      },
                                    ),
                                  );

                                  await prefs.setString(
                                    "myPfpServerId",
                                    response.data,
                                  );
                                }
                                await prefs.setString(
                                    "myName", nameController.text);
                                await prefs.setBool("onBoardingComplete", true);
                                await prefs.setInt(
                                  "onBoardingState",
                                  OnBoardingState.ABOUT_UPDATED.index,
                                );

                                setState(() {
                                  isLoading = false;
                                });

                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (_) => MyApp(),
                                  ),
                                  (Route<dynamic> route) => false,
                                );
                              }
                            }
                          : null,
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).canvasColor,
                      child: !isLoading
                          ? Text("DONE")
                          : Container(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                                strokeWidth: 2.0,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
