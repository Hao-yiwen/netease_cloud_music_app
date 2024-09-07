import 'package:auto_route/annotations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:netease_cloud_music_app/pages/home/home_controller.dart';
import 'package:netease_cloud_music_app/widgets/songs_list_widget.dart';
import 'package:netease_cloud_music_app/widgets/songs_small_cards.dart';

import '../../widgets/custom_tag.dart';
import '../../widgets/uncustom_tag.dart';

@RoutePage()
class Found extends StatefulWidget {
  const Found({super.key});

  @override
  State<Found> createState() => _FoundState();
}

class _FoundState extends State<Found> with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  int _currentCarouselIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          _buildHeader(context),
          _buildPageView(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      height: 70.w,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: (){
                HomeController.to.scaffoldKey.value.currentState!.openDrawer();
              },
              child: Icon(
                TablerIcons.menu_2,
                size: 40.w,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              // 明确设置SingleChildScrollView的高度
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: 300,
                  child: TabBar(
                    controller: _tabController,
                    dividerHeight: 0,
                    labelPadding: EdgeInsets.zero,
                    tabs: [
                      Tab(text: '音乐'),
                      Tab(text: '博客'),
                      Tab(text: '直播'),
                      Tab(text: '听书'),
                      Tab(text: '派对'),
                    ],
                    labelStyle: TextStyle(
                      fontSize: 32.sp, // 选中的字体大小
                      fontWeight: FontWeight.normal, // 选中的字体加粗
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontSize: 32.sp, // 未选中的字体大小
                      fontWeight: FontWeight.normal, // 未选中的字体常规
                    ),
                    labelColor: Colors.black,
                    unselectedLabelColor: Color.fromARGB(255, 145, 150, 162),
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                      insets: EdgeInsets.symmetric(horizontal: 22), // 控制指示器的宽度
                    ),
                    onTap: (index) {
                      _pageViewController.animateToPage(index,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease);
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              TablerIcons.search,
              size: 40.w,
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPageView(BuildContext context) {
    return Expanded(
      child: PageView(
        controller: _pageViewController,
        onPageChanged: (index) {
          _tabController.animateTo(index);
          setState(() {
            _currentPageIndex = index;
          });
        },
        children: [
          _buildMusicFound(context),
          Container(
            child: Center(
              child: Text('Roaming'),
            ),
          ),
          Container(
            child: Center(
              child: Text('Timeline'),
            ),
          ),
          Container(
            child: Center(
              child: Text('Timeline'),
            ),
          ),
          Container(
            child: Center(
              child: Text('Timeline'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFixTag(BuildContext context) {
    return Container(
      height: 70.w,
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CustomTag(label: '推荐'),
                SizedBox(
                  width: 10,
                ),
                UncustomTag(label: '歌单'),
                SizedBox(
                  width: 10,
                ),
                UncustomTag(label: '排行榜'),
                SizedBox(
                  width: 10,
                ),
                UncustomTag(label: '电台'),
                SizedBox(
                  width: 10,
                ),
                UncustomTag(label: '直播'),
                SizedBox(
                  width: 10,
                ),
                UncustomTag(label: '数字专辑'),
                SizedBox(
                  width: 10,
                ),
                UncustomTag(label: '歌手'),
                SizedBox(
                  width: 10,
                ),
                UncustomTag(label: '新碟上架'),
                SizedBox(
                  width: 10,
                ),
                UncustomTag(label: 'MV'),
                SizedBox(
                  width: 10,
                ),
                UncustomTag(label: '歌手'),
                SizedBox(
                  width: 10,
                ),
                UncustomTag(label: '新碟上架'),
                SizedBox(
                  width: 10,
                ),
                UncustomTag(label: 'MV'),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          )),
          SizedBox(
            width: 10,
          ),
          Icon(
            TablerIcons.chevron_down,
            size: 30.w,
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
    );
  }

  Widget _buildMusicFound(BuildContext context) {
    return Column(
      children: [
        _buildFixTag(context),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomScrollView(
              slivers: [
                _buildCarousel(context),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text('甄选歌单',
                        style: TextStyle(
                            fontSize: 30.sp, fontWeight: FontWeight.bold)),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SongsSmallCards(),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text('新歌新碟',
                        style: TextStyle(
                            fontSize: 30.sp, fontWeight: FontWeight.bold)),
                  ),
                ),
                SliverToBoxAdapter(
                  // child: SongsListWidget(),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text('排行榜',
                        style: TextStyle(
                            fontSize: 30.sp, fontWeight: FontWeight.bold)),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SongsSmallCards(),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text('数字专辑',
                        style: TextStyle(
                            fontSize: 30.sp, fontWeight: FontWeight.bold)),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SongsSmallCards(),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text('祝你好梦',
                        style: TextStyle(
                            fontSize: 30.sp, fontWeight: FontWeight.bold)),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SongsSmallCards(),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text('云村出品',
                        style: TextStyle(
                            fontSize: 30.sp, fontWeight: FontWeight.bold)),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        // 生成10个card
                        for (int i = 0; i < 10; i++)
                          Card(
                            child: Container(
                              width: 200,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 60,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  _buildCarousel(BuildContext context) {
    return SliverToBoxAdapter(
        child: CarouselSlider(
      carouselController: _controller,
      options: CarouselOptions(
          height: 150.0,
          viewportFraction: 1.0,
          onPageChanged: (index, reason) {
            setState(() {
              _currentCarouselIndex = index;
            });
          }),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: ScreenUtil().screenWidth,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 2, left: 4),
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          child: DotsIndicator(
                            dotsCount: 5,
                            position: _currentCarouselIndex,
                            decorator: DotsDecorator(
                              activeColor: Colors.red,
                              size: const Size.square(6.0),
                              activeSize: const Size.square(6.0),
                              activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
          },
        );
      }).toList(),
    ));
  }
}
