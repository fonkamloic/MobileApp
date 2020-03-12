import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/home/home_page.dart';
import 'package:time_tracker_flutter_course/app/landing_page.dart';
import 'package:time_tracker_flutter_course/app/sign_in/sign_in_page.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import 'package:mockito/mockito.dart';

import 'mocks.dart';

void main() {
  MockAuth mockAuth;
  StreamController<User> onAuthStateChangedController;

  setUp(() {
    mockAuth = MockAuth();
    onAuthStateChangedController = StreamController<User>();
  });

  tearDown(() {
    onAuthStateChangedController.close();
  });

  Future<void> pumpLandingPage(WidgetTester tester) async {
    await tester.pumpWidget(
      Provider<AuthBase>(
        create: (_) => mockAuth,
        child: MaterialApp(home: LandingPage()),
      ),
    );
    await tester.pump();
  }

  void stubOnAuthStateChangeYields(Iterable<User> onAuthStateChanged) {
    onAuthStateChangedController
        .addStream(Stream<User>.fromIterable(onAuthStateChanged));
    when(mockAuth.onAuthStateChanged).thenAnswer((_) {
      return onAuthStateChangedController.stream;
    });
  }

  testWidgets('stream waiting', (WidgetTester tester) async {
    stubOnAuthStateChangeYields([]);

    await pumpLandingPage(tester);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('null user', (WidgetTester tester) async {
    stubOnAuthStateChangeYields([null]);

    await pumpLandingPage(tester);

    expect(find.byType(SignInPage), findsOneWidget);
  });

  testWidgets('non-null user', (WidgetTester tester) async {
    stubOnAuthStateChangeYields([User(uid: '123')]);

    await pumpLandingPage(tester);

    expect(find.byType(HomePage), findsOneWidget);
  });
}
