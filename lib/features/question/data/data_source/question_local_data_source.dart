// import 'package:dartz/dartz.dart';
// import 'package:discussion_forum/core/network/local/hive_service.dart';
// import 'package:discussion_forum/features/batch/data/model/question_hive_model.dart';
// import 'package:discussion_forum/features/batch/domain/entity/question_entity.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';


// final batchLocalDataSourceProvider = Provider.autoDispose<BatchLocalDataSource>(
//     (ref) => BatchLocalDataSource(hiveService: ref.read(hiveSerivceProvider)
//     ));

// class BatchLocalDataSource {
//   final HiveService hiveService;

//   BatchLocalDataSource({
//     required this.hiveService,
//   });

//   // Add Batch
//   Future<Either<Failure, bool>> addBatch(BatchEntity batch) async {
//     // convert batch entity to batch hive model
//     try {
//       BatchHiveModel batchHiveModel = BatchHiveModel.toHiveModel(batch);
//       hiveService.addBatch(batchHiveModel);
//       return const Right(true);
//     } catch (e) {
//       return left(Failure(error: e.toString()));
//     }
//   }

//   Future<Either<Failure, List<BatchEntity>>> getAllBatches() async {
//     try {
//       List<BatchHiveModel> batches = await hiveService.getAllBatches();
//       // convert hive object to entitty
//       List<BatchEntity> batchEntities =
//           batches.map((e) => BatchHiveModel.toEntity(e)).toList();
//       return Right(batchEntities);
//     } catch (e) {
//       return left(Failure(error: e.toString()));
//     }
//   }
// }
