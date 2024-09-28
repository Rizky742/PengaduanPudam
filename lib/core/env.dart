import 'package:shared_preferences/shared_preferences.dart';

Future<String> getBaseUrl() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('api_url') ?? 'http://10.0.2.2:3000/api';
}