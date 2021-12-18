// LINT
import 'dart:async';

void firstFunction(
    String firstArgument, String secondArgument, String thirdArgument) {
  return;
}

void secondFunction() {
  firstFunction('some string', 'some other string',
      'and another string for length exceed'); // LINT
}

void thirdFunction(String someLongVarName, void Function() someLongCallbackName,
    String arg3) {} // LINT

class TestClass1 {
  // LINT
  void firstMethod(
      String firstArgument, String secondArgument, String thirdArgument) {
    return;
  }

  void secondMethod() {
    firstMethod('some string', 'some other string',
        'and another string for length exceed'); // LINT

    thirdFunction('some string', () {
      return;
    }, 'some other string'); // LINT
  }
}

final List<String> secondArray = [
  'some string',
  'some other string',
  'and another string for length exceed'
];

final Set<String> secondSet = {
  'some string',
  'some other string',
  'and another string for length exceed'
};

final Map<String, String> secondMap = {
  'some string': 'and another string for length exceed',
  'and another string for length exceed':
      'and another string for length exceed___________________________________________'
};

// -------
List<bool> samplelist = []; //LINT

Iterable<List<String>> stringsiter = []; //LINT
Map<String, String> map = {}; //LINT
List<String> strings = []; //LINT
List<double> stringsdouble = [0.15, 0.16]; //LINT
Set<String> set = {}; //LINT

typedef Create<T> = T Function();

class AP<T> {
  AP(this.a, this.create);

  final int a;
  final Create<T> create;
}

late StreamSubscription sub;
void t() {
  final List<int> t = List.generate(10, (index) => index + 1);

  final cre = () => 'fsd';
  AP<String> ap = AP(123, cre);

  final s = Stream<double>.value(3.14);
  sub = s.listen((double event) {
    print('>> $event');
  });
  sub.cancel();

  List? list1; // = <double>[]; // LINT

// list1 = <double>[];
  list1?.add(0.15);
}

List<List>? lists; //LINT
List<int>? ints; //OK

// final funcRes = () {};
// final funcResAsync = (dynamic fggd) async {
//   return 'fsdfs $fggd';
// };
// var a = 1, b = 2, c = 'fsdfds', d = 0.15;
final x = 1; //LINT [1:5]
var xvar = 1; //LINT [1:5]
// late int x11, y11;
final xx = 3;
double y = 3.14; //LINT

const int yy = 3;

final bool bl = false;

int? lvar;

/*fsdfsd **/
late final Map? testMap;

void main() {
  String x = ''; //LINT [3:3]
  for (var i = 0; i < 10; ++i) {
    //LINT [8:3]
    print(i);
  }
  List<String> ls = <String>[];

  ls.forEach((final s1without) => print(s1without)); //LINT [15:1]
  ls.forEach((var s1final) => print(s1final)); //LINT [15:1]
  ls.forEach((s1var) => print(s1var)); //LINT [15:1]
  ls.forEach((s1dynamic) => print(s1dynamic)); //LINT [15:1]

  for (var l in ls) {
    //LINT [8:3]
    print(l);
  }
  try {
    for (final l in ls) {
      // LINT [10:5]
      print(l);
    }

    for (dynamic l in ls) {
      // LINT [10:5]
      print(l);
    }
  } on Exception catch (ex) {
    print(ex);
  } catch (e) {
    // NO warning (https://codereview.chromium.org/1427223002/)
    print(e);
  }
}

class Foo {
  static String bar = 'dsfsd'; //LINT
  static final baz = 1;
}
