import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dairy.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: MyHomePage(title: '日記'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Data {
  String title;
  final String text;
  final  String day;

  Data({this.title, this.text,this.day});
}

class _MyHomePageState extends State<MyHomePage> {
  List<Data> dataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          itemExtent: 70,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DairyPage(
                            data: dataList[index],
                            onSaved: (newData) {
                              setState(() {
                                dataList[index] = newData;
                              });
                            },
                          )),
                );
              },
              onLongPress: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        children: [
                          Column(children: [
                            Container(
                                padding: EdgeInsets.all(16),
                                child: Text('削除しますか？')),
                            Container(
                              padding: EdgeInsets.all(4),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  onPrimary: Colors.white60,
                                ),
                                child: Text('はい'),
                                onPressed: () {
                                  setState(() {
                                    dataList.removeAt(index);
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(4),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  onPrimary: Colors.white60,
                                ),
                                child: Text('いいえ'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ]),
                        ],
                      );
                    });
              },
              child: Card(
                margin: EdgeInsets.all(4),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Text(dataList[index].day),
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        dataList[index].title,
                        style: TextStyle(
                          height: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: dataList.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DairyPage(
                      onSaved: (value) {
                        setState(() {
                          dataList.add(value);
                        });
                      },
                    )),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white60,
        ),
      ),
    );
  }
}
