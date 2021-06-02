import 'package:task/model/live_model.dart';
import 'package:task/model/user_model.dart';
import 'package:task/presisitence/api_provider.dart';

class Repository {
  ApiProvider appApiProvider = ApiProvider();
  
  Future<Live> startVideo({int categoryId}) =>
      appApiProvider.startVideo(categoryId: categoryId);

  Future<bool> endVideo({int liveId}) =>
      appApiProvider.endVideo(liveId: liveId);

  Future<List<UserModel>> getLiveUsers() => appApiProvider.getLiveUsers();

  Future<bool> addLiveComment({int liveId, int userId, String content}) =>
      appApiProvider.addLiveComment(
          liveId: liveId, content: content, userId: userId);

  Future<bool> addStickerLiveComment(
          {int liveId,
          int userId,
          String content,
          String mediaUrl,
          int familyBlogId}) =>
      appApiProvider.addStickerLiveComment(
          liveId: liveId,
          content: content,
          userId: userId,
          mediaUrl: mediaUrl,
          familyBlogId: familyBlogId);

  Future<bool> joinLive({int liveId, int userId}) =>
      appApiProvider.joinLive(liveId: liveId, userId: userId);

  Future<bool> disconnectLive({int liveId, int userId}) =>
      appApiProvider.disconnectLive(liveId: liveId, userId: userId);

  Future<bool> requestHosting({int liveId, int userId}) =>
      appApiProvider.requestHosting(liveId: liveId, userId: userId);

  Future<bool> acceptRequestHosting({int liveId, int userId, int isAccepted}) =>
      appApiProvider.acceptRequestHosting(
          liveId: liveId, userId: userId, isAccepted: isAccepted);

  Future<bool> addNewHost({int liveId, int userId}) =>
      appApiProvider.addNewHost(liveId: liveId, userId: userId);

  Future<bool> acceptNewHost({int liveId, int userId, int isAccepted}) =>
      appApiProvider.acceptNewHost(
          liveId: liveId, userId: userId, isAccepted: isAccepted);
  
  }