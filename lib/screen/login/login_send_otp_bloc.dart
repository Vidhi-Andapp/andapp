import 'dart:async';

import 'package:andapp/common/bloc_provider.dart';

class LoginSendOTPBloc extends BlocBase {
  StreamController mainStreamController = StreamController.broadcast();
  Stream get mainStream => mainStreamController.stream;

  @override
  void dispose() {}
}
