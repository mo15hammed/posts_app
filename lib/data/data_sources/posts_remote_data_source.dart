import 'package:posts_app/core/constants/api_constants.dart';
import 'package:posts_app/data/core/dio_helper.dart';
import 'package:posts_app/data/models/post_model.dart';

abstract class PostsRemoteDataSource {
  Future<List<PostModel>> getPosts();
  Future<void> deletePost(int postId);
  Future<void> createPost(PostModel post);
  Future<void> updatePost(PostModel post);
}

class PostsRemoteDataSourceImpl implements PostsRemoteDataSource {
  final DioHelper dioHelper;
  const PostsRemoteDataSourceImpl(this.dioHelper);

  @override
  Future<List<PostModel>> getPosts() async {
    final data = await dioHelper.request(
      endpoint: ApiConstants.posts,
      method: Method.get,
    ) as List;
    final posts = data.map<PostModel>((e) => PostModel.fromJson(e)).toList();
    return posts;
  }

  @override
  Future<void> createPost(PostModel post) async {
    // final data = {
    //   'title': post.title,
    //   'body': post.body,
    // };

    await dioHelper.request(
      endpoint: ApiConstants.posts,
      method: Method.post,
      params: post.toJson(),
    );
  }

  @override
  Future<void> updatePost(PostModel post) async {
    final postId = post.id;

    await dioHelper.request(
      endpoint: '${ApiConstants.posts}/$postId',
      method: Method.patch,
      params: post.toJson(),
    );
  }

  @override
  Future<void> deletePost(int postId) async {
    await dioHelper.request(
      endpoint: '${ApiConstants.posts}/$postId',
      method: Method.delete,
    );
  }
}
