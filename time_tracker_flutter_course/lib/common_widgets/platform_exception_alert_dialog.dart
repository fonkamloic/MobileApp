import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_alert_dialog.dart';

class PlatformExceptionAlertDialog extends PlatformAlertDialog {
  PlatformExceptionAlertDialog({
    @required String title,
    @required PlatformException exception,
  }) : super(
          title: title,
          content: _message(exception),
          defaultActionText: 'OK',
        );

  static String _message(PlatformException exception) {
    print(exception);
    if (exception.message == 'FIRFirestoreErrorDomain') {
      if (exception.code == 'Error 7') {
        return "Missing or insufficient permission";
      }
    }
    return _errors[exception.code] ?? exception.message;
  }

  static Map<String, String> _errors = {
    'ERROR_INVALID_CREDENTIAL':
        'If the credential data is malformed or has expired.',
    'ERROR_USER_DISABLED':
        'If the user has been disabled (for example, in the Firebase console)',
    'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL':
        'If there already exists an account with the email address asserted by Google.',
    'ERROR_OPERATION_NOT_ALLOWED':
        ' Indicates that Google accounts are not enabled.',
    'ERROR_INVALID_ACTION_CODE':
        'If the action code in the link is malformed, expired, or has already been used. ',
    'ERROR_INVALID_EMAIL': 'If the [email] address is malformed.',
    'ERROR_WRONG_PASSWORD': 'If the [password] is wrong.',
    'ERROR_USER_NOT_FOUND':
        'If there is no user corresponding to the given [email] address, or if the user has been deleted.',
    'ERROR_USER_DISABLED':
        'If the user has been disabled (for example, in the Firebase console)',
    'ERROR_TOO_MANY_REQUESTS':
        'If there was too many attempts to sign in as this user.',
    'ERROR_OPERATION_NOT_ALLOWED':
        'Indicates that Email & Password accounts are not enabled.',
    'ERROR_NOT_ALLOWED':
        'Indicates that email and email sign-in link accounts are not enabled. Enable them in the Auth section of the Firebase console.',
    'ERROR_DISABLED': 'Indicates the user\'s account is disabled.',
    'ERROR_INVALID': 'Indicates the email address is invalid.',
  };
}
