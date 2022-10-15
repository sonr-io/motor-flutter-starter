import 'package:flutter/material.dart';
import 'package:motor_flutter/motor_flutter.dart';

import '../models/action.dart';

class ActionsPage extends StatefulWidget {
  const ActionsPage({super.key, required this.item});
  final ActionItem item;

  @override
  State<ActionsPage> createState() => _StartPageState();
}

class _StartPageState extends State<ActionsPage> {
  final TextEditingController _controller = TextEditingController();

  String _dropdownValue = 'STRING';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(widget.item.title),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.add),
            title: Text("Create ${widget.item.title}"),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Create ${widget.item.title}"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _controller,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: "Name",
                          ),
                        ),
                        DropdownButton<String>(
                            items: getKindNames(),
                            value: _dropdownValue,
                            onChanged: (value) {
                              setState(() {
                                _dropdownValue = value!;
                              });
                            }),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Create"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> getKindNames() {
    final kindNames = Kind.values.map((e) => e.name).toList();
    return kindNames
        .map(
          (e) => DropdownMenuItem<String>(
            value: e,
            child: Text(e),
          ),
        )
        .toList();
  }
}
