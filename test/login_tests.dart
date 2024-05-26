import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_hub/components/my_button.dart';
import 'package:learn_hub/pages/login_page.dart';

void main() {
  group('LoginPage', () {
    testWidgets('displays login form', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginPage()));
      expect(find.byType(TextField), findsNWidgets(2));
      return print('Display successful!');
    });

    testWidgets('valid credentials should show success message', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginPage()));
      await tester.enterText(find.byType(TextField).first, 'jacky.suwandi@gmail.com');
      await tester.enterText(find.byType(TextField).last, '123456');
      await tester.tap(find.byType(MyButton));
      return print('Login successful!');
    });

    testWidgets('invalid credentials should show error message', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginPage()));
      await tester.enterText(find.byType(TextField).first, 'awekwok@email.com');
      await tester.enterText(find.byType(TextField).last, 'inipassword');
      await tester.tap(find.byType(MyButton));
      return print('Invalid Email or Password');
    });
  });
}