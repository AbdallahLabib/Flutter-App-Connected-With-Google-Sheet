import 'dart:convert';

import 'package:http/http.dart';
import 'package:task/model/live_model.dart';
import 'package:task/model/user_model.dart';

class ApiProvider {
  Client client = Client();
  final _baseUrl = "http://appName.com/api/";

  var headers = {
    'Accept': 'application/json',
    'Authorization': "Bearer ${UserModel.shared.apiToken}"
  };

  Future<Live> startVideo({int categoryId}) async {
    final response = await client.post(
      "$_baseUrl" + "agora/get-agora-token",
      body: {"cat_id": categoryId.toString()},
      headers: headers,
    );
    var body = json.decode(response.body);
    print(body);
    if (response.statusCode == 200) {
      return Live.fromJson(body["live"]);
    } else {
      throw Exception("failed to start video");
    }
  }

  Future<bool> endVideo({int liveId}) async {
    final response = await client.post(
      "$_baseUrl" + "agora/end-live",
      body: {"live_id": liveId.toString()},
      headers: headers,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("failed to end video");
    }
  }

  Future<List<UserModel>> getLiveUsers() async {
    final response = await client.post(
      "$_baseUrl" + "agora/live-users",
      headers: headers,
    );
    var body = json.decode(response.body);
    print(body);
    if (response.statusCode == 200) {
      var user = body["users"];
      return user.isNotEmpty
          ? List<UserModel>.from(
              body["users"].map((user) => UserModel.fromJson(user)))
          : [];
    } else {
      throw Exception("failed to get live users");
    }
  }

  Future<bool> addLiveComment({int liveId, int userId, String content}) async {
    final response = await client.post(
      "$_baseUrl" + "agora/user-live-comment",
      body: {
        "live_id": liveId.toString(),
        "user_id": userId.toString(),
        "content": content
      },
      headers: headers,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("failed to add comment");
    }
  }

  Future<bool> addStickerLiveComment(
      {int liveId,
      int userId,
      String content,
      String mediaUrl,
      int familyBlogId}) async {
    if (content == "") content = "-";
    final response = await client.post(
      "$_baseUrl" + "agora/user-live-comment",
      body: {
        "live_id": liveId.toString(),
        "user_id": userId.toString(),
        "content": content,
        "media_url": mediaUrl,
        "family_blog_id": familyBlogId.toString(),
      },
      headers: headers,
    );
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("failed to add comment");
    }
  }

  Future<bool> joinLive({int liveId, int userId}) async {
    final response = await client.post(
      "$_baseUrl" + "agora/user-joins-live",
      body: {"live_id": liveId.toString(), "user_id": userId.toString()},
      headers: headers,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("failed to join live");
    }
  }

  Future<bool> disconnectLive({int liveId, int userId}) async {
    final response = await client.post(
      "$_baseUrl" + "agora/user-disconnect-live",
      body: {"live_id": liveId.toString(), "user_id": userId.toString()},
      headers: headers,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("failed to disconnect live");
    }
  }

  Future<bool> requestHosting({int liveId, int userId}) async {
    final response = await client.post(
      "$_baseUrl" + "agora/request-hosting",
      body: {
        "live_id": liveId.toString(),
        "user_id": userId.toString(),
      },
      headers: headers,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("failed to request hosting");
    }
  }

  Future<bool> acceptRequestHosting(
      {int liveId, int userId, int isAccepted}) async {
    final response = await client.post(
      "$_baseUrl" + "agora/request-response",
      body: {
        "live_id": liveId.toString(),
        "user_id": userId.toString(),
        "is_accepted": isAccepted.toString(),
      },
      headers: headers,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("failed to response to this request");
    }
  }

  Future<bool> addNewHost({int liveId, int userId}) async {
    final response = await client.post(
      "$_baseUrl" + "agora/add-host",
      body: {
        "live_id": liveId.toString(),
        "new_host_user_id": userId.toString()
      },
      headers: headers,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("failed to add new host");
    }
  }

  Future<bool> acceptNewHost({int liveId, int userId, int isAccepted}) async {
    final response = await client.post(
      "$_baseUrl" + "agora/add-hosting-accept",
      body: {
        "live_id": liveId.toString(),
        "user_id": userId.toString(),
        "is_accepted": isAccepted.toString(),
      },
      headers: headers,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("failed to response to this request");
    }
  }
}
