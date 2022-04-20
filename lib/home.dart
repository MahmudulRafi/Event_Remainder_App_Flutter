import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SharedPreferences? sharedPreferences;
  String? email;
  String? task;
  List taskArray = [];
  final taskController = TextEditingController();

  getSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    email = sharedPreferences?.getString("email");
    task = sharedPreferences?.getString("task");
    setState(() {});
  }

  @override
  void initState() {
    getSharedPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text('Welcome'),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  final SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.remove("email");
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => Login()));
                },
              ),
              // add more IconButton
            ],
          ),
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child: Column(children: [
                  const Padding(
                    padding: EdgeInsets.only(
                        top: 20, bottom: 10, right: 50, left: 50),
                    child: CircleAvatar(
                      radius: 34,
                      backgroundColor: Colors.deepOrange,
                      child: CircleAvatar(
                        radius: 33,
                        backgroundImage: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2lgDguQcZmHjor0eEKenJYpNn69G7-dKxSQ&usqp=CAU"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 20, left: 28, right: 28, bottom: 10),
                    child: Text("Hello! " + email.toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 23,
                            fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 35, left: 28, right: 28, bottom: 10),
                    child: TextField(
                      controller: taskController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Your Task',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        sharedPreferences?.setString(
                            "task", taskController.text);
                        task = sharedPreferences?.getString("task");
                        taskArray.add(task.toString());
                        taskController.text = "";
                      });
                      print(task.toString());
                    },
                    child: const Text("Add"),
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(110, 30),
                        primary: Colors.deepOrange),
                  )
                ]),
              ),
              Expanded(
                flex: 1,
                child: ListView.builder(
                  itemCount: taskArray.length,
                  itemBuilder: (ctx, index) {
                    return ListTile(
                        title: Text(taskArray[index].toString()),
                        subtitle: Text("Event Reminder"),
                        leading: GestureDetector(
                            onTap: () {
                              taskController.text = taskArray[index].toString();
                              setState(() {});
                            },
                            child: Icon(Icons.ballot)),
                        trailing: GestureDetector(
                            onTap: () {
                              taskArray.removeAt(index);
                              setState(() {});
                            },
                            child: Icon(Icons.delete)));
                  },
                  padding: const EdgeInsets.all(8),
                ),
              ),
            ],
          ),
        ));
  }
}
