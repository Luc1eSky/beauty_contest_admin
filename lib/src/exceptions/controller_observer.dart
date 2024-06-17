import 'package:beauty_contest_admin/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../navigation/navigation_service.dart';

/// Error logger class to keep track of all AsyncError states that are set
/// by the controllers in the app
class ControllerObserver extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    // check if new value is an AsyncError
    final error = _findAsyncError(newValue);
    // exit if there was no error found
    if (error == null) {
      return;
    }

    // // get error logger from provider
    // final errorHandler = container.read(errorHandlerProvider);
    // // log error or exception
    // errorHandler.handleCaughtError(
    //   error: error.error,
    //   stack: error.stackTrace,
    // );

    // show alert dialog if there is a context available
    final context = NavigationService.navigatorKey.currentContext;
    if (context != null) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Oh Snap'.hardcoded),
              content: Text('Something went wrong.'.hardcoded),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'.hardcoded),
                )
              ],
            );
          });
    }
  }

  AsyncError<dynamic>? _findAsyncError(Object? value) {
    if (value is AsyncError) {
      return value;
    } else {
      return null;
    }
  }
}
