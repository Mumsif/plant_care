import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plant_care/app.dart';
import 'package:plant_care/data/app_state.dart';
import 'package:plant_care/features/care_tips/care_tips_screen.dart';
import 'package:plant_care/features/history/watering_history_screen.dart';
import 'package:plant_care/features/notifications/notifications_screen.dart';
import 'package:plant_care/models/plant.dart';
import 'package:plant_care/shared/widgets/liquid_glass_nav_bar.dart';

// 1x1 transparent PNG image for tests
const List<int> _kTransparentImage = <int>[
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, 0x49,
  0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x08, 0x06,
  0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44,
  0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00, 0x05, 0x00, 0x01, 0x0D,
  0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE, 0x42,
  0x60, 0x82,
];

class _TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return _createMockImageHttpClient();
  }
}

HttpClient _createMockImageHttpClient() {
  return _MockHttpClient();
}

class _MockHttpClient implements HttpClient {
  @override
  bool autoUncompress = true;
  @override
  Duration? connectionTimeout;
  @override
  Duration idleTimeout = const Duration(seconds: 15);
  @override
  int? maxConnectionsPerHost;
  @override
  String? userAgent;

  @override
  void addCredentials(Uri url, String realm, HttpClientCredentials credentials) {}
  @override
  void addProxyCredentials(String host, int port, String realm, HttpClientCredentials credentials) {}
  @override
  void close({bool force = false}) {}

  @override
  set authenticate(Future<bool> Function(Uri url, String scheme, String? realm)? f) {}
  @override
  set authenticateProxy(Future<bool> Function(String host, int port, String scheme, String? realm)? f) {}
  @override
  set badCertificateCallback(bool Function(X509Certificate cert, String host, int port)? callback) {}
  @override
  set findProxy(String Function(Uri url)? f) {}

  @override
  Future<HttpClientRequest> getUrl(Uri url) => openUrl('GET', url);
  @override
  Future<HttpClientRequest> openUrl(String method, Uri url) async => _MockHttpClientRequest();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _MockHttpClientRequest implements HttpClientRequest {
  @override
  final HttpHeaders headers = _MockHttpHeaders();

  @override
  Future<HttpClientResponse> close() async => _MockHttpClientResponse();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _MockHttpHeaders implements HttpHeaders {
  @override
  void add(String name, Object value, {bool preserveHeaderCase = false}) {}
  @override
  void set(String name, Object value, {bool preserveHeaderCase = false}) {}
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _MockHttpClientResponse implements HttpClientResponse {
  @override
  int get statusCode => 200;
  @override
  int get contentLength => _kTransparentImage.length;
  @override
  HttpClientResponseCompressionState get compressionState =>
      HttpClientResponseCompressionState.notCompressed;

  @override
  Stream<List<int>> asBroadcastStream({
    void Function(StreamSubscription<List<int>> subscription)? onListen,
    void Function(StreamSubscription<List<int>> subscription)? onCancel,
  }) =>
      Stream.fromIterable([_kTransparentImage]).asBroadcastStream();

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int> event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return Stream.fromIterable([_kTransparentImage]).listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  setUpAll(() {
    HttpOverrides.global = _TestHttpOverrides();
  });

  group('Multi-User AppState Tests', () {
    test('State data changes dynamically for different users', () {
      final appState = AppState();

      // Default user is Alex
      expect(appState.currentUser.name, 'Alex');
      expect(appState.currentUser.plants.any((p) => p.name == 'Monstera'), isTrue);
      expect(appState.currentUser.temperatureUnit, 'Celsius (°C)');

      // Switch to User 2 (Sarah)
      appState.switchUser(1);
      expect(appState.currentUser.name, 'Sarah');
      expect(appState.currentUser.plants.any((p) => p.name == 'Peace Lily'), isTrue);
      expect(appState.currentUser.plants.any((p) => p.name == 'Monstera'), isFalse);
      expect(appState.currentUser.temperatureUnit, 'Fahrenheit (°F)');

      // Switch to User 3 (David)
      appState.switchUser(2);
      expect(appState.currentUser.name, 'David');
      expect(appState.currentUser.plants.any((p) => p.name == 'Jade Plant'), isTrue);
      expect(appState.currentUser.themePreference, 'Dark');

      // Switch back to Alex
      appState.switchUser(0);
      expect(appState.currentUser.name, 'Alex');
    });

    test('Watering a plant updates status and completes tasks', () {
      final appState = AppState();

      final aloe = appState.currentUser.plants.firstWhere((p) => p.name == 'Aloe Vera');
      expect(aloe.waterDaysLeft, 0);

      appState.waterPlant(aloe.id);

      final updatedAloe = appState.currentUser.plants.firstWhere((p) => p.name == 'Aloe Vera');
      expect(updatedAloe.waterDaysLeft, 5);
      expect(updatedAloe.status, PlantStatus.thriving);
    });
  });

  group('Liquid Glass Bottom Bar & Navigation Tests', () {
    testWidgets('LiquidGlassNavBar renders with all 5 tabs and responds to taps',
        (WidgetTester tester) async {
      int selected = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: LiquidGlassNavBar(
              currentIndex: selected,
              onTabSelected: (idx) => selected = idx,
            ),
          ),
        ),
      );

      // Verify all 5 tab labels are visible
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('My Plants'), findsOneWidget);
      expect(find.text('Calendar'), findsOneWidget);
      expect(find.text('Tips'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);

      // Tap on Tips tab
      await tester.tap(find.text('Tips'));
      await tester.pumpAndSettle();
      expect(selected, 3);
    });

    testWidgets('AppShell renders with floating LiquidGlassNavBar',
        (WidgetTester tester) async {
      final appState = AppState();

      await tester.pumpWidget(
        AppStateProvider(
          notifier: appState,
          child: const PlantCareApp(),
        ),
      );
      await tester.pump();

      expect(find.byType(LiquidGlassNavBar), findsOneWidget);
      expect(find.text('Total Plants'), findsOneWidget);
      expect(find.text('Need Water'), findsOneWidget);
      expect(find.text("Today's Tasks"), findsOneWidget);
    });

    testWidgets('NotificationsScreen renders successfully',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: NotificationsScreen()),
      );
      await tester.pump();

      expect(find.text('Notifications'), findsOneWidget);
      expect(find.text('Recent Updates'), findsOneWidget);
    });

    testWidgets('CareTipsScreen renders successfully',
        (WidgetTester tester) async {
      final appState = AppState();

      await tester.pumpWidget(
        AppStateProvider(
          notifier: appState,
          child: const MaterialApp(home: CareTipsScreen()),
        ),
      );
      await tester.pump();

      expect(find.text('Care Tips'), findsOneWidget);
      expect(find.text('Featured Guide'), findsOneWidget);
    });

    testWidgets('WateringHistoryScreen renders successfully',
        (WidgetTester tester) async {
      final appState = AppState();

      await tester.pumpWidget(
        AppStateProvider(
          notifier: appState,
          child: const MaterialApp(home: WateringHistoryScreen()),
        ),
      );
      await tester.pump();

      expect(find.text('Watering History'), findsOneWidget);
      expect(find.text('Total Waters'), findsOneWidget);
      expect(find.text('On-Time Rate'), findsOneWidget);
    });
  });
}
