import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  static final shared = UserModel(
    apiToken: null,
    id: 0,
    name: '',
    email: '',
    photo: '',
    phone: "",
    whatsApp: "",
    countryId: "0",
    countryName: "",
    countryFlag: "",
    favourite: 0,
    isOnline: true,
  );

  String apiToken;
  int id;
  String name;
  String email;
  String website;
  String photo;
  String countryId;
  String countryName;
  String countryFlag;
  String phone;
  String whatsApp;
  String bio;
  List<UserModel> followers;
  List<UserModel> following;
  int favourite;
  bool isOnline;
  bool isFollow = false;
  bool isPrivate = false;
  String lastOnline = "";
  String followStatus = "";

  UserModel({
    this.apiToken,
    this.id,
    this.name = "User Name",
    this.email,
    this.photo = "",
    this.countryId = "0",
    this.countryName = "",
    this.countryFlag = "",
    this.phone = "",
    this.whatsApp = "",
    this.bio = "",
    this.followers,
    this.following,
    this.favourite = 0,
    this.isOnline = false,
    this.isFollow = false,
    this.isPrivate = false,
    this.lastOnline = "",
    this.followStatus = "",
    this.website,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      id: json['id'] ?? 0,
      email: json['email'] ?? "",
      website: json['website'] ?? "",
      photo: json['photo'] ?? "",
      phone: json['phone'] ?? "",
      whatsApp: json['whatsapp'] ?? "",
      bio: json['bio'] ?? "",
      countryId: json['country_id'].toString() ?? "0",
      countryName: json['country_name'].toString() ?? "",
      countryFlag: json['flag_url'].toString() ?? "",
      isOnline: json['is_online'] ?? false,
      isPrivate: json['is_private'] == 1 ? true : false,
      isFollow: json['is_followed_by_me'] ?? false,
      lastOnline: json['last_activity'] ?? "",
      followStatus: json['follow_status'] ?? "",
      favourite: json['saved_media_count'] ?? 0,
    );
  }

  Map toJson() {
    return {
      'id': this.id ?? 0,
      'name': this.name ?? "",
      'email': this.email ?? "",
      'photo': this.photo ?? "",
      'phone': this.phone ?? "",
      'is_online': this.isOnline ?? false,
      'whatsApp': this.whatsApp ?? "",
    };
  }

  factory UserModel.init() {
    UserModel.shared.getUserData();
    return UserModel.shared;
  }

  Future<void> getUserData() async {
    final prefs = await SharedPreferences.getInstance();

    apiToken = prefs.getString('apiToken');
    id = prefs.getInt('id');
    name = prefs.getString('name');
    phone = prefs.getString('phone');
    whatsApp = prefs.getString('whatsApp');
    email = prefs.getString('email');
    photo = prefs.getString('photo');
    countryId = prefs.getString('country_id');
    countryName = prefs.getString('country_name');
    countryFlag = prefs.getString('country_flag');
  }

  Future<void> saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('apiToken', apiToken);
    prefs.setInt('id', id);
    prefs.setString('name', name);
    prefs.setString('email', email);
    prefs.setString('photo', photo);
    prefs.setString('phone', phone);
    prefs.setString('whatsApp', whatsApp);
    prefs.setString('country_id', countryId);
    prefs.setString('country_name', countryName);
    prefs.setString('country_flag', countryFlag);
  }

  Future<void> deleteUserData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("apiToken");
    prefs.remove("id");
    prefs.remove("name");
    prefs.remove("phone");
    prefs.remove("whatsApp");
    prefs.remove("email");
    prefs.remove("photo");
    prefs.remove("country_id");
    prefs.remove("country_name");
    prefs.remove("country_flag");
  }
}
