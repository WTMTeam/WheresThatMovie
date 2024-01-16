import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wheres_that_movie/api/models/genre_model.dart';
import 'package:wheres_that_movie/api/models/provider_model.dart';

class OptionsDialog extends StatefulWidget {
  final Function(dynamic) onOptionSelected;
  final String button;
  final List<Provider>? currentProviders;
  final List<Genre>? currentGenres;
  final double? currentLength;
  final bool? currentLengthLessThan;
  const OptionsDialog({
    super.key,
    required this.onOptionSelected,
    required this.button,
    this.currentProviders,
    this.currentGenres,
    this.currentLength,
    this.currentLengthLessThan,
  });

  @override
  State<OptionsDialog> createState() => _OptionsDialogState();
}

class _OptionsDialogState extends State<OptionsDialog> {
  // * Provider variables
  late Future<List<Provider>> futureProviders;
  List<Provider> selectedProviders = [];

  // * Genre variables
  late Future<List<Genre>> futureGenres;
  List<Genre> selectedGenres = [];

  // * Length variables
  double selectedLength = 120.0;
  bool slectedLengthLessThan = false;

  @override
  void initState() {
    super.initState();
    // loadUsers();
    // futureUsers = UserService().getUser();
    // getAllFilms();

    // Todo:
    //  * Filter here so not all APIs are called every time
    futureProviders = ProviderService().getProviders();
    if (widget.currentProviders != null) {
      if (widget.currentProviders![0].providerName == "All Providers") {
        assignAllProviders();
      } else {
        print("There are already providers");
        selectedProviders = widget.currentProviders!;
      }
    }
    futureGenres = GenreService().getGenres();
    if (widget.currentGenres != null) {
      if (widget.currentGenres![0].genreName == "All Genres") {
        assignAllGenres();
      } else {
        selectedGenres = widget.currentGenres!;
      }
    }
    if (widget.currentLength != null) {
      selectedLength = widget.currentLength!;
    }
  }

  Future<void> assignAllProviders() async {
    selectedProviders = await futureProviders;
  }

  Future<void> assignAllGenres() async {
    selectedGenres = await futureGenres;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    TextEditingController searchController = TextEditingController();
    List<Provider> filteredProviderList = [];
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
      filteredProviderList = newProviders;
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
          List<dynamic> comparisonList = [];
          if (widget.button == "Provider") {
            comparisonList = selectedProviders;
          } else if (widget.button == "Genre") {
            comparisonList = selectedGenres;
          }
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
                      icon: comparisonList.isEmpty
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
                          if (selectAll) {
                            widget.onOptionSelected([
                              const Provider(
                                  providerID: 00,
                                  providerName: "All Providers",
                                  logoPath: "",
                                  displayPriority: 00)
                            ]);
                          } else {
                            widget.onOptionSelected(selectedProviders);
                          }
                        } else if (widget.button == "Genre") {
                          if (selectAll) {
                            widget.onOptionSelected([
                              const Genre(
                                genreID: 00,
                                genreName: "All Genres",
                              )
                            ]);
                          } else {
                            widget.onOptionSelected(selectedGenres);
                          }
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
                            padding: const EdgeInsets.only(
                                left: 12.0, right: 12.0, bottom: 8.0),
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
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
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
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    side: BorderSide(
                                        width: 2.0,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  child: const Text("Unselect All"),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    // Set all providers to selected.
                                    List<Provider> providerList =
                                        await futureProviders;
                                    setState(() {
                                      selectedProviders = providerList;
                                      selectAll = true;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(100, 40),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    side: BorderSide(
                                        width: 2.0,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  child: const Text("Select All"),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: filteredProviderList.isNotEmpty
                                ? Scrollbar(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: filteredProviderList.length,
                                      itemBuilder: ((context, index) {
                                        Provider provider =
                                            filteredProviderList[index];
                                        String imgUrl =
                                            "https://image.tmdb.org/t/p/w45${provider.logoPath}";

                                        bool isSelected = selectedProviders.any(
                                            (p) =>
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
                                                          .removeWhere((p) =>
                                                              p.providerID ==
                                                              provider
                                                                  .providerID);
                                                    }
                                                  }
                                                });
                                              }),
                                        );
                                      }),
                                    ),
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
                                                  errorWidget: (context, imgUrl,
                                                          error) =>
                                                      const Icon(
                                                          Icons
                                                              .no_photography_outlined,
                                                          size: 50),
                                                ),
                                                title:
                                                    Text(provider.providerName),
                                                trailing: Checkbox(
                                                    value: isSelected,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        if (value != null) {
                                                          if (value) {
                                                            selectedProviders
                                                                .add(provider);
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
                                                    }),
                                              );
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
                  else if (widget.button == "Genre")
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      selectedGenres = [];
                                      selectAll = false;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(100, 40),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    side: BorderSide(
                                        width: 2.0,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  child: const Text("Unselect All"),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    // Set all genres to selected.
                                    List<Genre> genreList = await futureGenres;
                                    setState(() {
                                      selectedGenres = genreList;
                                      selectAll = true;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(100, 40),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    side: BorderSide(
                                        width: 2.0,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  child: const Text("Select All"),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Scrollbar(
                              child: FutureBuilder<List<Genre>>(
                                future: futureGenres,
                                builder: ((context, AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Text("Error: ${snapshot.error}");
                                  } else {
                                    print("Snapshot: ${snapshot.data.length}");
                                    // Create two lists: one for selected providers and one for unselected providers
                                    List<Genre> selectedList = [];
                                    List<Genre> unselectedList = [];

                                    // Iterate through the snapshot data and categorize providers
                                    for (Genre genre in snapshot.data) {
                                      bool isSelected = selectedGenres.any(
                                          (g) => g.genreID == genre.genreID);

                                      if (isSelected) {
                                        selectedList.add(genre);
                                      } else {
                                        unselectedList.add(genre);
                                      }
                                    }
                                    // Combine the selected and unselected lists, placing selected providers first
                                    List<Genre> combinedList = [
                                      ...selectedList,
                                      ...unselectedList
                                    ];
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        Genre genre = combinedList[index];
                                        bool isSelected = selectedGenres.any(
                                            (g) => g.genreID == genre.genreID);
                                        return ListTile(
                                          title: Text(genre.genreName),
                                          trailing: Checkbox(
                                              value: isSelected,
                                              onChanged: (value) {
                                                setState(() {
                                                  if (value != null) {
                                                    if (value) {
                                                      selectedGenres.add(genre);
                                                    } else {
                                                      selectedGenres
                                                          .removeWhere((g) =>
                                                              g.genreID ==
                                                              genre.genreID);
                                                    }
                                                  }
                                                });
                                              }),
                                        );
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
                  else if (widget.button == "length")
                    Expanded(
                        child: Column(
                      children: [
                        CupertinoSlider(
                            value: selectedLength,
                            divisions: 6,
                            max: 180,
                            onChanged: (double value) {
                              setState(() {
                                selectedLength = value;
                              });
                            }),
                        Text(selectedLength.toString()),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text("<60min"),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text("60-90min"),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text("90-120min"),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text("120-180min"),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text(">180min"),
                        ),
                      ],
                    ))
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
