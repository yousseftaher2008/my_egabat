import 'dart:convert';

import 'package:http/http.dart';

import '../../data/models/student.dart';
import '../constants/base_url.dart';

Future<Student> getStudentProfile(String token) async {
  const url = '${baseUrl}Student/StudentViewProfile';
  final response = await get(Uri.parse(url), headers: {
    "Content-Type": "application/json",
    "Authorization": "Bearer $token",
  });
  final Map<String, dynamic> responseData = json.decode(response.body);
  return Student.fromProfileJson(responseData);
}
