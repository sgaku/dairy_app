import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:intl/intl.dart';

class DairyPage extends StatefulWidget {
  final Data data;
  final void Function(Data) onSaved;

  DairyPage({
    this.data,
    @required this.onSaved,
  });

  @override
  _DairyPageState createState() => _DairyPageState();
}

class _DairyPageState extends State<DairyPage> {
  final date = DateTime.now();
  var _value = '';

  TextEditingController textController;
  TextEditingController titleController;
  String editedText;
  String title;

  @override
  void initState() {
    super.initState();
    _value = widget.data?.day ?? "";
    editedText = widget.data?.text ?? "";
    title = widget.data?.title ?? "";
    textController = TextEditingController(text: editedText);
    titleController = TextEditingController(text: title);
  }

  Future _select() async {
    DateTime selected = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2022),
      locale: Localizations.localeOf(context),
    );
    if (selected != null) {
      setState(() {
        _value = (DateFormat.Md()).format(selected);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(_value),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_outlined),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final newData = Data(
                  title: title ?? "無題",
                  text: editedText,
                  day: _value,
                );
                widget.onSaved(newData);
                Navigator.pop(context);
              },
              tooltip: '保存',
            )
          ]),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: TextButton(
              onPressed: _select,
              child: Text('日付を選択する'),
            ),
          ),
          Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: TextField(
                autofocus: true,
                controller: titleController,
                maxLength: 20,
                decoration: InputDecoration(
                  hintText: 'タイトル',
                ),
                onChanged: (String value) {
                  title = value;
                },
              )),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: TextField(
              autofocus: true,
              controller: textController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              onChanged: (String value) {
                editedText = value;
              },
            ),
          )
        ],
      ),
    );
  }
}
