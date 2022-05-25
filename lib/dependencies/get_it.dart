import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_app/core/network/network_info.dart';
import 'package:posts_app/data/core/dio_helper.dart';
import 'package:posts_app/data/data_sources/posts_local_data_source.dart';
import 'package:posts_app/data/data_sources/posts_remote_data_source.dart';
import 'package:posts_app/data/repositories/posts_repository_impl.dart';
import 'package:posts_app/domain/repositories/posts_repository.dart';
import 'package:posts_app/domain/usecases/create_post.dart';
import 'package:posts_app/domain/usecases/delete_post.dart';
import 'package:posts_app/domain/usecases/get_posts.dart';
import 'package:posts_app/domain/usecases/update_post.dart';
import 'package:posts_app/presentation/blocs/post_actions/post_actions_bloc.dart';
import 'package:posts_app/presentation/blocs/posts/posts_bloc.dart';

final getItInstance = GetIt.instance;

void setupDependencies() {
  // External
  getItInstance.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());

  // Core
  getItInstance.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(getItInstance()),
  );
  getItInstance.registerLazySingleton<DioHelper>(() => DioHelper());

  // Data Sources
  getItInstance.registerLazySingleton<PostsLocalDataSource>(
    () => PostsLocalDataSourceImpl(),
  );
  getItInstance.registerLazySingleton<PostsRemoteDataSource>(
    () => PostsRemoteDataSourceImpl(getItInstance()),
  );

  // Repositories
  getItInstance.registerLazySingleton<PostsRepository>(
    () => PostsRepositoryImpl(
      localDataSource: getItInstance(),
      remoteDataSource: getItInstance(),
      networkInfo: getItInstance(),
    ),
  );

  // Usecases
  getItInstance.registerLazySingleton<GetAllPosts>(
    () => GetAllPosts(getItInstance()),
  );
  getItInstance
      .registerLazySingleton<CreatePost>(() => CreatePost(getItInstance()));
  getItInstance
      .registerLazySingleton<UpdatePost>(() => UpdatePost(getItInstance()));
  getItInstance
      .registerLazySingleton<DeletePost>(() => DeletePost(getItInstance()));

  // Blocs
  getItInstance.registerFactory<PostsBloc>(() => PostsBloc(getItInstance()));
  getItInstance.registerFactory<PostActionsBloc>(
    () => PostActionsBloc(
      createPost: getItInstance(),
      updatePost: getItInstance(),
      deletePost: getItInstance(),
    ),
  );
}
