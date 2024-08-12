import 'package:dio/dio.dart';

import 'dio_client.dart';

class ApiService {
  final DioClient dioClient;

  ApiService({required this.dioClient});

  Future<Response> fetchPost(int id) async {
    return await dioClient.get('/posts/$id');
  }

  Future<Response> createPost(Map<String, dynamic> data) async {
    return await dioClient.post('/posts', data: data);
  }
}
