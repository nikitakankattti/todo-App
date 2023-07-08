import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoHomePage(title: 'Todo App'),
    );
  }
}

class TodoHomePage extends StatefulWidget {
  final String title;

  TodoHomePage({required this.title});

  @override
  _TodoHomePageState createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  List<TodoItem> todos = [];

  void addTodo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTodoTitle = '';
        String newTodoDescription = '';

        return AlertDialog(
          title: Text('Add Todo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  newTodoTitle = value;
                },
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                onChanged: (value) {
                  newTodoDescription = value;
                },
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  todos.add(TodoItem(
                    title: newTodoTitle,
                    description: newTodoDescription,
                    isCompleted: false,
                  ));
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void removeTodoAt(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  void toggleTodoCompleted(int index) {
    setState(() {
      todos[index].isCompleted = !todos[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: todos.isEmpty
          ? Center(
              child: Text(
                'No todos yet.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    leading: Checkbox(
                      value: todos[index].isCompleted,
                      onChanged: (value) {
                        toggleTodoCompleted(index);
                      },
                    ),
                    title: Text(
                      todos[index].title,
                      style: TextStyle(
                        fontSize: 16,
                        decoration: todos[index].isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    subtitle: todos[index].description.isNotEmpty
                        ? Text(
                            todos[index].description,
                            style: TextStyle(fontSize: 14),
                          )
                        : null,
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        removeTodoAt(index);
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTodo();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class TodoItem {
  String title;
  String description;
  bool isCompleted;

  TodoItem({
    required this.title,
    required this.description,
    required this.isCompleted,
  });
}
