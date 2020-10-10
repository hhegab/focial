import 'package:focial/models/author_data.dart';
import 'package:focial/models/story.dart';
import 'package:json_annotation/json_annotation.dart';

part 'story_feed.g.dart';

@JsonSerializable(nullable: false)
class StoryFeed {
  AuthorData authorData;
  List<Story> stories;

  StoryFeed({this.authorData, this.stories});

  static Map<String, StoryFeed> parseFromJSONAsList(dynamic jsonList) {
    final Map<String, StoryFeed> stories = {};
    for (final storyFeed in jsonList) {
      final s = StoryFeed.fromJson(storyFeed as Map<String, dynamic>);
      stories[s.authorData.id] = s;
    }
    return stories;
  }

  factory StoryFeed.fromJson(Map<String, dynamic> json) => _$StoryFeedFromJson(json);

  Map<String, dynamic> toJson() => _$StoryFeedToJson(this);
}
