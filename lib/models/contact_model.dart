class ContactModel {
  final String? uid;
  final String? phoneNo;
  final String? profileImg;
  final String? nickname;
  final DateTime? timestamp;
  final String? text;

  ContactModel({
    this.uid,
    this.phoneNo,
    this.profileImg,
    this.nickname,
    this.timestamp,
    this.text,
  });

  factory ContactModel.fromMap(Map data) {
    return ContactModel(
      uid: data['uid'],
      phoneNo: data['phoneNo'] ?? '',
      profileImg: data['profileImg'] ?? '',
      nickname: data['nickname'] ?? '',
      timestamp: data['timestamp'] ?? '',
      text: data['text'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'phoneNo': phoneNo,
      'profileImg': profileImg,
      'nickname': nickname,
      'timestamp': timestamp,
      'text': text,
    };
  }

  //factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}
