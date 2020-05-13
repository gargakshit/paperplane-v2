import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:paperplane/constants/onBoardingState.dart';
import 'package:pinenacl/secret.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:paperplane/api/accounts.dart';
import 'package:paperplane/models/accounts/register.dart';
import 'package:paperplane/screens/onboarding/updateProfile.dart';

class NewAccountPage extends StatefulWidget {
  @override
  _NewAccountPageState createState() => _NewAccountPageState();
}

class _NewAccountPageState extends State<NewAccountPage> {
  bool idGenerated = false;
  String id = "";
  bool error = false;

  @override
  void initState() {
    super.initState();

    register();
  }

  register() async {
    await Future.delayed(
      Duration(
        seconds: 5,
      ),
    );

    final storage = new FlutterSecureStorage();
    final prefs = await SharedPreferences.getInstance();

    final myKeys = PrivateKey.generate();
    final pubKey = myKeys.publicKey;

    await storage.write(key: "myPrivateKey", value: myKeys.join(","));

    try {
      RegisterResponseModel registerResponse = await AccountsApi.register(
        RegisterRequestModel(publicKey: Base64Encoder().convert(pubKey)),
      );

      await storage.write(key: "myId", value: registerResponse.id);
      await prefs.setString("eJWT", registerResponse.token);
      await prefs.setString("eJWTTime", DateTime.now().toString());
      await prefs.setBool("onBoardingComplete", false);
      await prefs.setInt("onBoardingState", OnBoardingState.ID_GENERATED.index);

      setState(() {
        idGenerated = true;
        id = registerResponse.id;
      });
    } catch (e) {
      setState(() {
        idGenerated = true;
        error = true;
      });
    }
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
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(),
              ),
              Text(
                "Let's begin by assigning you an ID",
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 4.0,
              ),
              !idGenerated
                  ? FadeAnimatedTextKit(
                      text: [
                        "We are generating you an ID",
                        "Please Wait",
                      ],
                      duration: Duration(
                        seconds: 3,
                      ),
                      isRepeatingAnimation: true,
                      textStyle: Theme.of(context).textTheme.bodyText2,
                    )
                  : (!error
                      ? Text(
                          "Your ID: $id",
                          style: Theme.of(context).textTheme.bodyText2,
                        )
                      : Text(
                          "There was an error generating your ID",
                          style: Theme.of(context).textTheme.bodyText2.apply(
                                color: Colors.red[300],
                              ),
                        )),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 175),
                    opacity: idGenerated ? 1 : 0,
                    child: RaisedButton(
                      onPressed: () {
                        if (idGenerated) {
                          if (!error) {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (_) => UpdateProfilePage(),
                              ),
                              (Route<dynamic> route) => false,
                            );
                          } else {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (_) => NewAccountPage(),
                              ),
                              (Route<dynamic> route) => false,
                            );
                          }
                        }
                      },
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).canvasColor,
                      child: Text(error ? "TRY AGAIN" : "NEXT"),
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
