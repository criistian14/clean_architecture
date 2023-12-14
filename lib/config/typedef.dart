import 'package:multiple_result/multiple_result.dart';

export 'package:multiple_result/multiple_result.dart';

typedef ResultFuture<T> = Future<Result<T, Exception>>;

typedef ResultVoid = ResultFuture<void>;
