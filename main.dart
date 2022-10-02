import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

main() {
  final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => MainScreen()),
      GoRoute(
          path: '/contact/:name/:email',
          builder: (context, state) => ContactScreen(
                state.params['name']!,
                Uri.decodeQueryComponent(state.params['email']!),
              )),
    ],
  );

  runApp(MaterialApp.router(routerConfig: router));
}

class MainScreen extends StatelessWidget {
  final List<Contact> contacts = ContactService()._contacts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Contacts")),
        body: Column(
            children: contacts
                .map((e) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [ButtonWidget(e.name, e.email), Text(e.email)]))
                .toList()));
  }
}

class ContactScreen extends StatelessWidget {
  final String name;
  final String email;
  const ContactScreen(this.name, this.email);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Contacts")),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Card(child:Text(name)), Text(email)])));
  }
}

class Contact {
  final String name;
  final String email;

  Contact(this.name, this.email);
}

class ContactService {
  final List<Contact> _contacts = [
    Contact("Leela", "leela@futurama.com"),
    Contact("Bender", "bender@futurama.com"),
    Contact("Zoidberg", "zoidberg@futurama.com"),
    Contact("Homer", "homer@simpsons.com"),
    Contact("Marge", "marge@simpsons.com"),
    Contact("Bart", "bart@simpsons.com"),
    Contact("Lisa", "lisa@simpsons.com"),
    Contact("Maggie", "lisa@simpsons.com"),
  ];

  List<Contact> getContacts() {
    return _contacts;
  }

  Contact getContact(int index) {
    return _contacts[index];
  }
}

class ButtonWidget extends StatefulWidget {
  final String contact;
  final String email;
  const ButtonWidget(this.contact, this.email);
  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  var _isLoading = false;
  void _onSubmit() {
    setState(() => _isLoading = true);
    Future.delayed(
      const Duration(seconds: 5),
      () => {
        setState(() => _isLoading = false),
        context.go(
            "/contact/${widget.contact}/${Uri.encodeComponent(widget.email)}")
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _isLoading ? null : _onSubmit,
      style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16.0)),
      icon: _isLoading
          ? Container(
              width: 24,
              height: 24,
              padding: const EdgeInsets.all(2.0),
              child: const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            )
          : const Icon(Icons.account_circle),
      label: Text(widget.contact),
    );
  }
}
