import 'package:flutter/material.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Center(child: Text('Home Page', style: TextStyle(fontSize: 30))),
    const Center(child: Text('About Page', style: TextStyle(fontSize: 30))),
    const Center(child: Text('Services Page', style: TextStyle(fontSize: 30))),
    const Center(child: Text('Contact Page', style: TextStyle(fontSize: 30))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Flutter Web Page'),
        backgroundColor: Colors.blue,
        actions: [
          TextButton(
            onPressed: () => _onItemTapped(0),
            child: const Text('Home', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () => _onItemTapped(1),
            child: const Text('About', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () => _onItemTapped(2),
            child: const Text(
              'Services',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () => _onItemTapped(3),
            child: const Text('Contact', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
    );
  }
}
