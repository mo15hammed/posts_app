import 'package:hive_flutter/hive_flutter.dart';
import 'package:posts_app/data/models/post_model.dart';
import 'package:posts_app/data/tables/post_table.dart';

abstract class PostsLocalDataSource {
  Future<List<PostTable>> getCachedPosts();
  Future<void> cachePosts(List<PostModel> posts);
}

class PostsLocalDataSourceImpl implements PostsLocalDataSource {
  static const _postsBoxName = 'postsBox';

  PostsLocalDataSourceImpl() {
    Hive.registerAdapter(PostTableAdapter());
  }

  @override
  Future<void> cachePosts(List<PostModel> posts) async {
    var postsBox = await Hive.openBox(_postsBoxName);
    final postTables = posts
        .map<PostTable>((post) => PostTable.fromModel(post))
        .toList()
        .cast<PostTable>();

    postsBox.addAll(postTables);
    // postsBox.put(_cachedPostsKey, postTables);
  }

  @override
  Future<List<PostTable>> getCachedPosts() async {
    var postsBox = await Hive.openBox(_postsBoxName);
    final posts = List<PostTable>.from(postsBox.values);

    return posts;
  }
}
