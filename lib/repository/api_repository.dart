import 'package:andapp/services/api_services.dart';

class ApiRepositoryIml extends ApiRepository {
  final ApiServices _apiServices = ApiServices();
  @override
  Future<Map<String, dynamic>> login({String? mobileNo, String? pass}) {
    return _apiServices.login(mobileNo ?? '', pass ?? '');
  }
}

abstract class ApiRepository {
  Future<Map<String, dynamic>> login({String? mobileNo, String? pass});
}
