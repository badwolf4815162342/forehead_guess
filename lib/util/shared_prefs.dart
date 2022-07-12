import 'package:forehead_guess/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _sharedPrefs;

  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();

  static Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  bool get debug =>
      _sharedPrefs?.getBool(Constant.debugString) ?? Constant.debugInitialValue;
  bool get accel =>
      _sharedPrefs?.getBool(Constant.accelString) ?? Constant.accelInitialValue;
  int get resultWaitSeconds =>
      _sharedPrefs?.getInt(Constant.resultWaitSecondsString) ??
      Constant.resultWaitSecondsInitialValue;
  int get timerDurationInSeconds =>
      _sharedPrefs?.getInt(Constant.timerDurationInSecondsString) ??
      Constant.timerDurationInSecondsInitialValue;
  int get resultWaitSecondsRoll =>
      _sharedPrefs?.getInt(Constant.resultWaitSecondsRollString) ??
      Constant.resultWaitSecondsRollInitialValue;
  int get gyroscopeSensitivity =>
      _sharedPrefs?.getInt(Constant.gyroscopeSensitivityString) ??
      Constant.gyroscopeSensitivityInitialValue;
  int get accelSensitivity =>
      _sharedPrefs?.getInt(Constant.accelSensitivityString) ??
      Constant.accelSensitivityInitialValue;

  set debug(bool value) {
    _sharedPrefs?.setBool(Constant.debugString, value);
  }

  set accel(bool value) {
    _sharedPrefs?.setBool(Constant.accelString, value);
  }

  set resultWaitSeconds(int value) {
    _sharedPrefs?.setInt(Constant.resultWaitSecondsString, value);
  }

  set timerDurationInSeconds(int value) {
    _sharedPrefs?.setInt(Constant.timerDurationInSecondsString, value);
  }

  set resultWaitSecondsRoll(int value) {
    _sharedPrefs?.setInt(Constant.resultWaitSecondsRollString, value);
  }

  set gyroscopeSensitivity(int value) {
    _sharedPrefs?.setInt(Constant.gyroscopeSensitivityString, value);
  }

  set accelSensitivity(int value) {
    _sharedPrefs?.setInt(Constant.accelSensitivityString, value);
  }
}

final sharedPrefs = SharedPrefs();
