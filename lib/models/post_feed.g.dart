// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostFeed _$PostFeedFromJson(Map<String, dynamic> json) {
  return PostFeed(
    id: json['_id'].toString(),
    type: json['type'] as int,
    authorData: AuthorData.fromJson(json['user'] as Map<String, dynamic>),
    caption: json['caption'].toString(),
    images: (json['images'] as List).map((e) => e.toString()).toList(),
    likes: json['likes'] as int,
    liked: json['liked'] as bool,
    likedBy: (json['likedBy'] as List).map((e) => e.toString()).toList(),
  );
}

Map<String, dynamic> _$PostFeedToJson(PostFeed instance) => <String, dynamic>{
      '_id': instance.id,
      'type': instance.type,
      'user': instance.authorData,
      'caption': instance.caption,
      'images': instance.images,
      'likes': instance.likes,
      'liked': instance.liked,
      'likedBy': instance.likedBy,
    };
