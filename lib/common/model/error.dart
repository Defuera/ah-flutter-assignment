class IllegalState {}

enum RemoteErrorType { network, unexpected, server }

class RemoteError {
  factory RemoteError.network() => RemoteError._(type: RemoteErrorType.network);

  factory RemoteError.unexpected([String? message]) => RemoteError._(
        type: RemoteErrorType.unexpected,
        message: message,
      );

  factory RemoteError.server(int code, String? message) => RemoteError._(
        type: RemoteErrorType.server,
        message: message,
        code: code,
      );

  RemoteError._({required this.type, this.message, this.code});

  final int? code;
  final String? message;
  final RemoteErrorType type;
}

extension RemoteErrorExtention on RemoteError {
  T when<T>({
    required T Function() network,
    required T Function(String?) unexpected,
    required T Function(String, int) server,
  }) {
    final checkedMessage = this.message;
    final checkedCode = this.code;
    switch (type) {
      case RemoteErrorType.network:
        return network();
      case RemoteErrorType.unexpected:
        return unexpected(checkedMessage);
      case RemoteErrorType.server:
        if (checkedMessage == null || checkedCode == null) {
          return unexpected(checkedMessage);
        } else {
          return server(checkedMessage, checkedCode);
        }
    }
  }
}
