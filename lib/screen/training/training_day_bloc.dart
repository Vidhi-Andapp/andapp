import 'package:andapp/common/bloc_provider.dart';
import 'package:andapp/common/common_toast.dart';
import 'package:andapp/common/string_utils.dart';
import 'package:andapp/di/app_component_base.dart';
import 'package:andapp/di/shared_preferences.dart';
import 'package:andapp/screen/training/training_navigator.dart';
import 'package:andapp/services/api_client.dart';
import 'package:flutter/material.dart';

class TrainingDayBloc extends BlocBase {
  void completeDay(BuildContext context, String trainingType, String day) {
    AppComponentBase.getInstance()
        ?.getSharedPreference()
        .getUserDetail(key: SharedPreference().pospId)
        .then((value) => AppComponentBase.getInstance()
                ?.getApiInterface()
                .getApiRepository()
                .completeTrainingDay(
                    trainingType: trainingType == StringUtils.generalInsurance
                        ? ApiClient.trainingTypeGI
                        : ApiClient.trainingTypeLI,
                    day: day,
                    pospId: "73")
                .then((commonData) {
              if (commonData != null &&
                  commonData.resultflag == ApiClient.resultflagSuccess &&
                  commonData.data != null) {
                /* CommonToast.getInstance()
                    ?.displayToast(message: commonData.data ?? "");*/
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return TrainingNavigator(
                      day: day,
                      title: trainingType,
                    );
                  }),
                );
              } else if (commonData != null && commonData.messages != null) {
                CommonToast.getInstance()
                    ?.displayToast(message: commonData.messages ?? "");
              }
            }));
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}