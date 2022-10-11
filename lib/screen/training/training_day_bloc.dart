import 'package:andapp/common/bloc_provider.dart';
import 'package:andapp/common/common_toast.dart';
import 'package:andapp/common/string_utils.dart';
import 'package:andapp/di/app_component_base.dart';
import 'package:andapp/di/shared_preferences.dart';
import 'package:andapp/screen/training/training_navigator.dart';
import 'package:andapp/services/api_client.dart';
import 'package:flutter/material.dart';

class TrainingDayBloc extends BlocBase {
  Future completeDay(BuildContext context, bool mounted, String trainingType,
      String day) async {
    var pospId = await AppComponentBase.getInstance()
        ?.getSharedPreference()
        .getUserDetail(key: SharedPreference().pospId);
    if (pospId != null) {
      var commonData = await AppComponentBase.getInstance()
          ?.getApiInterface()
          .getApiRepository()
          .completeTrainingDay(
              trainingType: trainingType == StringUtils.generalInsurance
                  ? ApiClient.trainingTypeGI
                  : ApiClient.trainingTypeLI,
              day: day,
              pospId: pospId);
      if (commonData != null &&
          commonData.resultflag == ApiClient.resultflagSuccess &&
          commonData.data != null) {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) {
              return TrainingNavigator(
                day: day,
                title: trainingType,
                  pospId: pospId,
              );
            }),
          );
        }
      } else if (commonData != null && commonData.messages != null) {
        CommonToast.getInstance()
            ?.displayToast(message: commonData.messages ?? "");
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}