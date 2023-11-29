import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wheres_that_movie/api/models/provider_model.dart';

class OptionsDialog extends StatefulWidget {
  final Function(dynamic) onOptionSelected;
  final String button;
  final List<Provider>? currentProviders;
  const OptionsDialog({
    super.key,
    required this.onOptionSelected,
    required this.button,
    this.currentProviders,
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
    if (widget.currentProviders != null) {
      print("There are already providers");
      selectedProviders = widget.currentProviders!;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    TextEditingController searchController = TextEditingController();
    List<Provider> filteredList = [];
    // ignore: unused_local_variable
    String searchQuery = '';
    bool selectAll = false;

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
      backgroundColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
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
                    alignment: Alignment.topRight,
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
                        if (widget.button == "Provider") {
                          widget.onOptionSelected(selectedProviders);
                          // ! Todo: if selectAll, send back something so that it only displays a text saying all providers are selected.
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
                    padding: EdgeInsets.all(8.0),
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
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: TextField(
                              controller: searchController,
                              onChanged: (value) {
                                setState(() {
                                  // searchQuery = value;
                                  filterProviders(value);
                                });
                              },
                              onEditingComplete: () {
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                currentFocus.unfocus();
                              },
                              decoration: InputDecoration(
                                labelText: 'Search Providers',
                                prefixIcon: const Icon(Icons.search),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    searchController.clear();
                                    setState(
                                      () {
                                        filterProviders("");
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.clear),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                  onPressed: () async {
                                    // Set all providers to selected.
                                    List<Provider> providerList =
                                        await futureProviders;
                                    // for (Provider provider in providerList) {
                                    //   selectedProviders.add(provider);
                                    // }
                                    setState(() {
                                      selectedProviders = providerList;
                                      selectAll = true;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(100, 40),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                      side: BorderSide(
                                          width: 2.0,
                                          color:
                                              Theme.of(context).primaryColor)),
                                  child: Text("Select All")),
                              ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      selectedProviders = [];
                                      selectAll = false;
                                    });

                                  },
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(100, 40),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                      side: BorderSide(
                                          width: 2.0,
                                          color:
                                              Theme.of(context).primaryColor)),
                                  child: Text("Unselect All")),
                            ],
                          ),
                          Expanded(
                            child: filteredList.isNotEmpty
                                ? Scrollbar(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: filteredList.length,
                                        itemBuilder: ((context, index) {
                                          Provider provider =
                                              filteredList[index];
                                          String imgUrl =
                                              "https://image.tmdb.org/t/p/w45${provider.logoPath}";

                                          bool isSelected =
                                              selectedProviders.any((p) =>
                                                  p.providerID ==
                                                  provider.providerID);
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
                                                              .removeWhere((p) =>
                                                                  p.providerID ==
                                                                  provider
                                                                      .providerID);
                                                        }
                                                      }
                                                    });
                                                  }));
                                        })),
                                  )
                                : Scrollbar(
                                    child: FutureBuilder<List<Provider>>(
                                      future: futureProviders,
                                      builder:
                                          ((context, AsyncSnapshot snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              "Error: ${snapshot.error}");
                                        } else {
                                          print(
                                              "Snapshot: ${snapshot.data.length}");
                                          // Create two lists: one for selected providers and one for unselected providers
                                          List<Provider> selectedList = [];
                                          List<Provider> unselectedList = [];

                                          // Iterate through the snapshot data and categorize providers
                                          for (Provider provider
                                              in snapshot.data) {
                                            bool isSelected =
                                                selectedProviders.any((p) =>
                                                    p.providerID ==
                                                    provider.providerID);

                                            if (isSelected) {
                                              selectedList.add(provider);
                                            } else {
                                              unselectedList.add(provider);
                                            }
                                          }
                                          // Combine the selected and unselected lists, placing selected providers first
                                          List<Provider> combinedList = [
                                            ...selectedList,
                                            ...unselectedList
                                          ];
                                          return ListView.builder(
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              // Provider provider =
                                              //     snapshot.data?[index];
                                              Provider provider =
                                                  combinedList[index];

                                              String imgUrl =
                                                  "https://image.tmdb.org/t/p/w45${provider.logoPath}";
                                              bool isSelected =
                                                  selectedProviders.any((p) =>
                                                      p.providerID ==
                                                      provider.providerID);
                                              return ListTile(
                                                  leading: CachedNetworkImage(
                                                    imageUrl: imgUrl,
                                                    width: 50.0,
                                                    errorWidget: (context,
                                                            imgUrl, error) =>
                                                        const Icon(
                                                            Icons
                                                                .no_photography_outlined,
                                                            size: 50),
                                                  ),
                                                  title: Text(
                                                      provider.providerName),
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
                                                                  .add(
                                                                      provider);
                                                            } else {
                                                              // selectedProviders
                                                              //     .remove(
                                                              //         provider);
                                                              selectedProviders
                                                                  .removeWhere((p) =>
                                                                      p.providerID ==
                                                                      provider
                                                                          .providerID);
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
