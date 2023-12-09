import 'package:flutter/material.dart';
import 'addFactoryPage.dart';
import '../models/factory.dart';

class FactoryListPage extends StatefulWidget {
  const FactoryListPage({super.key});

  @override
  _FactoryListPageState createState() => _FactoryListPageState();
}

class _FactoryListPageState extends State<FactoryListPage> with TickerProviderStateMixin  {
  List<Factory> factories = [
    Factory(
          name: 'Factory 1',
          numberOfWorkers: 100,
          numberOfShops: 5,
          workerSalary: 500,
          masterSalary: 1000,
          profitPerWorker: 200,
          profitPerMaster: 400),
      Factory(
          name: 'Factory 2',
          numberOfWorkers: 150,
          numberOfShops: 3,
          workerSalary: 550,
          masterSalary: 1100,
          profitPerWorker: 250,
          profitPerMaster: 450),
  ];

  bool _showGear = false; // New variable to control gear visibility
  late AnimationController _gearAnimationController;
  late Animation<double> _scaleAnimation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _scaleAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    
    _gearAnimationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _controller.forward();
  }

  void showGear() {
    setState(() {
      _showGear = true; // Show gear when mouse enters the app bar
    });
  }

  void hideGear() {
    setState(() {
      _showGear = false; // Hide gear when mouse exits the app bar
    });
  }

  void _addFactory(Factory factory) {
    setState(() {
      factories.add(factory);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Factories'),
        actions: <Widget>[
          if (_showGear) // Conditionally display gear icon
          RotationTransition(
            turns: _gearAnimationController,
            child: IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // Action for gear icon
              },
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: factories.length,
        itemBuilder: (context, index) {
          return FactoryListItem(factory: factories[index]);
        },
      ),
      floatingActionButton: ScaleTransition(
        scale: _scaleAnimation,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => AddFactoryPage(onAddFactory: _addFactory),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  var begin = const Offset(0.0, 1.0);
                  var end = Offset.zero;
                  var curve = Curves.easeInOut;

                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                 );
                },
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class FactoryListItem extends StatefulWidget {
  final Factory factory;

  const FactoryListItem({Key? key, required this.factory}) : super(key: key);

  @override
  _FactoryListItemState createState() => _FactoryListItemState();
}

class _FactoryListItemState extends State<FactoryListItem> with SingleTickerProviderStateMixin {
  bool isHovered = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: GestureDetector(
      onTap: () async {   
        final ancestorState = context.findAncestorStateOfType<_FactoryListPageState>();
        ancestorState?.showGear();

        // Await the future to complete before continuing
        await Future.delayed(const Duration(seconds: 1));
      
        setState(() {
          ancestorState?.hideGear();
        });

        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => AddFactoryPage(
              factory: widget.factory,
              readOnly: true,
              onAddFactory: (someFactory) {},
            ),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.ease;

              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          ),
        );
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: Card(
          color: isHovered ? Colors.grey[300] : Colors.white,
          child: ListTile(
            leading: Image.asset('lib/assets/factory-1.png', width: 32, height: 32), 
            title: Text(widget.factory.name),
            subtitle: Text('Shops count: ${widget.factory.numberOfShops}'),
          ),
        ),
      ),
    ),
  );
}

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
