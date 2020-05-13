import 'package:flutter/material.dart';

import 'package:paperplane/screens/onboarding/newAccount.dart';

class GettingStartedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(),
              ),
              Center(
                child: Text(
                  "PaperPlane",
                  style: Theme.of(context).textTheme.headline3.apply(
                      color: Theme.of(context).textTheme.bodyText1.color),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: OutlineButton(
                          onPressed: () {
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Under Development...",
                                ),
                                action: SnackBarAction(
                                  label: "OK",
                                  onPressed: () {},
                                ),
                              ),
                            );
                          },
                          highlightedBorderColor:
                              Theme.of(context).primaryColor,
                          textColor: Theme.of(context).primaryColor,
                          child: Text("RESTORE FROM BACKUP"),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          textColor: Theme.of(context).canvasColor,
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (_) => NewAccountPage(),
                              ),
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: Text("GET STARTED"),
                        ),
                      ),
                    ],
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
