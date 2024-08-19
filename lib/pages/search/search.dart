import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Search extends GetView<SearchController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Center(
        child: Text('Search is working'),
      ),
    );
  }
}
