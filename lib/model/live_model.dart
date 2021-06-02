class Live {
  final int id;
  final String token;
  final String channelId;
  final int userId;
  // final String categoryId;

  const Live({this.id,this.channelId,this.token,this.userId});

  factory Live.fromJson(Map<String, dynamic> json) => Live(
    id: json['id'] ?? 0,
    token: json['token'] ?? "",
    channelId: json['channel_name'] ?? "",
    userId: json['user_id'] ?? "",
    // categoryId: json['cat_id'] ?? 0,
  );
}
