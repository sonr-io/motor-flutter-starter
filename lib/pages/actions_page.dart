import 'package:flutter/material.dart';
import '../models/action.dart';
import '../models/schema_search_delegate.dart';

class ActionsPage extends StatefulWidget {
  const ActionsPage({super.key, required this.item});
  final ActionItem item;

  @override
  State<ActionsPage> createState() => _StartPageState();
}

class _StartPageState extends State<ActionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(widget.item.title),
      ),
      body: ListView(
        children: [
          // Create Schema Action
          ListTile(
            leading: const Icon(Icons.add),
            title: Text("Create ${widget.item.title}"),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Create Example Schema", style: Theme.of(context).textTheme.titleLarge),
                    content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Profile", style: Theme.of(context).textTheme.titleMedium),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Name", style: Theme.of(context).textTheme.bodyText1),
                              Text("STRING", style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.grey)),
                            ],
                          ),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Text("Age", style: Theme.of(context).textTheme.bodyText1),
                            Text("INTEGER", style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.grey)),
                          ]),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Text("Bio", style: Theme.of(context).textTheme.bodyText1),
                            Text("STRING", style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.grey)),
                          ]),
                        ],
                      ),
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
          ListTile(
            leading: const Icon(Icons.search),
            title: Text("Search for ${widget.item.title}"),
            onTap: () {
              showSearch(context: context, delegate: SchemaSearchDelegate());
            },
          ),
        ],
      ),
    );
  }
}
