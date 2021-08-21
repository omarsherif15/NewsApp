import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/cubit/cubit.dart';
import 'package:news/modules/webviewScreen.dart';

Widget articleItem (model,context) {
  return GestureDetector(
    onTap: ()
    {
      navigateTo(context, WebViewScreen(
        url: model['url'],
        name: model['source']['name'],
      ));
    },
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children:
        [
          Container(
            height:120,
            width: 120,
            child:
            Image.network('${model['urlToImage']}',fit: BoxFit.cover,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15)),
            clipBehavior: Clip.antiAlias,
          ),
          separator (10,0),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Expanded(
                    child: Text(
                      '${model['title']}',
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${model['publishedAt']}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey),),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
void navigateTo(context,Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

Widget separator (double wide,double high){
  return SizedBox(width: wide,height: high,);
}