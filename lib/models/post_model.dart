//Model: Post
class Post {
  //멤버변수 지정하면 자동 초기화
  final int userId;
  final int id;
  final String title;
  final String body;

  //생성자
  Post({this.userId, this.id, this.title, this.body});

  //factory는 클래스 함수로 생성자를 만들 때 사용하는 키워드. (Post 정보를 포함하는 인스턴스를 생성하여 반환하는 factory 생성자)
  //factory란 개발자가 임의로 클래스의 인스턴스를 생성해서 이용하는 패턴이 아닌, 인스턴스를 대신 생성해서 반환해주는 패턴 기법이다.
  //factory 생성자를 이용해 JSON 객체를 초기화 할 수 있도록 factory Post.fromJson 메소드 추가
  //아규먼트로 넘겨 받은 JSON 데이터를 새로운 Post 클래스의 인스턴스로 생성하여 반환한다.
  //전역 함수처럼 동작하기 때문에 this 키워드를 사용할 수 없다.
  factory Post.fromJson(Map<String, dynamic> json) {
    //여기서 Post는 우편(수신 메시지)이라는 뜻으로 명명한 것이지 Http 프로토콜의 Post 방식을 의미하는 것은 아니다.
    //실제 앱에서는 Post 방식이 아닌 Get 방식으로 데이터를 수신하고 있다.
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
