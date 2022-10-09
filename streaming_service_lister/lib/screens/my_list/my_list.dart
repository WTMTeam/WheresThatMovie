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
import 'package:streaming_service_lister/widgets/my_container.dart';

//import '../../widgets/my_container.dart';

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

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    BackButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => const MyLoggedIn(),
                        //   ),
                        // );
                      }
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25.0,
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
                    //print(myController.text);
                    //print(myList);
                    // Update the state of the widget when an item is added to the list
                    setState(() {
                      myList.add(myController.text);
                      myList.sort();
                      //key: UniqueKey();
                    });
                  }                                   
                ),
                
                const SizedBox(
                  height: 25.0,
                ),
                Row(
                  children: <Widget>[
                    Expanded(child: 
                      //MyListContainer(),
                      //MyContainer(child: Column()),
                      MyContainer(
                        child: Column(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                // Check if myList is empty 
                                myList.isEmpty? 
                                  Text(
                                    "Add a Movie or Show",
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ):
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0,),
                                    child: Text(
                                      "Your List",
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                    key: UniqueKey(),
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemCount: myList.length,
                                    itemBuilder: ((context, index) {
                                      return ListTile(
                                        dense: true,
                                        visualDensity: const VisualDensity(vertical: 0.0),
                                        title: Text(
                                          myList[index],
                                          style: TextStyle(
                                            color: Theme.of(context).primaryColor,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        trailing: IconButton(
                                          onPressed: (){
                                            setState(() {
                                              print("before");
                                              print(myList);
                                              myList.remove(myList[index]);
                                              print("after");
                                              print(myList);
                                            });
                                          },
                                          icon: const Icon(Icons.delete_outline)
                                        ),
                                      );
                                    }),  
                                  ),
                              ],
                            )
                          ],
                        )
                      )
                    )
                  ],
                ),
                const SizedBox(
                  height: 25.0,
                ),
                //const MyListContainer(),
                
              ],
            )
          )
        ]
      ),
    
    );
  }
}
