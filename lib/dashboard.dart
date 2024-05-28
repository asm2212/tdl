import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Dashboard extends StatefulWidget {
  final String token;

  const Dashboard({required this.token, Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late String userId;
  final TextEditingController _todoTitleController = TextEditingController();
  final TextEditingController _todoDescController = TextEditingController();
  List? items;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
    getTodoList(userId);
  }

  Future<void> addTodo() async {
    if (_todoTitleController.text.isNotEmpty && _todoDescController.text.isNotEmpty) {
      var regBody = {
        "userId": userId,
        "title": _todoTitleController.text,
        "desc": _todoDescController.text
      };

      var response = await http.post(Uri.parse(addtodo),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));

      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse['status']) {
        _todoDescController.clear();
        _todoTitleController.clear();
        Navigator.pop(context);
        getTodoList(userId);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Something went wrong, please try again.')),
        );
      }
    }
  }

  Future<void> getTodoList(String userId) async {
    var regBody = {
      "userId": userId
    };

    var response = await http.post(Uri.parse(getToDoList),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody));

    var jsonResponse = jsonDecode(response.body);
    items = jsonResponse['success'];

    setState(() {});
  }

  Future<void> deleteItem(String id) async {
    var regBody = {
      "id": id
    };

    var response = await http.post(Uri.parse(deleteTodo),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody));

    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status']) {
      getTodoList(userId);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete the item, please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeader(),
          Expanded(
            child: buildTodoList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayTextInputDialog(context),
        child: Icon(Icons.add),
        tooltip: 'Add To-Do',
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      padding: EdgeInsets.only(top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            child: Icon(Icons.list, size: 30.0),
            backgroundColor: Colors.white,
            radius: 30.0,
          ),
          SizedBox(height: 10.0),
          Text(
            'ToDo with NodeJS + MongoDB',
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 8.0),
          Text(
            '${items?.length ?? 0} Task${items?.length == 1 ? '' : 's'}',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget buildTodoList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: items == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: items!.length,
                itemBuilder: (context, index) {
                  return buildTodoItem(index);
                },
              ),
      ),
    );
  }

  Widget buildTodoItem(int index) {
    return Slidable(
      key: ValueKey(items![index]['_id']),
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              deleteItem('${items![index]['_id']}');
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Card(
        borderOnForeground: false,
        child: ListTile(
          leading: Icon(Icons.task),
          title: Text('${items![index]['title']}'),
          subtitle: Text('${items![index]['desc']}'),
          trailing: Icon(Icons.arrow_back),
        ),
      ),
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add To-Do'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTextField(_todoTitleController, 'Title'),
              buildTextField(_todoDescController, 'Description'),
              ElevatedButton(
                onPressed: addTodo,
                child: Text("Add"),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildTextField(TextEditingController controller, String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      ).p4().px8(),
    );
  }
}

