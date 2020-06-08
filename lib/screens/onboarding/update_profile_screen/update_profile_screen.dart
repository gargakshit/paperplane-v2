import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:stacked/stacked.dart';

import 'update_profile_viewmodel.dart';
import '../../../main.dart';
import '../../../utils/is_dark.dart';

class UpdateProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdateProfileViewModel>.reactive(
      viewModelBuilder: () => UpdateProfileViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) {
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
                          if (!model.isLoading) {
                            model.pickPhoto();
                          }
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
                                  color: !isDark(context)
                                      ? Colors.grey[400]
                                      : Colors.grey[900],
                                  spreadRadius: 12,
                                  blurRadius: 64,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: model.profilePhoto == null
                                  ? Icon(
                                      Feather.image,
                                      color: Theme.of(context).canvasColor,
                                      size: (MediaQuery.of(context).size.width /
                                              5) -
                                          (MediaQuery.of(context).size.width /
                                              10),
                                    )
                                  : ClipRRect(
                                      child: Image.file(
                                        model.profilePhoto,
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
                          controller: model.nameController,
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
                        opacity: model.isButtonVisible ? 1 : 0,
                        child: RaisedButton(
                          onPressed: !model.isLoading
                              ? () async {
                                  if (model.isButtonVisible) {
                                    await model.updateProfile();

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
                          child: !model.isLoading
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
      },
    );
  }
}
