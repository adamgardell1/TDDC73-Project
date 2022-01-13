import 'package:test/test.dart';
import 'package:project/leaderboard/leaderboard.dart';
import 'package:project/item.dart';
import 'package:project/movies.dart';

void main() {
//Unit test of sort function

  group('Top sort testing:', () {
    final List<Item> testSorted = sortList("Top", movies);

    test(
        'The number of items in the sorted list should be the same as the list of movies before sorting',
        () {
      expect(testSorted.length, movies.length);
    });

    test(
        'Every item in the list should have greater or equal score than following item',
        () {
      for (int i = 1; i < testSorted.length; i++) {
        expect(testSorted[i - 1].compareValue,
            greaterThanOrEqualTo(testSorted[i].compareValue));
      }
    });
  });

  group('Category sort testing:', () {
    final List<Item> testSorted = sortList("Action", movies);

    test(
        'The number of items sorted by category should be the same as number of items in that category before sorting',
        () {
      expect(testSorted.length,
          (movies.where((f) => f.category == "Action").length));
    });

    test('Every item in the sorted list should have the entered category', () {
      for (int i = 0; i < testSorted.length; i++) {
        expect(testSorted[i].category, "Action");
      }
    });

    test(
        'Every item in the list should have greater or equal score than following item',
        () {
      for (int i = 1; i < testSorted.length; i++) {
        expect(testSorted[i - 1].compareValue,
            greaterThanOrEqualTo(testSorted[i].compareValue));
      }
    });
  });
}
