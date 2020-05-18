import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'new_account_viewmodel.dart';
import '../update_profile_screen/update_profile_screen.dart';

class NewAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewAccountScreenViewModel>.reactive(
      viewModelBuilder: () => NewAccountScreenViewModel(),
      onModelReady: (model) => model.register(),
      builder: (context, model, child) => Scaffold(
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
                const SizedBox(
                  height: 4.0,
                ),
                !model.idGenerated
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
                    : (!model.error
                        ? Text(
                            "Your ID: ${model.id}",
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
                      opacity: model.idGenerated ? 1 : 0,
                      child: RaisedButton(
                        onPressed: () {
                          if (model.idGenerated) {
                            if (!model.error) {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (_) => UpdateProfileScreen(),
                                ),
                                (Route<dynamic> route) => false,
                              );
                            } else {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (_) => NewAccountScreen(),
                                ),
                                (Route<dynamic> route) => false,
                              );
                            }
                          }
                        },
                        color: Theme.of(context).primaryColor,
                        textColor: Theme.of(context).canvasColor,
                        child: Text(model.error ? "TRY AGAIN" : "NEXT"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
