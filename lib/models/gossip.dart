class Gossip {
  String? id;
  String? gossipText;
  bool isDone;

  Gossip({
    required this.id,
    required this.gossipText,
    this.isDone = false,
  });

  static List<Gossip> gossipList() {
    return [
      Gossip(id: '01', gossipText: 'Check all data'),
      Gossip(id: '02', gossipText: 'Check the email'),
      Gossip(id: '03', gossipText: 'Go to the bank'),
      Gossip(id: '04', gossipText: 'Check all the homework'),
      Gossip(id: '05', gossipText: 'Check the water fall'),
      Gossip(id: '06', gossipText: 'Go to the store'),
    ];
  }
}
