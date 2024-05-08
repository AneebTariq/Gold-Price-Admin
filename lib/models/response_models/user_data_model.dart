class UserPersistenceData {

  String? number;
  String? accessToken;
  String? uid;

  UserPersistenceData({
    this.accessToken,
    this.number,
    this.uid,
  });
  UserPersistenceData.defaultData():
        number='',
        uid='',
        accessToken='';

  UserPersistenceData.fromJson(Map<String, dynamic> json)
  {
    accessToken = json['accessToken'];
    number = json['number'];
    uid=json['uid'];
    }
  Map<String, dynamic> toJson() => {
    'accessToken': accessToken,
    'number': number,
    'uid':uid,
  };
}
