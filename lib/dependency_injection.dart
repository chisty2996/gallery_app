import 'package:gallery_app/features/gallery/data/datasources/gallery_data_sources.dart';
import 'package:gallery_app/features/gallery/data/repositories/gallery_repository_impl.dart';
import 'package:gallery_app/features/gallery/domain/repositories/gallery_repository.dart';
import 'package:gallery_app/features/gallery/domain/usecases/gallery_usecases.dart';
import 'package:gallery_app/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async{

  sl.registerLazySingleton<GalleryDataSources>(() => GalleryDataSources());
  sl.registerLazySingleton<GalleryRepository>(() => GalleryRepositoryImpl());
  sl.registerLazySingleton<GalleryUseCases>(() => GalleryUseCases(galleryRepository: sl()));
  sl.registerFactory<GalleryBloc>(() => GalleryBloc(galleryUseCases: sl()));
}