import 'dart:async';

import 'package:andapp/common/bloc_provider.dart';
import 'package:andapp/di/app_component_base.dart';
import 'package:andapp/model/get_profile.dart';
import 'package:andapp/services/api_client.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class MyProfileBloc extends BlocBase {
  StreamController mainStreamController = StreamController.broadcast();
  StreamController<ProfileData?> profileStreamController =
      StreamController<ProfileData?>.broadcast();
  StreamController<PlatformFile?> profilePhotoStreamController =
      StreamController<PlatformFile?>.broadcast();

  Stream get mainStream => mainStreamController.stream;

  Stream<ProfileData?> get profileStream => profileStreamController.stream;

  Stream<PlatformFile?> get profilePhotoStream =>
      profilePhotoStreamController.stream;

  //PlatformFile? profilePhoto;

  Future getProfile(BuildContext context) async {
    await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getProfile(id: "29")
        .then((getProfile) {
      if (getProfile != null &&
          getProfile.resultflag == ApiClient.resultflagSuccess &&
          getProfile.data != null) {
        profileStreamController.sink.add(getProfile.data!.data);
      }
    });
  }

  Future updateProfilePhoto(
      BuildContext context, PlatformFile? profilePhoto) async {
    if (profilePhoto != null) {
      await AppComponentBase.getInstance()
          ?.getApiInterface()
          .getApiRepository()
          .updateProfilePhoto(id: "", profilePhoto: profilePhoto)
          .then((getProfile) {
        if (getProfile != null &&
            getProfile.resultflag == ApiClient.resultflagSuccess &&
            getProfile.data != null) {
          //profileStreamController.sink.add();
        }
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}