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
                  //controller: myController,
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
                  onPressed: (){}                                   
                ),
                
                
                const SizedBox(
                  height: 25.0,
                ),
                Row(
                  children: const <Widget>[
                    Expanded(child: 
                      MyListContainer(),
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
