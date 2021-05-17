//Service: fetchPost
//Http 요청 메시지를 전송하고 그 응답을 수신하기 위해 Post 타입의 Future 인스턴스를 반환하는 메소드 fetchPost를 async 로 선언하고 있다.
//Future<T> 를 리턴 타입으로 설정하여 Future가 필요한 메소드 등에서 사용할 수 있음
//여기서 <T> 는 return 될 타입을 넣어준다. (값을 반환하지 않으면 Future<void>)
//Future 객체는 일정 소요시간 이후에 값이나 에러를 반환한다.
//함수 본문 앞에 async 키워드가 있어야 await 키워드를 쓸 수 있다.
//비동기 관련 https://dart.dev/codelabs/async-await 문서 필독하자.
//json 서버로부터 사용자 데이터 중에서 첫 번째 데이터 1개만 가져온다.
import 'dart:convert';

import 'package:persona/models/post_model.dart';
import 'package:http/http.dart' as http;

Future<Post> fetchPost() async {
  //첫 번째를 가져오기 때문에 주소 마지막에 '1'이 붙어있다.
  //http 프로토콜의 get 방식으로 데이터를 가져온다.
  //get은 가져온다는 뜻이 아니라 어떤 방식으로 데이터를 가져올지를 알려주는 방식(method)을 의미한다.

  final url = 'https://jsonplaceholder.typicode.com/posts/1';

  //해당 URL의 데이터를 수신.
  //await 처리: 응답 메시지가 도착하거나 타임아웃이 발생할 때까지 대기
  final response = await http.get(url);

  //응답이 성공하면 json.decode 로 응답의 body를 JSON 으로 만들고
  //Post 클래스에서 만든 fromJson 메소드로 초기화한다.
  if (response.statusCode == 200) {
    //수신 메시지의 body부분을 JSON 객체로 디코딩한후 Post.fromJson 메소드를 통해 다시 파싱함
    //json 데이터를 수신해서 Post 객체로 변환

    final jsonBody = json.decode(response.body);
    return Post.fromJson(jsonBody);
    //200 ok 가 아니라면, 실제 상황에서는 데이터 수신에 실패했을 때의 처리를 제공해야 한다.
    //다시 읽어야 한다던가 빈 데이터 또는 에러를 표시한다던가.
  } else {
    //데이터 수신에 실패했을 경우, throw Exception : 사용자 정의 예외를 던진다.
    throw Exception('Failed to load post');
  }
}
