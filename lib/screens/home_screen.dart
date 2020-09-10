import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_netflix_responsive_ui/cubits/cubits.dart';
import 'package:flutter_netflix_responsive_ui/data/data.dart';
import 'package:flutter_netflix_responsive_ui/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController;

  @override
  void initState() {
    this._scrollController = ScrollController()
      ..addListener(() {
        context.bloc<AppBarCubit>().setOffset(_scrollController.offset);
      });

    super.initState();
  }

  @override
  void dispose() {
    this._scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: _fab(),
      appBar: _appBar(size),
      body: CustomScrollView(
        controller: this._scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: ContentHeader(
              featuredContent: sintelContent,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: 20),
            sliver: SliverToBoxAdapter(
              child: PreviewsWidget(
                key: PageStorageKey('previewsWidget'),
                title: 'Previews',
                contentList: previews,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ContentListWidget(
              key: PageStorageKey('myListWidget'),
              title: 'Minha Lista',
              contentList: myList,
            ),
          ),
          SliverToBoxAdapter(
            child: ContentListWidget(
              key: PageStorageKey('originalsWidget'),
              title: 'Originais Netflix',
              contentList: originals,
              isOriginals: true,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(bottom: 20),
            sliver: SliverToBoxAdapter(
              child: ContentListWidget(
                key: PageStorageKey('trendingWidget'),
                title: 'Tendências',
                contentList: trending,
              ),
            ),
          ),
        ],
      ),
    );
  }

  FloatingActionButton _fab() {
    return FloatingActionButton(
      backgroundColor: Colors.grey[850],
      child: Icon(Icons.cast),
      onPressed: () {},
    );
  }

  PreferredSize _appBar(Size size) {
    return PreferredSize(
      preferredSize: Size(size.width, 50),
      child: BlocBuilder<AppBarCubit, double>(
        builder: (context, scrollOffset) {
          return CustomAppBarWidget(
            scrollOffset: scrollOffset,
          );
        },
      ),
    );
  }
}
