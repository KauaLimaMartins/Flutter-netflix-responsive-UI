import 'package:flutter/material.dart';
import 'package:flutter_netflix_responsive_ui/models/content_model.dart';
import 'package:flutter_netflix_responsive_ui/widgets/widgets.dart';
import 'package:video_player/video_player.dart';

class ContentHeader extends StatelessWidget {
  ContentHeader({
    Key key,
    @required this.featuredContent,
  }) : super(key: key);

  final Content featuredContent;

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: _MobileContentHeader(
        featuredContent: this.featuredContent,
      ),
      desktop: _DesktopContentHeader(
        featuredContent: this.featuredContent,
      ),
    );
  }
}

class _MobileContentHeader extends StatelessWidget {
  _MobileContentHeader({
    @required this.featuredContent,
  });

  final Content featuredContent;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 500,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(this.featuredContent.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 500,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black,
                Colors.transparent,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        Positioned(
          bottom: 110,
          child: SizedBox(
            width: 250,
            child: Image.asset(
              this.featuredContent.titleImageUrl,
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 44,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              VerticalIconButton(
                icon: Icons.add,
                title: 'Lista',
                onTap: () {},
              ),
              _PlayButton(),
              VerticalIconButton(
                icon: Icons.info_outline,
                title: 'Info',
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DesktopContentHeader extends StatefulWidget {
  _DesktopContentHeader({
    @required this.featuredContent,
  });

  final Content featuredContent;

  @override
  __DesktopContentHeaderState createState() => __DesktopContentHeaderState();
}

class __DesktopContentHeaderState extends State<_DesktopContentHeader> {
  VideoPlayerController _videoController;
  bool _isMuted = true;

  @override
  void initState() {
    super.initState();

    this._videoController =
        VideoPlayerController.network(widget.featuredContent.videoUrl)
          ..initialize().then((_) {
            setState(() {});
          })
          ..setVolume(0)
          ..play();
  }

  @override
  void dispose() {
    this._videoController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (this._videoController.value.isPlaying) {
          this._videoController.pause();
        } else {
          this._videoController.play();
        }
      },
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          AspectRatio(
            aspectRatio: this._videoController.value.initialized
                ? this._videoController.value.aspectRatio
                : 2.344,
            child: this._videoController.value.initialized
                ? VideoPlayer(this._videoController)
                : Image.asset(
                    widget.featuredContent.imageUrl,
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: -1.0,
            child: AspectRatio(
              aspectRatio: this._videoController.value.initialized
                  ? this._videoController.value.aspectRatio
                  : 2.344,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black,
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 60,
            right: 60,
            bottom: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250,
                  child: Image.asset(widget.featuredContent.titleImageUrl),
                ),
                SizedBox(height: 15),
                Text(
                  widget.featuredContent.description,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(2, 4),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    _PlayButton(),
                    SizedBox(width: 16),
                    FlatButton.icon(
                      onPressed: () {},
                      padding: EdgeInsets.fromLTRB(25, 10, 30, 10),
                      icon: Icon(
                        Icons.info_outline,
                        size: 30,
                      ),
                      color: Colors.white,
                      label: Text(
                        'Mais Informações',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    if (this._videoController.value.initialized)
                      IconButton(
                        icon: AnimatedSwitcher(
                          duration: Duration(seconds: 1),
                          child: Icon(
                            this._isMuted ? Icons.volume_off : Icons.volume_up,
                          ),
                        ),
                        color: Colors.white,
                        iconSize: 30,
                        onPressed: () => setState(() {
                          this._isMuted
                              ? this._videoController.setVolume(100)
                              : this._videoController.setVolume(0);

                          this._isMuted =
                              this._videoController.value.volume == 0;
                        }),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      onPressed: () {},
      padding: !ResponsiveWidget.isDesktop(context)
          ? EdgeInsets.fromLTRB(15, 5, 20, 5)
          : EdgeInsets.fromLTRB(25, 10, 30, 10),
      color: Colors.white,
      icon: Icon(
        Icons.play_arrow,
        size: 30,
      ),
      label: Text(
        'Assistir',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
