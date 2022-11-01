// my_list.dart
// Author: Samuel Rudqvist
// Date Created: 09/19/2022
//

//********************************************************************//
//*       This is the screen the user will see when logged in        *//
//*           and clicked on My List in the settings drawer          *//
//********************************************************************//


import 'package:flutter/material.dart';
import 'package:streaming_service_lister/screens/my_list/local_widgets/my_list_container.dart';



class MyList extends StatefulWidget {
  const MyList({Key? key}) : super(key: key);

  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  final myController = TextEditingController();
  final List<String> myList = [];

  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is disposed.
  //   myController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(10.0)
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     BackButton(
                //       onPressed: () {
                //         Navigator.pop(context);
                //       }
                //     ),
                //   ],
                // ),
                const SizedBox(
                  height: 50.0,
                ),

                Text(
                  "Search Movie or Show",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 15.0,
                ),

                TextFormField(
                  controller: myController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.search_outlined,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 25.0,
                ),

                ElevatedButton(
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 100.0),
                    child: Text(
                      "Add",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  onPressed: (){
                    // Update the state of the widget when an item is added to the list
                    setState(() {
                      myController.text.isEmpty?
                      // does not show
                        const Text(
                          "Can't add empty show",
                        ):
                        myList.add(myController.text);
                        myList.sort();
                      //key: UniqueKey();
                    });
                  }                                   
                ),
                
                const SizedBox(
                  height: 25.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: MyListContainer(
                    myList: myList,
                    onRemoved: (itemToRemove){
                      setState(() {
                        print("before");
                        print(myList);
                        myList.remove(itemToRemove);
                        print("after");
                        print(myList);
                      });
                    }
                  ),
                ),

                MyListContainer(
                  myList: myList,
                  // Get the item to be removed and update the state
                  onRemoved: (itemToRemove){
                    setState(() {
                      myList.remove(itemToRemove);
                    });
                  },
                ),

                const SizedBox(
                  height: 25.0,
                ),

              ],
            )
          )
        ]
      ),
    
    );
  }
}
