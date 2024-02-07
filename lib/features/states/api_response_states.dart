import 'status_enum.dart';

class ApiResponseState<T> {
  Status? status;
  T? data;
  String? message;
  // int? loadedArticles;
  bool? hasPartialerror;

  ApiResponseState(this.message, this.data, this.status);
  ApiResponseState.idle() : status = Status.IDLE;
  ApiResponseState.loading() : status = Status.LOADING;
  ApiResponseState.data(this.data, this.hasPartialerror) : status = Status.DATA;
  ApiResponseState.copmpleted(this.data) : status = Status.COMPLETED;
  ApiResponseState.failed(this.message) : status = Status.FAILED;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data: $data";
  }
}
