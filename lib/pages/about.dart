import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music_app/common/utils/image_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/linking_text.dart';

@RoutePage()
class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  String _appVersion = "";

  @override
  void initState() {
    super.initState();
    _loadAppVersion();
  }

  @override
  Widget build(BuildContext context) {
    var _listTop = [
      AboutItem(text: "当前版本", trailing: Text(_appVersion ?? "")),
      AboutItem(
          text: "新版更新",
          badge: "",
          onTap: () {
            _launchURL();
          }),
    ];

    var _listContent = [
      AboutItem(text: "专栏菜单", badge: "99"),
      AboutItem(text: "联系我们", badge: ""),
      AboutItem(text: "给软件评分", badge: ""),
    ];

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "关于网易云音乐",
            style: TextStyle(fontSize: 35.w, fontWeight: FontWeight.w500),
          ),
        ),
        body: Container(
          color: Color(0xffF5F5F5),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                    child: ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 100.w, bottom: 60.w),
                      alignment: Alignment.center,
                      child: Image.asset(
                        ImageUtils.getImagePath('ic_launcher'),
                        width: 200.w,
                        height: 200.w,
                      ),
                    ),
                    _buildCardContent(list: _listTop),
                    SizedBox(
                      height: 20.w,
                    ),
                    _buildCardContent(list: _listContent),
                    SizedBox(
                      height: 50.w,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
                      child: Text(
                        "使用网易云音乐网页版、电脑客户端、手机客户端，强大的多端同步，音乐随身听！请访问：music.163.com",
                        style: TextStyle(
                            fontSize: 20.w,
                            height: 1.5,
                            letterSpacing: 1.w,
                            color: Colors.grey[600]),
                        maxLines: 3,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                )),
                _buildAboutBottom()
              ],
            ),
          ),
        ));
  }

  Widget _buildListItem(BuildContext context,
      {required String text,
      Widget? trailing,
      Function()? onTap,
      String? badge}) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Row(
          children: [
            SizedBox(width: 15.w),
            Text(text,
                style: TextStyle(
                    fontSize: 28.w,
                    color: Colors.black,
                    fontWeight: FontWeight.w200)),
            Spacer(),
            trailing != null
                ? Row(
                    children: [
                      trailing,
                      SizedBox(
                        width: 10.w,
                      )
                    ],
                  )
                : (badge != null && badge != ''
                    ? Row(
                        children: [
                          _buildBadge(badge as String),
                          SizedBox(
                            width: 10.w,
                          ),
                          Icon(Icons.chevron_right, color: Colors.grey[300])
                        ],
                      )
                    : Icon(Icons.chevron_right, color: Colors.grey[300])),
            SizedBox(width: 10.w),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, color: Colors.grey[100]);
  }

  Widget _buildBadge(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.w),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(30.w),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.sp,
        ),
      ),
    );
  }

  _buildCardContent({required List<AboutItem> list}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 20.w),
        child: Column(
          children: [
            ...list.map((item) {
              return Column(children: [
                _buildListItem(context,
                    text: item.text,
                    trailing: item.trailing,
                    onTap: item.onTap,
                    badge: item.badge),
                if (list.indexOf(item) != list.length - 1) _buildDivider(),
              ]);
            })
          ],
        ),
      ),
    );
  }

  Future<void> _loadAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = packageInfo.version;
    });
  }

  _buildAboutBottom() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinkingText('版权说明', () {}),
            SizedBox(
              width: 20.w,
            ),
            LinkingText('社区管理', () {}),
            SizedBox(
              width: 20.w,
            ),
            LinkingText('服务条款', () {}),
            SizedBox(
              width: 20.w,
            ),
            LinkingText('算法备案', () {})
          ],
        ),
        SizedBox(
          height: 15.w,
        ),
        Text(
          'ICP备案号: 浙ICP备 15006616号-14A >',
          style: TextStyle(fontSize: 20.w, color: Colors.grey[600]),
        )
      ],
    );
  }

  void _launchURL() async {
    var url = Uri.parse(
        'https://apps.apple.com/cn/app/网易云音乐-畅听我们的歌/id590338362');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class AboutItem {
  final IconData? icon;
  final String text;
  final String? badge;
  final Function()? onTap;
  final String? title;
  final Widget? trailing;

  AboutItem({
    this.icon,
    required this.text,
    this.badge,
    this.onTap,
    this.title,
    this.trailing,
  });
}
