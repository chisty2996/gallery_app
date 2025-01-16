import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gallery_app/features/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:gallery_app/features/gallery/presentation/widgets/grant_access_button.dart';
import 'package:gallery_app/features/gallery/presentation/widgets/permission_widget.dart';
import 'package:mocktail/mocktail.dart';


class MockGalleryBloc extends Mock implements GalleryBloc {}


class FakeGalleryEvent extends Fake implements GalleryEvent {}

void main() {
  late MockGalleryBloc mockGalleryBloc;

  setUpAll(() {
    registerFallbackValue(FakeGalleryEvent());
  });

  setUp(() {
    mockGalleryBloc = MockGalleryBloc();
    when(() => mockGalleryBloc.close()).thenAnswer((_) async {});
  });

  tearDown(() async {
    await mockGalleryBloc.close();
  });

  testWidgets('renders PermissionWidget correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PermissionWidget(galleryBloc: mockGalleryBloc),
        ),
      ),
    );

    expect(find.text("Require Permission"), findsOneWidget);
    expect(
      find.text(
        "To show your black and white photos\nwe just need your folder permission.\nWe promise, we don't take your photos",
      ),
      findsOneWidget,
    );
    expect(find.byType(GrantAccessButton), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('tapping GrantAccessButton triggers RequestPermission event',
          (WidgetTester tester) async {
        when(() => mockGalleryBloc.add(any())).thenReturn(null);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: PermissionWidget(galleryBloc: mockGalleryBloc),
            ),
          ),
        );

        final button = find.byType(GrantAccessButton);
        expect(button, findsOneWidget);

        await tester.tap(button);
        await tester.pump();

        verify(() => mockGalleryBloc.add(const RequestPermission())).called(1);
      });
}
