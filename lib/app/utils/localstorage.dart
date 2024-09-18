import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String language = 'language';
  static const String isDark = 'isDark';

  static late LocalStorageService _instance;
  static late SharedPreferences _preferences;

  static Future<LocalStorageService> get storageInstance async {
    _instance = LocalStorageService();
    _preferences = await SharedPreferences.getInstance();

    return _instance;
  }

  dynamic _getFromDisk(String key) {
    return _preferences.get(key);
  }

  void _saveToDisk<T>(String key, T content) {
    if (content is String) {
      _preferences.setString(key, content);
    }
    if (content is bool) {
      _preferences.setBool(key, content);
    }
    if (content is int) {
      _preferences.setInt(key, content);
    }
    if (content is double) {
      _preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences.setStringList(key, content);
    }
    if (content is Map<String, dynamic>) {
      _preferences.setString(key, json.encode(content));
    }
  }

  /// Retrieves token
  String get getLanguageStorage {
    var value = _getFromDisk(language);
    if (value == null) {
      return "";
    }
    return _getFromDisk(language);
  }

  /// Saves the driver's token ar sign-in.
  set setLanguageStorage(String value) {
    _saveToDisk(language, value);
  }

  /// Clears the localstorage.
  void clear() {
    try {
      _preferences.clear();

      _preferences.getKeys().forEach((element) {
        _preferences.remove(element);
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  bool get getIsDark {
    var value = _getFromDisk(isDark);
    if (value == null) {
      return false;
    }
    return _getFromDisk(isDark);
  }

  set setIsLogged(bool value) {
    _saveToDisk(isDark, value);
  }
}

// Localstorage for media

Future<String> getStoragedirectory() async {
  Directory tempDir = await getApplicationDocumentsDirectory();
  String storagelocation = "${tempDir.path}/storage";
  return storagelocation;
}

Future<File> writeLocalMedia({required int id, required String source}) async {
  File fileimage;
  String dir = await getStoragedirectory();

  String dirwithName =
      "$dir/$id${RegExp(r'\.([a-zA-Z0-9]+)$').firstMatch(source)?[0] ?? ".jpg"}";
  fileimage = File(dirwithName);

  if (fileimage.existsSync()) return fileimage;

  var response = await Dio().get(source,
      options:
          Options(responseType: ResponseType.bytes, followRedirects: false));
  await Directory(dir).create(recursive: true);

  fileimage = await File(dirwithName).create(recursive: true);
  fileimage.writeAsBytes(response.data);
  return fileimage;
}
