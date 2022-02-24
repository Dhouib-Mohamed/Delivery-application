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
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
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
        actions: [
          IconButton(
            color: Colors.blueGrey,
            onPressed: () {
              _key.currentState!.openEndDrawer();
            },
            icon: const Icon(
              Icons.wrap_text_rounded,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: const Color(0xffbd2005),
        title: const Text(
          "Search",
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
      ),
      bottomNavigationBar: const BotBar(i: 1),
      endDrawer: const EndDrawer(),
    );
  }
}
