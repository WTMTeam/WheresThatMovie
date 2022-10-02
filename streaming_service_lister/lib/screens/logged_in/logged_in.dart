// logged_in.dart
// Author: Samuel Rudqvist
// Date Created: 09/10/2022
//

//********************************************************************//
//*       This is the screen the user will see when logged in        *//
//********************************************************************//

import 'package:flutter/material.dart';
import 'package:streaming_service_lister/screens/landing_page/landing.dart';
import 'package:streaming_service_lister/screens/logged_in/local_widgets/service_selector.dart';
import 'package:streaming_service_lister/screens/my_list/my_list.dart';


class MyLoggedIn extends StatefulWidget {
  const MyLoggedIn({Key? key}) : super(key: key);

  @override
  State<MyLoggedIn> createState() => _MyLoggedInState();
}

class _MyLoggedInState extends State<MyLoggedIn> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Used for opening the drawer header
      key: _scaffoldKey,

      // The settings button
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        foregroundColor: Colors.white,
        elevation: 0.0,
        onPressed: (){
              _scaffoldKey.currentState?.openDrawer();
        },
        child: const Icon(
          Icons.menu,
          size: 30.0,
        ),
      ),

      // Setting the location of the settings button
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,

      body: 
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(10.0),
                ),

                const SizedBox(
                  height: 100.0,
                ),

                

                Text(
                  "Search for a movie or tv-show",
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
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.search_outlined,
                      //color: Theme.of(context).secondary,
                    ),
                    //focusColor: Colors.red,
                  ),
                  //autofocus: true,
                ),

                const SizedBox(
                  height: 25.0,
                ),
                const MyServiceSelector(),
                
                const SizedBox(
                  height: 25.0,
                ),

                ElevatedButton(
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 100.0),
                    child: Text(
                      "Search",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),                
                  ),                  
                  onPressed: (){},                   
                ),

              ],
            ),
          ),
        ],
      ),

      // Settings Menu
      drawer: Drawer(
        //width: 200,
        
        child: Column(
          children: <Widget>[
            Expanded(child: 
              ListView(
                padding: const EdgeInsets.symmetric(vertical: 70.0, horizontal: 10.0),
                children: [            
                  Row(
                    children: const <Widget>[
                      Icon(
                        Icons.account_circle_rounded,
                        size: 50.0,
                      ),
                      // Add space between the logo and the username
                      SizedBox(width: 10.0,),
                      // Add the logged in users name
                      Text(
                        "username",
                        style: TextStyle(
                          fontSize: 30.0
                        ),
                      ),                
                    ],
                  ),

                  // ListTile(
                  //   leading: Icon(
                  //     Icons.account_circle_outlined,
                  //     size: 50.0,
                  //   ),
                  //   title: Text(
                  //     "username",
                  //     style: TextStyle(
                  //       fontSize: 30.0,
                  //     ),
                  //   ),
                  //   // trailing: Text(
                  //   //   "username",
                  //   //   style: TextStyle(
                  //   //     fontSize: 20.0,
                  //   //   ),
                  //   // ),
                  // ),
                  
                  // Add some space between the username/logo and the first option
                  const SizedBox(height: 20.0,),
                  
                  Card(
                    //color: Theme.of(context).,
                    child: ListTile(
                      title: const Text(
                        "My List",
                        style: TextStyle(
                          fontSize: 20.0
                        ),
                      ),
                      trailing: const Icon(Icons.list),
                      onTap: () {
                        // Update the state of the app
                        // ...
                        // Then close the drawer
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const MyList(),
                          )
                        );
                      },
                    ),
                  ),
                  
                  Card(
                    child: ListTile(
                      title: const Text(
                        "Notifications",
                        style: TextStyle(
                          fontSize: 20.0
                        ),
                      ),
                      trailing: const Icon(Icons.notifications),
                      onTap: () {
                        // Update the state of the app
                        // ...
                        // Then close the drawer
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],          
              ),
            ),
            
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsetsDirectional.only(bottom: 75.0),
              child: Card(
                child: ListTile(
                  title: const Text(
                    "Log Out",
                    style: TextStyle(
                      fontSize: 20.0
                    ),
                  ),
                  trailing: const Icon(
                    Icons.logout_rounded,
                  ),
                  //style: ListTileTheme.of(context),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MyLanding(),
                      )
                    );
                  },
                ),
              ),
            ),
          ],

        )
        
        
        
        
      ),
    );
  }
}

