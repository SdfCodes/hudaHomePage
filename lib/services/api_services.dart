import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:huda_home_page/models/course.dart';

Future<List<Course>> fetchCourses() async {
  final response = await http.get(Uri.parse(''));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Course.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load courses');
  }
}
