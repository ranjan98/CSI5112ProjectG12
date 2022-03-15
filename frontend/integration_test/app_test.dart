import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:frontend/main.dart' as app;

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('sigin', (WidgetTester tester) async {
      try {
        app.main();
        await tester.pumpAndSettle(); //check if any animations are running

        /*
        Test case 1:  signin page
      */

        // final Finder emailAddress = find.byKey(Key('emailAdd'));
        // final Finder password = find.byKey(const Key('password'));
        // final Finder signinButton = find.byKey(const Key('signin'));

        // await tester.enterText(emailAddress, "ranjan@uottawa.ca");
        // await tester.enterText(password, "canada2020");
        // await tester.tap(signinButton);
      } on Exception catch (e) {
        // ignore: avoid_print
        print(e);
      }
    });
  });
}
