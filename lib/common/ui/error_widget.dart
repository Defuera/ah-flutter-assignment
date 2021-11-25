import 'package:ah/common/model/data/error.dart';
import 'package:flutter/material.dart';

class AhErrorWidget extends StatelessWidget {
  const AhErrorWidget(this.error, {this.onRetry, Key? key}) : super(key: key);

  final RemoteError error;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: error.when(
            network: () => _NetworkError(onRetry: onRetry),
            unexpected: (message) => Text(message ?? 'Something went terribly wrong'),
            server: (message, code) => _ServerError(message: message, code: code),
          ),
        ),
      );
}

class _ServerError extends StatelessWidget {
  const _ServerError({required this.message, required this.code, Key? key}) : super(key: key);

  final String message;
  final int code;

  @override
  Widget build(BuildContext context) => Text('Server error $code:\n$message');
}

class _NetworkError extends StatelessWidget {
  const _NetworkError({this.onRetry, Key? key}) : super(key: key);

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.signal_wifi_connected_no_internet_4_rounded,
            color: Colors.orangeAccent,
            size: 84,
          ),
          ElevatedButton(
            child: Text(
              'Retry',
              style: Theme.of(context).textTheme.button?.copyWith(color: Colors.white),
            ),
            onPressed: onRetry,
          )
        ],
      );
}
