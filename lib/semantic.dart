
abstract class Animal {
  eat() {

  }
}


void main(List<String> args) {
  final n = 10;
  print('hello flutter $n');

  var list = [1, 'a', 'b', 'c', true];

  list[0] = 10;
  var last = list[list.length - 1];
  print('last = $last');

  list.add('tolly');
  list.remove(10);
  print('list = $list');

  list.insert(1, true);
  print('list = $list');

  var index = list.indexOf(true);
  print('index = $index');

  var lastIndex = list.lastIndexOf(true);
  print('lastIndex = $lastIndex');

  var numbers = [2, 1, 4, 3, 5];
  numbers.sort();

  print('numbers = $numbers');

  var any = numbers.any((num) => num > 3);
  print('any = $any');

  var every = numbers.every((num) => num < 6);
  print('every = $every');

  var res = numbers.map((num) => num * 5);
  print('res = $res');

  var plus = counter();
  var a = plus();
  print('a = $a');
  a = plus();
  print('a = $a');
  a = plus();
  print('a = $a');
  a = plus();
  print('a = $a');
  a = plus();
  print('a = $a');
  a = plus();
  print('a = $a');

  var dict = {'name': 'samuel', 'age':20, 'gender': true, 'job':'engineer'};
  dict['name'] = 'bob';
  print('dict= $dict');

  print(dict.containsKey('gender'));
  print(dict.containsValue(20));
  print(dict.isEmpty);
  print(dict.isNotEmpty);
  print(dict.length);
  dict.remove('job');
  print('dict= $dict');

  dict.forEach((k, v) => print('k = $k, v = $v'));

  int b = 10;
  print(b / 3);
  print(b ~/ 3);

  int c = 0;
  c ??= b;
  print('c = $c');
}

Function counter() {
  int num = 0;
  return () {
    return num++;
  };
}
