import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

@RoutePage()
class Roaming extends GetView<Roaming> {
  const Roaming({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Roaming'),
    );
  }

}