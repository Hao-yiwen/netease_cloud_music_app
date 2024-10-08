import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../widgets/bottom_player_bar.dart';

@RoutePage()
class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      appBar: AppBar(
        title: Text('Message'),
      ),
      body: Stack(
        children: [
          _buildContent(),
          Positioned(
              bottom: 0,
              left: 0, // 确保有约束条件
              right: 0, //
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Padding(
                  padding: EdgeInsets.only(bottom: bottomPadding),
                  child: BottomPlayerBar(),
                ),
              ))
        ],
      ),
    );
  }


  _buildContent() {
    return Container(
      child: Center(
        child: Text('Message'),
      ),
    );
  }
}