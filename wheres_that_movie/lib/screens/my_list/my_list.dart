// my_list.dart
// Author: Samuel Rudqvist
// Date Created: 09/19/2022
//

//********************************************************************//
//*       This is the screen the user will see when logged in        *//
//*           and clicked on My List in the settings drawer          *//
//********************************************************************//

import 'package:flutter/material.dart';
import 'package:wheres_that_movie/database/database_helper.dart';
import 'package:wheres_that_movie/screens/my_list/local_widgets/my_list_container.dart';

class MyList extends StatefulWidget {
  const MyList({Key? key}) : super(key: key);

  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  final myController = TextEditingController();
  //final List<String> myList = [];

  List<Map<String, dynamic>> myList = [];
  bool _isLoading = true;

  void _refreshList() async {
    final data = await SQLHelper.getMovies();

    setState(() {
      myList = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshList();
  }

  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is disposed.
  //   myController.dispose();
  //   super.dispose();
  // }

  // Insert a new journal to the database
  // Future<void> _addItem(int movieId) async {
  //   print("adding item: ");
  //   print(myController.text);
  //   await SQLHelper.createItem(movieId);
  //   _refreshList();
  // }

  // Delete an item
  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    print("Deleted");
    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //   content: Text('Successfully deleted a journal!'),
    // ));
    _refreshList();
  }

  ScrollController myScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Text("isLoading"),
      );
    } else {
      return Scaffold(
          body: SingleChildScrollView(
        child: Column(children: <Widget>[
          const SizedBox(
            height: 50.0,
          ),

          // Text(
          //   "Search Movie or Show",
          //   textAlign: TextAlign.center,
          //   style: TextStyle(
          //     color: Theme.of(context).primaryColor,
          //     fontSize: 20.0,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),

          // const SizedBox(
          //   height: 15.0,
          // ),

          // TextFormField(
          //   controller: myController,
          //   decoration: const InputDecoration(
          //     prefixIcon: Icon(
          //       Icons.search_outlined,
          //     ),
          //   ),
          // ),

          // const SizedBox(
          //   height: 25.0,
          // ),

          // ElevatedButton(
          //     child: const Padding(
          //       padding: EdgeInsets.symmetric(horizontal: 100.0),
          //       child: Text(
          //         "Add",
          //         style: TextStyle(
          //           fontSize: 20.0,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //     ),
          //     onPressed: () async {
          //       print("here");
          //       print(myList);

          //       myController.text.isEmpty
          //           ?
          //           // does not show
          //           const Text(
          //               "Can't add empty show",
          //             )
          //           :
          //           //myList.add(myController.text);
          //           //myList.sort();
          //           // await _addItem();
          //           print("adding removed");
          //       //key: UniqueKey();
          //     }),

          const SizedBox(
            height: 25.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: MyListContainer(
                myList: myList,
                myController: myScrollController,
                onRemoved: (itemToRemove) {
                  setState(() {
                    print("before");
                    print(myList);
                    //myList.remove(itemToRemove);
                    _deleteItem(itemToRemove);
                    //_deleteItem()
                    print("after");
                    print(myList);
                  });
                }),
          ),

          // MyListContainer(
          //   myList: myList,
          //   // Get the item to be removed and update the state
          //   onRemoved: (itemToRemove){
          //     setState(() {
          //       myList.remove(itemToRemove);
          //     });
          //   },
          // ),

          const SizedBox(
            height: 25.0,
          ),
        ]),
      ));
    }
  }
}
