// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController taskC = TextEditingController();
  var sp = SharedPreferences.getInstance();
  List<List> x = [
    ["Hello", true],
    ['World', false]
  ];

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:addButton(context),
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: Center(child: const Text("ToDo List")),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: taskList(),
      ),
    );
  }

  ListView taskList() {
    return ListView.builder(
        itemCount: x.length,
        itemBuilder: (BuildContext context, int index) {
          //bool check = bool.parse(x[index][1].toString());
          return Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: ListTile(
              tileColor: x[index][1] == true
                  ? const Color.fromARGB(255, 141, 193, 245)
                  : Colors.grey,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                side: BorderSide(style: BorderStyle.none),
              ),
              trailing: deleteButton(index),
              leading: checkButton(index),
              title: Text(x[index][0].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    decoration: x[index][1] == true
                        ? TextDecoration.lineThrough
                        : null,
                  )),
            ),
          );
        },
      );
  }

  IconButton checkButton(int index) {
    return IconButton(
              onPressed: () {
                var bul = x[index][1];
                x[index][1] = !bul;
                setState(() {});
              },
              icon: x[index][1] == true
                  ? const Icon(
                      Icons.check_box,
                      color: Colors.black,
                    )
                  : const Icon(
                      Icons.square,
                      color: Colors.black,
                    ),
            );
  }

  IconButton deleteButton(int index) {
    return IconButton(
                onPressed: () {
                  x.remove(x[index]);
                  print('deleted item');
                  setState(() {});
                },
                icon: const Icon(
                  Icons.delete,
                  color: Color.fromARGB(255, 255, 17, 0),
                ));
  }

  Container addButton(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 21, 22, 57),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        border: Border(
          bottom: BorderSide(width: 2),
          top: BorderSide(width: 2),
          left: BorderSide(width: 2),
          right: BorderSide(width: 2),
        ),
      ),
      height: 60,
      width: 60,
      child: IconButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return addDialog(context);
                });
            // print(taskC);
            // x.add([taskC.text,false]);
            // x.add(['moneyy', true]);
            setState(() {
              print(x);
            });
          },
          icon: const Icon(Icons.add,
              color: Color.fromARGB(255, 255, 255, 255), size: 30)),
    );
  }

  Dialog addDialog(BuildContext context) {
    return Dialog(
                  child: Container(
                    height: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(),
                          bottom: BorderSide(),
                          left: BorderSide(),
                          right: BorderSide()),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        TextField(
                          controller: taskC,
                          autofocus: true,
                          onSubmitted: (value) {
                            if (value.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("!!Enter the Task!!")));
                            } else {
                              x.add([value, false]);
                            }
                            print(x);
                            setState(() {});
                            Navigator.pop(context);
                          },
                        ),
                        IconButton(
                            onPressed: () async {
                          
                              if (taskC.text != null) {
                                x.add([taskC.text, false]);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("!!Enter the Task!!")));
                              }

                              print(x);
                              setState(() {});
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.check)),
                        const Text('*****'),
                      ],
                    ),
                  ),
                );
  }

  void addResult() async {}
}
