import 'package:flutter/material.dart';
import 'package:new_app/modules/web_view/web_view_screen.dart';
import 'package:new_app/shared/widgets/separated_builder.dart';

Widget buildArticleItem(article, context) {
  return InkWell(
    onTap: () {
      navigateTo(
          context,
          WebViewScreen(
            article['url'],
          ));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10.0,
              ),
              image: article['urlToImage'] != null
                  ? DecorationImage(
                      image: NetworkImage(article['urlToImage']),
                      fit: BoxFit.cover,
                    )
                  : DecorationImage(
                      image: NetworkImage(
                          'https://flutter.io/images/catalog-widget-placeholder.png'),
                    ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Container(
              height: 120.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

NetworkImage getImage(dynamic article) {
  NetworkImage _image;
  try {
    _image = NetworkImage(
      '${article['urlToImage']}'.isNotEmpty
          ? '${article['urlToImage']}'
          : FlutterLogo() as String,
    );
  } catch (e) {
    // debugPrint(e); // to see what the error was
    _image = NetworkImage("some default URI");
  }
  return _image;
}

// Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
//       condition: list.length > 0,
//       builder: (context) => ListView.separated(
//         physics: BouncingScrollPhysics(),
//         itemBuilder: (context, index) => buildArticleItem(list[index], context),
//         separatorBuilder: (context, index) => AppDivider(),
//         itemCount: list.length,
//       ),
//       fallback: (context) => isSearch
//           ? Container()
//           : Center(
//               child: CircularProgressIndicator(),
//             ),
//     );

Widget articleBuilder(list, context, {isSearch = false}) {
  return list.length > 0
      ? ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildArticleItem(list[index], context),
          separatorBuilder: (context, index) => AppDivider(),
          itemCount: list.length,
        )
      : isSearch
          ? Container()
          : Center(child: CircularProgressIndicator());
}

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );