import 'package:equatable/equatable.dart';

class Result<T> extends Equatable {
  final T? value;
  final Exception? exception;
  final bool isProcessing;

  const Result.fromValue(T result)
      : value = result,
        exception = null,
        isProcessing = false;

  const Result.fromException(Exception ex)
      : value = null,
        exception = ex,
        isProcessing = false;

  const Result.isLoading()
      : value = null,
        exception = null,
        isProcessing = true;

  const Result.idle()
      : value = null,
        exception = null,
        isProcessing = false;

  @override
  List<Object?> get props => [value, exception, isProcessing];
}
