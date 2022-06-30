
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference extends SharedPreferenceRepository {
  /*final String _userDetails = 'user_details';
  final String? _theme = 'theme';*/
  SharedPreferences? _pref;

  @override
  Future getUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('stringValue');
    return stringValue;
  }

  @override
  Future<bool?> clearData() async {
    _pref = await initPreference();
    _pref?.clear();
    return true;
  }

  Future<SharedPreferences> initPreference() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future setUserDetail() async {

  }
/*

  Future saveTheme() async{
    SharedPreferences pref = await _prefs;
    pref.setBool('theme', _light);
  }

  getTheme() async{
    var _lightF = _pref.then((SharedPreferences prefs) {
      return prefs.getBool('theme') ?? true;
    });
    _theme = await _lightF;
  }
*/

}

abstract class SharedPreferenceRepository {
  Future getUserDetail();

  Future setUserDetail();

  Future<bool?> clearData();

}
