import 'dart:async';

import 'package:andapp/common/bloc_provider.dart';

class DocumentBloc extends BlocBase {
  StreamController mainStreamController = StreamController.broadcast();
  Stream get mainStream => mainStreamController.stream;

  @override
  void dispose() {}
}
