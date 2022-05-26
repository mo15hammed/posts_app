import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_app/core/network/network_info.dart';
import 'package:posts_app/data/core/dio_helper.dart';
import 'package:posts_app/data/data_sources/local_data_source.dart';
import 'package:posts_app/data/data_sources/remote_data_source.dart';
import 'package:posts_app/data/repositories/posts_repository_impl.dart';
import 'package:posts_app/domain/repositories/posts_repository.dart';
import 'package:posts_app/domain/usecases/create_post_usecase.dart';
import 'package:posts_app/domain/usecases/delete_post_usecase.dart';
import 'package:posts_app/domain/usecases/get_posts_usecase.dart';
import 'package:posts_app/domain/usecases/update_post_usecase.dart';
import 'package:posts_app/presentation/blocs/post_actions/post_actions_bloc.dart';
import 'package:posts_app/presentation/blocs/posts/posts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getItInstance = GetIt.instance;

Future<void> setupDependencies() async {
  // External
  getItInstance.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  getItInstance
      .registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Core
  getItInstance.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(getItInstance()),
  );

  getItInstance.registerLazySingleton<DioHelper>(() => DioHelper());

  // Data Sources
  getItInstance.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImplWithHive(),
  );

  // getItInstance.registerLazySingleton<LocalDataSource>(
  //   () => LocalDataSourceWithSharedPref(getItInstance()),
  // );

  getItInstance.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(getItInstance()),
  );

  // Repositories
  getItInstance.registerLazySingleton<PostsRepository>(
    () => PostsRepositoryImpl(
      localDataSource: getItInstance(),
      remoteDataSource: getItInstance(),
      networkInfo: getItInstance(),
    ),
  );

  // UseCases
  getItInstance.registerLazySingleton<GetAllPostsUsecase>(
    () => GetAllPostsUsecase(getItInstance()),
  );
  getItInstance.registerLazySingleton<CreatePostUsecase>(
      () => CreatePostUsecase(getItInstance()));
  getItInstance.registerLazySingleton<UpdatePostUsecase>(
      () => UpdatePostUsecase(getItInstance()));
  getItInstance.registerLazySingleton<DeletePostUsecase>(
      () => DeletePostUsecase(getItInstance()));

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
