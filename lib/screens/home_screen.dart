import 'package:flutter/material.dart';
import 'package:to_do_app/constants/colors.dart';
import 'package:to_do_app/models/gossip.dart';
import 'package:to_do_app/widgets/gossip_item.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final gossipList = Gossip.gossipList();
  List<Gossip> _foundGossip = [];
  final _gossipController = TextEditingController();

  @override
  void initState() {
    _foundGossip = gossipList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: AppBar(
        backgroundColor: tdBGColor,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
        ),
        actions: const [
          Icon(
            Icons.account_circle_rounded,
            color: tdBlack,
            size: 30,
          ),
        ],
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50, bottom: 20),
                        child: const Text(
                          'All Gossips',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      for (Gossip gossip in _foundGossip.reversed)
                        GossipItem(
                          gossip: gossip,
                          onGossipChange: _handleGossipChange,
                          onDeleteItem: _deleteGossipItem,
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                      left: 20,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10,
                            spreadRadius: 0),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _gossipController,
                      decoration: const InputDecoration(
                        hintText: 'Add a new gossip',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      _addGossipItem(_gossipController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: tdBlue,
                      minimumSize: const Size(60, 60),
                      elevation: 10,
                    ),
                    child: const Text(
                      '+',
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleGossipChange(Gossip gossip) {
    setState(() {
      gossip.isDone = !gossip.isDone;
    });
  }

  void _deleteGossipItem(String id) {
    setState(() {
      gossipList.removeWhere((item) => item.id == id);
    });
  }

  void _addGossipItem(String gossip) {
    setState(() {
      gossipList.add(
        Gossip(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          gossipText: gossip,
        ),
      );
    });

    _gossipController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<Gossip> results = [];

    if (enteredKeyword.isEmpty) {
      results = gossipList;
    } else {
      results = gossipList
          .where((item) => item.gossipText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundGossip = results;
    });
  }

  Widget searchBox() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: TextField(
          onChanged: (value) => _runFilter(value),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: tdBlack,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
            border: InputBorder.none,
            hintText: 'Buscar',
            hintStyle: TextStyle(color: tdGrey),
          ),
        ));
  }
}
