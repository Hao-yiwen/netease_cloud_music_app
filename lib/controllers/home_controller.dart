import 'package:get/get.dart';
import 'package:netease_cloud_music_app/api/api_service.dart';

class HomeController extends GetxController{
  final ApiService apiService;

  var posts = [].obs;
  var isLoading = true.obs;

  HomeController({required this.apiService});
}