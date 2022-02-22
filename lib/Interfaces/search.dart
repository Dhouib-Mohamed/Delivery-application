import 'package:flutter/material.dart';
import 'package:iac_project/Widgets/parts.dart';

import '../Widgets/tapped.dart';
// TODO add search

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: const [
          Expanded(
            child: FeedInput(
              field: 'Search ',
              control: null,
              valid: null,
            ),
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xffbd2005),
        title: const Text(
          "Search",
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
      ),
      bottomNavigationBar: const BotBar(i: 1),
    );
  }
}
