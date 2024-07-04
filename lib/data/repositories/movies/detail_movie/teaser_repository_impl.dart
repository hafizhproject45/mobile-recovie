// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:recovie/core/errors/failures.dart';
import 'package:recovie/data/datasources/movies/detail_movie/teaser_datasource.dart';
import 'package:recovie/domain/entities/movies/detail_movie/teaser_entity.dart';
import 'package:recovie/domain/repositories/movies/detail_movie/teaser_repository.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/constants.dart';

class TeaserRepositoryImpl extends TeaserRepository {
  final TeaserDataSource teaserDataSource;

  TeaserRepositoryImpl({
    required this.teaserDataSource,
  });

  @override
  Future<Either<Failure, List<TeaserEntity>>> getTeaser(int movieId) async {
    try {
      List<TeaserEntity> data = await teaserDataSource.getTeaser(movieId);

      return Right(data);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      } else {
        return const Left(UnknownFailure(message: FAILURE_UNKNOWN));
      }
    }
  }
}
