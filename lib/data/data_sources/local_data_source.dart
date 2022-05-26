import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:posts_app/core/constants/strings.dart';
import 'package:posts_app/core/error/exceptions.dart';
import 'package:posts_app/data/models/post_model.dart';
import 'package:posts_app/data/tables/post_table.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Future<List<PostTable>> getCachedPosts();

  Future<void> cachePosts(List<PostModel> posts);
}

class LocalDataSourceImplWithHive implements LocalDataSource {
  static const _postsBoxName = 'postsBox';

  LocalDataSourceImplWithHive() {
    Hive.registerAdapter(PostTableAdapter());
  }

  @override
  Future<void> cachePosts(List<PostModel> posts) async {
    var postsBox = await Hive.openBox(_postsBoxName);
    final postTables =
        posts.map<PostTable>((post) => PostTable.fromModel(post)).toList();

    postsBox.addAll(postTables);
    // postsBox.put(_cachedPostsKey, postTables);
  }

  @override
  Future<List<PostTable>> getCachedPosts() async {
    var postsBox = await Hive.openBox(_postsBoxName);
    final posts = List<PostTable>.from(postsBox.values);

    if (posts.isEmpty) {
      throw const EmptyCacheException(Strings.noCachedData);
    }

    return posts;
  }
}

class LocalDataSourceWithSharedPref implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceWithSharedPref(this.sharedPreferences);

  static const _cachePostsKey = 'postsCacheKey';

  @override
  Future<void> cachePosts(List<PostModel> posts) async {
    final postModelJson = posts
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();

    await sharedPreferences.setString(
        _cachePostsKey, json.encode(postModelJson));
  }

  @override
  Future<List<PostTable>> getCachedPosts() async {
    final postsJsonString = sharedPreferences.getString(_cachePostsKey);
    if (postsJsonString != null) {
      List decodedJsonData = json.decode(postsJsonString) as List;
      final jsonToPosts = decodedJsonData
          .map<PostTable>((postJson) => PostTable.fromJson(postJson))
          .toList();
      return jsonToPosts;
    } else {
      throw const EmptyCacheException(Strings.noCachedData);
    }
  }
}
