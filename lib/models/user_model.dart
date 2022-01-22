class UserModel {
  final String? uid;
  final String? phoneNo;
  final String? profileImg;
  final String? nickname;

  UserModel({
    this.uid,
    this.phoneNo,
    this.profileImg,
    this.nickname,
  });

  factory UserModel.fromMap(Map data) {
    return UserModel(
      uid: data['uid'],
      phoneNo: data['phoneNo'] ?? '',
      profileImg: data['profileImg'] ?? '',
      nickname: data['nickname'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'phoneNo': phoneNo,
      'profileImg': profileImg,
      'nickname': nickname,
    };
  }

  //factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}
