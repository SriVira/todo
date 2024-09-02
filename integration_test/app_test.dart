import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:todo/main.dart' as app;
import 'package:todo/presentation/screens/add_todo_screen.dart';
import 'package:todo/presentation/screens/todo_list_screen.dart';
import 'package:todo/presentation/widgets/buttons/primary_elevated_button.dart';
import 'package:todo/presentation/widgets/form/date_time_picker.dart';
import 'package:todo/presentation/widgets/form/primary_text_form_feild.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('TodoListScreen interactions and state updates',
      (WidgetTester tester) async {
    // Load the app
    app.main();

    // Ensure this points to your app's widget
    await tester.pumpWidget(const app.MyApp());

    // Simulate adding a new ToDo item
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle(); // Wait for the bottom sheet to appear

    // Verify AddToDoScreen appears
    expect(find.byType(AddToDoScreen), findsOneWidget);

    // Enter text into the form fields
    await Future.delayed(const Duration(seconds: 2));
    await tester.enterText(find.byType(PrimaryTextFormFeild).at(0), 'New Task');
    await Future.delayed(const Duration(seconds: 2));
    await tester.enterText(
        find.byType(PrimaryTextFormFeild).at(1), 'Task Description');
    await Future.delayed(const Duration(seconds: 2));
    await tester.enterText(find.byType(DatePicker), DateTime.now().toString());
    await Future.delayed(const Duration(seconds: 2));

    // Submit the form
    await tester.tap(find.byType(PrimaryElevatedButton));
    await Future.delayed(const Duration(seconds: 2));
    await tester.pumpAndSettle(); // Wait for form submission

    // Verify that we're back on TodoListScreen
    expect(find.byType(TodoListScreen), findsOneWidget);
  });
}
