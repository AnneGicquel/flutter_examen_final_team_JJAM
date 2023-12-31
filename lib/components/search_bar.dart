import 'package:flutter/material.dart';
import 'package:flutter_examen1/components/config.dart';
import 'package:flutter_examen1/models/commune.dart';
import 'package:flutter_examen1/pages/departements_page.dart';
import 'package:yaml/yaml.dart';

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({Key? key, required this.config});

  final Config config;

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  String _query = '';
  List<String> filteredItems = [];
  List<String> searchresults = [];
  bool sbHasFocus = false;
  final TextEditingController _searchController = TextEditingController();

  var searchBarHasFocus = FocusNode();

  @override
  void initState() {
    searchBarHasFocus.addListener(() {
      setState(() {
        sbHasFocus = searchBarHasFocus.hasFocus;
      });
    });
    super.initState();
  }

  void search(String query) {
    setState(
      () {
        _query = query;

        filteredItems = searchresults
            .where(
              (item) => item.toLowerCase().contains(
                    query.toLowerCase(),
                  ),
            )
            .toList();
      },
    );
  }

  void updateSearchQuery(value) {
    _searchController.text = value;
    searchBarHasFocus.requestFocus();
    search(value);
  }

  String getRegionCode(value) {
    print("Submitting $value");
    return widget.config.get("regions.$value.code");
  }

  void setRegions(YamlMap regions) {
    if (searchresults.isEmpty) {
      for (var region in regions.values) {
        setState(() {
          searchresults.add(region["nom"]);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (searchresults.isEmpty) {
      setRegions(widget.config.get("regions"));
    }

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                child: SearchBar(
                  controller: _searchController,
                  focusNode: searchBarHasFocus,
                  hintText: "Choisir une région",
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 16.0)),
                  onSubmitted: (value) {
                    print(getRegionCode(value));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DepartementsPage(
                          regionName: value,
                          regionCode: getRegionCode(value),
                        ),
                      ),
                    );
                  },
                  onChanged: (value) {
                    search(value);
                  },
                  leading: const Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 39, 108, 228),
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
        Visibility(
          visible: sbHasFocus,
          maintainSize: false,
          child: Flexible(
            child: (filteredItems.isNotEmpty || _query.isNotEmpty)
                ? filteredItems.isEmpty
                    ? Container(
                        width: 400,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),
                          color: Color.fromARGB(37, 4, 160, 232),
                        ),
                        child: const Center(
                          child: Text(
                            'No Results Found',
                            style: TextStyle(fontSize: 18),
                          ),
                        ))
                    : Container(
                        width: 400,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),
                          color: Color.fromARGB(37, 4, 160, 232),
                        ),
                        child: ListView.builder(
                          itemCount: filteredItems.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTapDown: (detail) {
                                updateSearchQuery(filteredItems[index]);
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                child: ListTile(
                                  title: Text(filteredItems[index]),
                                ),
                              ),
                            );
                          },
                        ))
                : Container(
                    width: 400,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                      color: Color.fromARGB(37, 4, 160, 232),
                    ),
                    child: ListView.builder(
                      itemCount: searchresults.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTapDown: (detail) {
                            updateSearchQuery(searchresults[index]);
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            child: ListTile(
                              title: Text(searchresults[index]),
                            ),
                          ),
                        );
                      },
                    )),
          ),
        ),
      ],
    );
  }
}
