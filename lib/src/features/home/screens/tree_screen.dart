import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphview/GraphView.dart';
import 'package:mine_profile/src/core/utils/telegram_page.dart';
import 'package:mine_profile/src/features/auth/models/user.dart';
import 'package:mine_profile/src/features/home/models/family_tree.dart';

class TreeViewScreen extends StatefulWidget {
  const TreeViewScreen(this.id, {super.key});
  final int id;

  @override
  State<TreeViewScreen> createState() => _TreeViewScreenState();
}

class _TreeViewScreenState extends State<TreeViewScreen> {
  Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  final dio = Dio();
  HashMap<int, User> users = HashMap();

  Widget rectangleWidget(User user) {
    return InkWell(
      onTap: () => openTelegramPage("https://t.me/${user.username}"),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: const [
            BoxShadow(color: Colors.blueGrey, spreadRadius: 1),
          ],
        ),
        child: Text('${user.username}'),
      ),
    );
  }

  var nodeId = 1;

  @override
  void initState() {
    builder
      ..siblingSeparation = (100)
      ..levelSeparation = (150)
      ..subtreeSeparation = (150)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);

    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  Future<FamilyTree> get() async {
    try {
      final response =
          await dio.get('http://kissota.ru:9000/tree/${widget.id}');
      var data = FamilyTree.fromJson(response.data);
      return data;
    } on ArgumentError catch (error) {
      throw Exception(error);
    } catch (error) {
      throw Exception(error);
    }
  }

  void buildTree(FamilyTree tree) {
    graph = Graph()..isTree = true;
    nodeId = 1;
    final node = Node.Id(nodeId);
    users[nodeId] = tree.value ?? User();
    nodeId++;
    buildTreeRecursive(tree.left, node, false);
    buildTreeRecursive(tree.right, node, true);
  }

  void buildTreeRecursive(FamilyTree? tree, Node core, bool hasRight) {
    if (tree != null) {
      final node = Node.Id(nodeId);
      var paint = Paint()..strokeWidth = 2;
      graph.addEdge(core, node,
          paint: paint..color = hasRight ? Colors.blue : Colors.redAccent);
      users[nodeId] = tree.value ?? User();
      nodeId++;
      buildTreeRecursive(tree.left, node, false);
      buildTreeRecursive(tree.right, node, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: get(),
      builder: (context, snapshot) {
        var data = snapshot.data;
        if (data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          buildTree(data);
        }
        return InteractiveViewer(
          constrained: false,
          boundaryMargin: const EdgeInsets.all(100),
          minScale: 0.01,
          maxScale: 2,
          child: GraphView(
            graph: graph,
            algorithm: BuchheimWalkerAlgorithm(
              builder,
              TreeEdgeRenderer(builder),
            ),
            paint: Paint()
              ..color = Colors.green
              ..strokeWidth = 1
              ..style = PaintingStyle.stroke,
            builder: (Node node) {
              // I can decide what widget should be shown here based on the id
              var id = (node.key?.value ?? 0) as int;
              return rectangleWidget(users[id] ?? User());
            },
          ),
        );
      },
    );
  }
}