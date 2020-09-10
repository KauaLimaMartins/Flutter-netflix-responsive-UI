import 'package:flutter/material.dart';
import 'package:flutter_netflix_responsive_ui/models/models.dart';

class PreviewsWidget extends StatelessWidget {
  PreviewsWidget({
    Key key,
    @required this.title,
    @required this.contentList,
  }) : super(key: key);

  final String title;
  final List<Content> contentList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            this.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: 165,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 8,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: this.contentList.length,
            itemBuilder: (context, index) {
              final Content content = this.contentList[index];

              return Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: content.color,
                        width: 2,
                      ),
                      image: DecorationImage(
                        image: AssetImage(content.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black87,
                          Colors.black45,
                          Colors.transparent,
                        ],
                        stops: [
                          0,
                          0.25,
                          1,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: content.color,
                        width: 2,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: SizedBox(
                      height: 60,
                      child: Image.asset(content.titleImageUrl),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
