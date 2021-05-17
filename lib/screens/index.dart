import 'package:flutter/material.dart';
import 'package:persona/services/fetchpost_service.dart';

class PostDetailPage extends StatefulWidget {
  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Detail'),
      ),
      body: Column(
        children: <Widget>[
          //Future 와의 최신 상호 작용 snapshot 을 기반으로 자체 빌드되는 위젯.
          //FutureBuilder: Future 객체를 처리하기 위한 builder
          FutureBuilder(
            //builder는 fetchPost값의 변화가 발생할 때마다 호출됨
            future: fetchPost(),
            //snapshot은 Future 클래스가 포장하고 있는 객체를 data 속성으로 전달
            //Future 객체를 처리할 빌더.
            builder: (context, snapshot) {
              //정상적으로 데이터가 출력된 경우, 하단 코드 return
              if (snapshot.hasData) {
                final title = snapshot.data.title;
                final body = snapshot.data.body;
                return Column(
                  children: <Widget>[
                    //Post Title
                    Text(
                      title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    //Post Body
                    Text(
                      body,
                      style: Theme.of(context).textTheme.display1,
                    )
                  ],
                );
                //에러 발생시 에러 출력
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              //Future 가 종료되지 않았다면(데이터 수신전) CircularProgressIndicator (로딩표시) 를 출력함
              //https://material.io/components/progress-indicators/#circular-progress-indicators 참고
              return CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
}
