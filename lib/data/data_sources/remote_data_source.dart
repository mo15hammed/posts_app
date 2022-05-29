import 'package:posts_app/core/constants/api_constants.dart';
import 'package:posts_app/data/core/dio_helper.dart';
import 'package:posts_app/data/models/post_model.dart';

abstract class RemoteDataSource {
  Future<List<PostModel>> getPosts();

  Future<void> deletePost(int postId);

  Future<void> createPost(PostModel post);

  Future<void> updatePost(PostModel post);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final DioHelper dioHelper;

  const RemoteDataSourceImpl(this.dioHelper);

  @override
  Future<List<PostModel>> getPosts() async {
    final data = await dioHelper.request(
      endpoint: ApiConstants.posts,
      method: Method.get,
    ) as List;

    final posts = data
        .map<PostModel>((postJSON) => PostModel.fromJson(postJSON))
        .toList();

    return posts;
  }

  @override
  Future<void> createPost(PostModel post) async {
    final data = {
      'title': post.title,
      'body': post.body,
    };

    await dioHelper.request(
      endpoint: ApiConstants.posts,
      method: Method.post,
      params: data,
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
