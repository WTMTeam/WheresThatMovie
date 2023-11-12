import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wheres_that_movie/api/models/provider_model.dart';

class OptionsDialog extends StatefulWidget {
  final Function(dynamic) onOptionSelected;
  final String button;
  const OptionsDialog({
    super.key,
    required this.onOptionSelected,
    required this.button,
  });

  @override
  State<OptionsDialog> createState() => _OptionsDialogState();
}

class _OptionsDialogState extends State<OptionsDialog> {
  // * Provider variables
  late Future<List<Provider>> futureProviders;
  List<Provider> selectedProviders = [];

  // * Length variables

  // * Genre variables

  @override
  void initState() {
    super.initState();
    // loadUsers();
    // futureUsers = UserService().getUser();
    // getAllFilms();
    futureProviders = ProviderService().getProviders();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    TextEditingController searchController = TextEditingController();
    List<Provider> filteredList = [];
    String searchQuery = '';

    Future<void> filterProviders(String query) async {
      print("Query: $query");
      List<Provider> providers = await futureProviders;
      List<Provider> newProviders = [];
      for (Provider provider in providers) {
        if (provider.providerName.toLowerCase().contains(query.toLowerCase())) {
          print(provider.providerName);
          newProviders.add(provider);
        }
      }
      filteredList = newProviders;
    }

    String alertTitle = "";
    if (widget.button == "Provider") {
      alertTitle = "Streaming Service";
    } else if (widget.button == "Genre") {
      alertTitle = "Genre";
    } else if (widget.button == "movieOrShow") {
      alertTitle = "Movie or TV-Show";
    } else if (widget.button == "length") {
      alertTitle = "Choose Length";
    }

    return AlertDialog(
      // scrollable: true,
      backgroundColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      // title: Text(alertTitle),
      insetPadding: const EdgeInsets.all(0.0),
      contentPadding: const EdgeInsets.all(0.0),
      content: StatefulBuilder(
        builder: ((context, setState) {
          double contentHeight = MediaQuery.of(context).size.height * 0.6;
          return SingleChildScrollView(
            child: SizedBox(
              width: screenWidth / 1.2,
              height: contentHeight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    // heightFactor: 0.35,
                    alignment: Alignment.topRight,
                    // alignment: const Alignment(1.0, -1.0),
                    child: IconButton(
                      splashRadius: 10,
                      padding: const EdgeInsets.all(0.0),
                      icon: selectedProviders.isEmpty
                          ? Icon(
                              CupertinoIcons.xmark_circle,
                              size: 30,
                              color: Theme.of(context).primaryColor,
                            )
                          : Icon(
                              CupertinoIcons.check_mark_circled,
                              size: 30,
                              color: Colors.green.shade800,
                            ),
                      onPressed: () {
                        if (widget.button == "Provider" &&
                            selectedProviders.isNotEmpty) {
                          widget.onOptionSelected(selectedProviders);
                        }

                        Navigator.pop(context);
                      },
                    ),
                  ),

                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          alertTitle,
                          style: Theme.of(context).textTheme.displayLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),

                  const Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                    child: Divider(
                      thickness: 5.0,
                      // color: Colors.red,
                    ),
                  ),

                  // * If the Provider Button was pressed
                  if (widget.button == "Provider")
                    Expanded(
                      child: Column(
                        children: [
                          TextField(
                            controller: searchController,
                            onChanged: (value) {
                              setState(() {
                                searchQuery = value;
                                filterProviders(value);
                              });
                            },
                            onEditingComplete: () {
                              // print(searchController.text);
                              // print("Search Query: $searchQuery");
                              // setState(
                              //   () {
                              //     filterProviders(searchQuery);
                              //   },
                              // );
                              // filterProviders(searchQuery);
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                              currentFocus.unfocus();
                            },
                            decoration: InputDecoration(
                              labelText: 'Search Providers',
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                          Expanded(
                            child: filteredList.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: filteredList.length,
                                    itemBuilder: ((context, index) {
                                      Provider provider = filteredList[index];
                                      String imgUrl =
                                          "https://image.tmdb.org/t/p/w45${provider.logoPath}";
                                      bool isSelected =
                                          selectedProviders.contains(provider);
                                      return ListTile(
                                          leading: CachedNetworkImage(
                                            imageUrl: imgUrl,
                                            width: 50.0,
                                            errorWidget: (context, imgUrl,
                                                    error) =>
                                                const Icon(
                                                    Icons
                                                        .no_photography_outlined,
                                                    size: 50),
                                          ),
                                          title: Text(provider.providerName),
                                          subtitle: Text(provider
                                              .displayPriority
                                              .toString()),
                                          trailing: Checkbox(
                                              value: isSelected,
                                              onChanged: (value) {
                                                setState(() {
                                                  if (value != null) {
                                                    if (value) {
                                                      selectedProviders
                                                          .add(provider);
                                                    } else {
                                                      selectedProviders
                                                          .remove(provider);
                                                    }
                                                  }
                                                });
                                              }));
                                    }))
                                : FutureBuilder<List<Provider>>(
                                    future: futureProviders,
                                    builder:
                                        ((context, AsyncSnapshot snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        return Text("Error: ${snapshot.error}");
                                      } else {
                                        print(
                                            "Snapshot: ${snapshot.data.length}");
                                        return ListView.builder(
                                          // physics: const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            Provider provider =
                                                snapshot.data?[index];

                                            String imgUrl =
                                                "https://image.tmdb.org/t/p/w45${provider.logoPath}";
                                            bool isSelected = selectedProviders
                                                .contains(provider);
                                            return ListTile(
                                                leading: CachedNetworkImage(
                                                  imageUrl: imgUrl,
                                                  width: 50.0,
                                                  errorWidget: (context, imgUrl,
                                                          error) =>
                                                      const Icon(
                                                          Icons
                                                              .no_photography_outlined,
                                                          size: 50),
                                                ),
                                                title:
                                                    Text(provider.providerName),
                                                subtitle: Text(provider
                                                    .displayPriority
                                                    .toString()),
                                                trailing: Checkbox(
                                                    value: isSelected,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        if (value != null) {
                                                          if (value) {
                                                            selectedProviders
                                                                .add(provider);
                                                          } else {
                                                            selectedProviders
                                                                .remove(
                                                                    provider);
                                                          }
                                                        }
                                                      });
                                                    }));
                                          },

                                          itemCount: snapshot.data.length,
                                        );
                                      }
                                    }),
                                  ),
                          ),
                        ],
                      ),
                    )
                  else
                    const Text("test")
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
