import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:sms_app/chat.dart';
import 'dart:math' as math;

class FlutterContactsExample extends StatefulWidget {
  @override
  _FlutterContactsExampleState createState() => _FlutterContactsExampleState();
}

class _FlutterContactsExampleState extends State<FlutterContactsExample> {
  List<Contact>? _contacts;
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  String getInitials(String name) => name.isNotEmpty
    ? name.trim().split(' ').map((l) => l[0]).take(2).join()
    : '';
  Widget cardChat(Contact contact) {
  // ignore: sized_box_for_whitespace
  return Container(
    width: double.infinity,
    height: 60,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              (contact.thumbnail != null && contact.thumbnail!.isNotEmpty) ?  CircleAvatar(backgroundImage: MemoryImage(contact.thumbnail! , scale: 1.0)) : CircleAvatar(
                        child: Text(getInitials(contact.displayName)),
                        backgroundColor: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                      ),

            Padding(child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(contact.displayName),
              const Text('LastMessage.....', style: TextStyle(fontSize: 12)),
              ]
          ),
          padding:  const EdgeInsets.all(8),),
        ]),
        // const Icon(Icons.arrow_circle_right_outlined, color: Colors.blueAccent, size: 20,)
        const Text('Date dernier message', style: TextStyle(fontSize: 11))
      ]),
  );
}

  Future _fetchContacts() async {
    if (!await FlutterContacts.requestPermission()) {
      setState(() => _permissionDenied = true);
    } else {
      final contacts = await FlutterContacts.getContacts(withProperties: true, withPhoto: true);
      setState(() => _contacts = contacts);
    }
  }


  @override
  Widget build(BuildContext context) => MaterialApp(
      home: Scaffold(
          appBar: AppBar(
          // ignore: sized_box_for_whitespace

          title: Container(
                width: double.infinity,
                height: 30,
            child: const TextField(
                    decoration: InputDecoration(
                      hintText: "Rechercher",
                      prefixIcon: Icon(Icons.search),
                      iconColor: Colors.white,
                      prefixIconColor: Colors.white,
                      focusColor: Colors.white
                    ),
                    onChanged: (text) {
                      _contacts!.where((element) => element.displayName.contains(text));
                    },
                    style: TextStyle(color: Colors.white, fontSize: 14),
                ),
             ),
             actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: const Icon(
                        Icons.more_vert
                    ),
                  )
                ),
             ],
          ),
          body: _body()));

  Widget _body() {
    if (_permissionDenied) return const Center(child: Text('Permission denied'));
    if (_contacts == null) return const Center(child: CircularProgressIndicator());
    return ListView.builder(
        itemCount: _contacts!.length,
        itemBuilder: (context, i) => ListBody(
            children: [
                  Padding(padding: const EdgeInsets.all(8),
                  child: cardChat(_contacts![i]),
                  )
                //   IconButton(
                //     onPressed: () {
                //       Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ChatPage()));
                //     },
                //     icon: const Icon(Icons.message_outlined),
                //     color: Colors.blueAccent,
                //  ),
                //   IconButton(icon: const Icon(Icons.info_outline_rounded)
                //   ,color: Colors.blueAccent, onPressed: () async {
                //   final fullContact = await FlutterContacts.getContact(_contacts![i].id);
                //   await Navigator.of(context).push(
                //       MaterialPageRoute(builder: (_) => ContactPage(fullContact!)));
                //       }
                //   )
            ]),);
  }
}

class ContactPage extends StatelessWidget {
  final Contact contact;
  // ignore: use_key_in_widget_constructors
  const ContactPage(this.contact);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text(contact.displayName)),
      body: Row(children: [Column(children: [
        Text('First name: ${contact.name.first}'),
        Text('Last name: ${contact.name.last}'),
        Text(
            'Phone number: ${contact.phones.isNotEmpty ? contact.phones.first.number : '(none)'}'),
      ]),
    ]),
    );
}
