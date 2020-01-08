import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  // dart 는 타입 추론형이다.
  print('hello world');
  var a = 10;
  var b = 'hi';

  myPrint(20);

  int i = 10;
  double d = 20;
  // d = i as double; // int 를 double에 넣어주려면 형변환이 필요하다.
  num n = 10; // num 타입을 사용하면 int, double 을 형변환 하지 않고 사용할 수 있다.

  final c = 20; // java의 final 과 같다. 한 번 지정하면 변경할 수 없음.
  const e = 20; // javascript의 const 처럼 사용. 재사용이 가능한 상수.

  var items = ['a', 'b', 'c']; // dart에는 배열이 없기 때문에 list임을 자동으로 추론하게 된다.
  print(items);

  var itemsSet = {1, 2, 3, 4, 1, 2, 3};
  print(itemsSet);

  var itemMap = {
    'key1' : 1,
    'key2' : 2,
    'key3' : 3,
  };
  print(itemMap);

  var items2 = [... items, 4, 5]; // spread 연산
  print(items2);

  something('choi', age: 10); // age가 옵션으로 지정되어 있긴 하지만 required 이기 때문에 쓰지 않으면 노란색 경고등이 나타난다.

  if (a is int) { // is 로 타입 체크할 수 있음.
    print('정수');
  } else {
    print('정수 아님');
  }

  String name;
  print(name); // null 이 출력된다.
  print(name ?? '널이당'); // ?? 는 변수가 null 이면 출력값을 지정해줄 수 있다.
  print(name?.toLowerCase()); // ?. 는 null optional

  var person = Person('cis', 333);
  print(person.name);
  person.language = 'java'; // setter
  print(person.language); // getter

  // future
  print('시작');
  networkRequest();
  print('끝');

  runApp(MyApp());
}

// java 의 object 같은 느낌으로 사용 가능. 어느 타입이건 다 사용할 수 있음.
myPrint(dynamic str) {

}

// {} 를 붙이면 옵션 기능이다. 파라미터를 필요할 때만 넣어주면 되나 @required 가 붙으면 넣어줘야 한다.
void something(String name, {@required int age}) {
  print('이름 : ${name}, 나이 : ${age}');
}

class Person {
  // 자바의 private 처럼 사용 하고싶다면 변수이름 앞에 _(언더바) 를 붙여주면 된다.
  String name;
  int age;
  String _language;

  Person(this.name, this.age);  // java 와는 약간 다르게 생성자를 지정할 수 있다.

  // private 으로 지정한 것들은 getter setter를 이용해서 접근하게 할 수 있다.
  String get language => '주사용 언어 : $_language';

  set language(String value) {
    _language = value;
  }
}

// class 를 implemnts 해서 사용할 수 있다. 이렇게 하면 모든것을 다 오버라이딩 해줘야 해서 불필요한 것들도 나타나게 된다.
// 이렇게 불필요한것 까지 사용하고 싶지 않다면 with 를 사용하면 된다.
class Employee implements Person {
  @override
  String _language;

  @override
  int age;

  @override
  String language;

  @override
  String name;
}

// future 개념 연습
Future networkRequest() async{
  print('네트워크 요청 시작');
  await Future.delayed(Duration(seconds: 1));
  print('1초 대기');
  await Future.delayed(Duration(seconds: 1));
  print('1초 대기');
  await Future.delayed(Duration(seconds: 1));
  print('1초 대기');
  print('네트워크 요청 끝');
}

class Page extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(onPressed: () {

        },
      ),
    );
  }
}

// stream 개념 연습
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _message = 'stream 연습';
  int _counter = 0;
  var _counterController = StreamController<int>()..add(0);

  void _incrementCounter() {
      _counter++;
      _counterController.add(_counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_message, style: TextStyle(fontSize: 30)),
            StreamBuilder<int>(
              stream: _counterController.stream,
              builder: (context, snapshot) {
                return Text('${snapshot.data}',
                  style: Theme.of(context).textTheme.display1,
                );
              }
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
