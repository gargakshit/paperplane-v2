import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

import 'update_profile_viewmodel.dart';
import '../../../constants/colors.dart';
import '../../../main.dart';

class UpdateProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdateProfileViewModel>.reactive(
      viewModelBuilder: () => UpdateProfileViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) {
        pickPhoto() async {
          try {
            final image =
                await ImagePicker.pickImage(source: ImageSource.gallery);

            File croppedFile = await ImageCropper.cropImage(
              sourcePath: image.path,
              aspectRatioPresets: [
                CropAspectRatioPreset.square,
              ],
              aspectRatio: CropAspectRatio(
                ratioX: 1,
                ratioY: 1,
              ),
              compressFormat: ImageCompressFormat.png,
              maxHeight: 640,
              maxWidth: 640,
              compressQuality: 100,
              cropStyle: CropStyle.rectangle,
              androidUiSettings: AndroidUiSettings(
                toolbarTitle: "Crop",
                toolbarColor: Color(0xff151618),
                activeControlsWidgetColor: primaryColorLight,
                toolbarWidgetColor: Colors.white,
                statusBarColor: Color(0xff151618),
                initAspectRatio: CropAspectRatioPreset.square,
                lockAspectRatio: true,
                backgroundColor: Color(0xff151618),
                dimmedLayerColor: Color(0xff151618),
                cropFrameStrokeWidth: 8,
                cropGridStrokeWidth: 6,
              ),
              iosUiSettings: IOSUiSettings(
                minimumAspectRatio: 1.0,
                aspectRatioLockEnabled: true,
                aspectRatioPickerButtonHidden: true,
                showCancelConfirmationDialog: true,
              ),
            );

            model.setProfilePhoto(croppedFile);
          } catch (e) {}
        }

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
                            pickPhoto();
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
