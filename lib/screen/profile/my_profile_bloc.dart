import 'dart:async';

import 'package:andapp/common/bloc_provider.dart';
import 'package:andapp/common/common_toast.dart';
import 'package:andapp/common/string_utils.dart';
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

  Future getProfile(BuildContext context, String pospId) async {
    await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getProfile(id: pospId,isProgressBar: true)
        .then((getProfile) {
      if (getProfile != null &&
          getProfile.resultflag == ApiClient.resultflagSuccess &&
          getProfile.data != null) {
        profileStreamController.sink.add(getProfile.data!.data);
      }
    });
  }

  Future updateProfilePhoto(
      BuildContext context, String pospId, PlatformFile? profilePhoto) async {
    if (profilePhoto != null) {
      var updateProfile = await AppComponentBase.getInstance()
          ?.getApiInterface()
          .getApiRepository()
          .updateProfilePhoto(id: pospId, profilePhoto: profilePhoto);
        if (updateProfile != null &&
            updateProfile.resultflag == ApiClient.resultflagSuccess &&
            updateProfile.data != null) {
          CommonToast.getInstance()
              ?.displayToast(message: updateProfile.messages ?? StringUtils.profilePhotoSuccess);
          //profileStreamController.sink.add();
        }
        else {
          CommonToast.getInstance()
              ?.displayToast(message: updateProfile?.messages ?? StringUtils.profilePhotoFail);
          print("else : submitAnswer : ${updateProfile?.messages}");
          //return null;
        }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}