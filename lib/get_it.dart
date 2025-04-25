import 'package:book_app/cubit/book_cubit.dart';
import 'package:book_app/service/api/dio_helper.dart';
import 'package:book_app/service/repository/repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';

final gi = GetIt.instance;

Future<void> initGetIt() async {
  final dio = Dio();

  dio.interceptors.add(TalkerDioLogger());

  dio.options.headers.addAll({
    Headers.acceptHeader: 'application/json',
    Headers.contentTypeHeader: 'application/json',
  });

  gi.registerSingleton<Dio>(dio);

  gi.registerFactory(() => DioHelper(gi()));

  gi.registerFactory(() => Repository(gi()));

  gi.registerFactory(() => BookCubit(gi()));
}
