import 'package:flutter/material.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _selectedIndex = 0;

  final List<String> sliderImages = [
    'https://picsum.photos/id/1018/1200/400',
    'https://picsum.photos/id/1025/1200/400',
    'https://picsum.photos/id/1033/1200/400',
  ];

  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      _buildHomePage(),
      const Center(child: Text('About Page', style: TextStyle(fontSize: 30))),
      const Center(
        child: Text('Services Page', style: TextStyle(fontSize: 30)),
      ),
      const Center(child: Text('Contact Page', style: TextStyle(fontSize: 30))),
    ]);

    // Auto-slide every 3 seconds
    Future.delayed(const Duration(seconds: 3), _autoSlide);
  }

  void _autoSlide() {
    if (_pageController.hasClients) {
      int nextPage = (_currentPage + 1) % sliderImages.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage = nextPage;
      });
      Future.delayed(const Duration(seconds: 3), _autoSlide);
    }
  }

  Widget _buildHomePage() {
    return Column(
      children: [
        // Hero Image Slider
        SizedBox(
          height: 400,
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: sliderImages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Image.network(
                    sliderImages[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  );
                },
              ),
              // Dots indicator
              Positioned(
                bottom: 15,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    sliderImages.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 12 : 8,
                      height: _currentPage == index ? 12 : 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? Colors.white
                            : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Below the hero section
        const SizedBox(height: 30),
        const Text(
          'Welcome to My Website',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Text(
            'This is a simple hero section with a Flutter image slider that automatically slides every few seconds.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NextIndex'),
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
      body: SingleChildScrollView(child: _pages[_selectedIndex]),
    );
  }
}
