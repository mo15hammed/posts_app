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
  await _setUpExternalDependencies();

  // Core
  _setUpCoreDependencies();

  // Data Sources
  _setUpDataSourcesDependencies();

  // Repositories
  _setUpRepositoriesDependencies();

  // UseCases
  _setUpUsecasesDependencies();

  // Blocs
  _setUpBlocsDependencies();
}

Future<void> _setUpExternalDependencies() async {
  getItInstance.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  getItInstance
      .registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

void _setUpCoreDependencies() {
  getItInstance.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(getItInstance()),
  );

  getItInstance.registerLazySingleton<DioHelper>(() => DioHelper());
}

void _setUpDataSourcesDependencies() {
  getItInstance.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImplWithHive(),
  );

  // getItInstance.registerLazySingleton<LocalDataSource>(
  //   () => LocalDataSourceWithSharedPref(getItInstance()),
  // );

  getItInstance.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(getItInstance()),
  );
}

void _setUpRepositoriesDependencies() {
  getItInstance.registerLazySingleton<PostsRepository>(
    () => PostsRepositoryImpl(
      localDataSource: getItInstance(),
      remoteDataSource: getItInstance(),
      networkInfo: getItInstance(),
    ),
  );
}

void _setUpUsecasesDependencies() {
  getItInstance.registerLazySingleton<GetAllPostsUsecase>(
    () => GetAllPostsUsecase(getItInstance()),
  );
  getItInstance.registerLazySingleton<CreatePostUsecase>(
      () => CreatePostUsecase(getItInstance()));
  getItInstance.registerLazySingleton<UpdatePostUsecase>(
      () => UpdatePostUsecase(getItInstance()));
  getItInstance.registerLazySingleton<DeletePostUsecase>(
      () => DeletePostUsecase(getItInstance()));
}

void _setUpBlocsDependencies() {
  getItInstance.registerFactory<PostsBloc>(() => PostsBloc(getItInstance()));
  getItInstance.registerFactory<PostActionsBloc>(
    () => PostActionsBloc(
      createPostUsecase: getItInstance(),
      updatePostUsecase: getItInstance(),
      deletePostUsecase: getItInstance(),
    ),
  );
}
