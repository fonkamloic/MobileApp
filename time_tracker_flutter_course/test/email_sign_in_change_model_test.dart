import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracker_flutter_course/app/sign_in/email_sign_in_change_model.dart';

import 'mocks.dart';

void main() {
  MockAuth mockAuth;
  EmailSignInChangeModel model;

  setUp(() {
    mockAuth = MockAuth();
    model = EmailSignInChangeModel(auth: mockAuth);
  });

  test('updateEmail', () {
    var disNotifyListeners = false;
    model.addListener(() => disNotifyListeners = true);
    const sampleEmail = 'test@email.com';
    model.updateEmail(sampleEmail);

    expect(model.email, sampleEmail);
    expect(disNotifyListeners, true);
  });
}
