class Post {
  String userId;
  String firstname;
  String lastname;
  String content;
  String data;

  Post(String userId,String firstname, String content,String lastname,String data) {
    this.userId = userId;
    this.firstname = firstname;
    this.lastname = lastname;
    this.data = data;
    this.content = content;
  }
  Post.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        firstname = json['firstname'],
        lastname = json['lastname'],
        data = json['data'],
        content = json['content'];

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'firstname': firstname,
    'lastname': lastname,
    'data': data,
    'content': content,
  };
}