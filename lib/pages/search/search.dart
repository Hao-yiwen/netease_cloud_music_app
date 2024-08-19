import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

@RoutePage()
class Search extends GetView<SearchController> {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Search'),
    );
  }
}
