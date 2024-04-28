import 'package:flutter/material.dart';
import 'package:to_do_app/constants/colors.dart';
import 'package:to_do_app/models/gossip.dart';

class GossipItem extends StatelessWidget {
  final Gossip gossip;
  final onGossipChange;
  final onDeleteItem;

  const GossipItem(
      {super.key,
      required this.gossip,
      this.onGossipChange,
      this.onDeleteItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onGossipChange(gossip);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.white,
        leading: Icon(
          gossip.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: tdBlue,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        title: Text(
          gossip.gossipText!,
          style: TextStyle(
            fontSize: 16,
            color: tdBlack,
            decoration: gossip.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            onPressed: () {
              onDeleteItem(gossip.id);
            },
            icon: const Icon(Icons.delete),
            color: Colors.white,
            iconSize: 18,
          ),
        ),
      ),
    );
  }
}
