// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({
    super.key,
  });

  @override
  State<HomePage1> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage1> {
  TextEditingController taskC = TextEditingController();

  List<String> x = ["Hello", 'World'];
  List<String> y = ['true', 'false'];
  late String task;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
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
            onPressed: () async {
              dialogBox(context);
              // print(taskC);
              // x.add([taskC.text,false]);
              // x.add(['moneyy', true]);
              setState(() {
                print(x);
              });
            },
            icon: const Icon(Icons.add,
                color: Color.fromARGB(255, 255, 255, 255), size: 30)),
      ),
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: Center(child: const Text("ToDo List")),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: x.length,
          itemBuilder: (BuildContext context, int index) {
            //bool check = bool.parse(x[index][1].toString());
            return Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: ListTile(
                tileColor: y[index] == 'true'
                    ? const Color.fromARGB(255, 141, 193, 245)
                    : Colors.grey,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  side: BorderSide(style: BorderStyle.none),
                ),
                trailing: IconButton(
                    onPressed: () async {
                      x.remove(x[index]);
                      y.remove(y[index]);
                      await setData();
                      print('deleted item');
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Color.fromARGB(255, 255, 17, 0),
                    )),
                leading: IconButton(
                  onPressed: () async {
                    if (y[index] == 'true') {
                      y[index] = 'false';
                    } else {
                      y[index] = 'true';
                    }
                    await setData();
                  },
                  icon: y[index] == 'true'
                      ? const Icon(
                          Icons.check_box,
                          color: Colors.black,
                        )
                      : const Icon(
                          Icons.square,
                          color: Colors.black,
                        ),
                ),
                title: Text(x[index].toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      decoration: y[index] == 'true'
                          ? TextDecoration.lineThrough
                          : null,
                    )),
              ),
            );
          },
        ),
      ),
    );
  }

  dialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              height: MediaQuery.of(context).size.height / 5,
              // decoration: const BoxDecoration(
              //   border: Border(
              //       top: BorderSide(),
              //       bottom: BorderSide(),
              //       left: BorderSide(),
              //       right: BorderSide()),
              // ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 10),
                  const Text('Add the Task', style: TextStyle(fontSize: 20)),
                  Container(
                    // margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: TextField(
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                      onSubmitted: (value) {
                        task = value;
                        if (value.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("!!Enter the Task!!")));
                        } else {
                          x.add(value);
                          y.add('false');
                          // var prefs = await SharedPreferences.getInstance();
                          // prefs.setStringList('x', x);
                          // prefs.setStringList('y', y);
                          // setState(() {});
                          setData();
                        }
                        taskC.clear();
                        Navigator.of(context).pop();
                      },
                      decoration: InputDecoration(
                          labelStyle: Theme.of(context).textTheme.labelMedium),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        if (mounted) {
                          Navigator.of(context).pop();
                        }

                        if (task != null) {
                          x.add(task);
                          y.add('false');
                          setData();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("!!Enter the Task!!")));
                        }

                        print(x);
                        setState(() {});
                      },
                      icon: const Icon(Icons.check)),
                ],
              ),
            ),
          );
        });
  }

  Future<void> setData() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setStringList('x', x);
    prefs.setStringList('y', y);
    setState(() {});
  }

  void getData() async {
    var prefs = await SharedPreferences.getInstance();
    x = prefs.getStringList('x')!;
    y = prefs.getStringList('y')!;
    setState(() {});
  }
}
