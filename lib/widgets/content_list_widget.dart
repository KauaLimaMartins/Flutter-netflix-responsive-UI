import 'package:flutter/material.dart';
import 'package:flutter_netflix_responsive_ui/models/models.dart';

class ContentListWidget extends StatelessWidget {
  ContentListWidget({
    Key key,
    @required this.title,
    @required this.contentList,
    this.isOriginals = false,
  }) : super(key: key);

  final String title;
  final List<Content> contentList;
  final bool isOriginals;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              this.title,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: isOriginals ? 550 : 220,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: this.contentList.length,
              itemBuilder: (context, index) {
                final Content content = this.contentList[index];

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  height: this.isOriginals ? 400 : 200,
                  width: this.isOriginals ? 200 : 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(content.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
