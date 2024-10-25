import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_hub/pages/register_page.dart';
import 'package:learn_hub/pages/login_page.dart';

void main() {
  testWidgets('Halaman Register Menampilkan Semua Elemen', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpPage(title: 'Register')));

    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(3));
    expect(find.text('E-mail :'), findsOneWidget);
    expect(find.text('Date of Birth :'), findsOneWidget);
    expect(find.text('Password :'), findsOneWidget);
    expect(find.text('Join Now'), findsOneWidget);
  });

  testWidgets('Input Email dan Password Valid', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpPage(title: 'Register')));

    await tester.enterText(find.byKey(const Key('emailField')), 'test@example.com');
    await tester.enterText(find.byKey(const Key('passwordField')), 'password123');
    await tester.tap(find.byKey(const Key('dateField')));
    await tester.pumpAndSettle();

    // Pilih tanggal di date picker (contoh: 1 Januari 2000)
    await tester.tap(find.text('1'));
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Join Now'));
    await tester.pump();

    // Verifikasi navigasi ke halaman login atau tindakan yang sesuai
    expect(find.byType(LoginPage), findsOneWidget);
  });

  testWidgets('Input Email Tidak Valid', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpPage(title: 'Register')));

    await tester.enterText(find.byKey(const Key('emailField')), 'test@com');
    await tester.enterText(find.byKey(const Key('passwordField')), 'password123');
    await tester.tap(find.byKey(const Key('dateField')));
    await tester.pumpAndSettle();

    // Pilih tanggal di date picker
    await tester.tap(find.text('1'));
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Join Now'));
    await tester.pump();

    // Verifikasi tidak ada navigasi atau muncul pesan kesalahan
    expect(find.byType(LoginPage), findsNothing);
    // Tambahkan validasi pesan kesalahan sesuai dengan implementasi Anda
  });

  testWidgets('Input Tanggal Lahir', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpPage(title: 'Register')));

    await tester.tap(find.byKey(const Key('dateField')));
    await tester.pumpAndSettle();

    // Pilih tanggal di date picker
    await tester.tap(find.text('1'));
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // Verifikasi tanggal ditampilkan di input field
    expect(find.text('2000-01-01'), findsOneWidget);
  });

  testWidgets('Input Password dengan Panjang Kurang dari 6 Karakter', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpPage(title: 'Register')));

    await tester.enterText(find.byKey(const Key('emailField')), 'test@example.com');
    await tester.enterText(find.byKey(const Key('passwordField')), '123');
    await tester.tap(find.byKey(const Key('dateField')));
    await tester.pumpAndSettle();

    // Pilih tanggal di date picker
    await tester.tap(find.text('1'));
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Join Now'));
    await tester.pump();

    // Verifikasi tidak ada navigasi atau muncul pesan kesalahan
    expect(find.byType(LoginPage), findsNothing);
    // Tambahkan validasi pesan kesalahan sesuai dengan implementasi Anda
  });

  testWidgets('Tanggal Lahir Kosong', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpPage(title: 'Register')));

    await tester.enterText(find.byKey(const Key('emailField')), 'test@example.com');
    await tester.enterText(find.byKey(const Key('passwordField')), 'password123');

    await tester.tap(find.text('Join Now'));
    await tester.pump();

    // Verifikasi tidak ada navigasi atau muncul pesan kesalahan
    expect(find.byType(LoginPage), findsNothing);
    // Tambahkan validasi pesan kesalahan sesuai dengan implementasi Anda
  });

  testWidgets('Menampilkan Pesan Kesalahan dari Server', (WidgetTester tester) async {
    // Mock backend response to simulate email already registered error
    await tester.pumpWidget(const MaterialApp(home: SignUpPage(title: 'Register')));

    await tester.enterText(find.byKey(const Key('emailField')), 'existing@example.com');
    await tester.enterText(find.byKey(const Key('passwordField')), 'password123');
    await tester.tap(find.byKey(const Key('dateField')));
    await tester.pumpAndSettle();

    // Pilih tanggal di date picker
    await tester.tap(find.text('1'));
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Join Now'));
    await tester.pump();

    // Verifikasi muncul pesan kesalahan dari server
    // Tambahkan validasi pesan kesalahan sesuai dengan implementasi Anda
  });

  testWidgets('Tombol Join Now Tidak Dapat Diklik Jika Input Tidak Lengkap', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpPage(title: 'Register')));

    await tester.enterText(find.byKey(const Key('emailField')), 'test@example.com');
    // Password field is left empty
    await tester.tap(find.byKey(const Key('dateField')));
    await tester.pumpAndSettle();

    // Pilih tanggal di date picker
    await tester.tap(find.text('1'));
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Join Now'));
    await tester.pump();

    // Verifikasi tidak ada navigasi atau muncul pesan kesalahan
    expect(find.byType(LoginPage), findsNothing);
    // Tambahkan validasi pesan kesalahan sesuai dengan implementasi Anda
  });
}
