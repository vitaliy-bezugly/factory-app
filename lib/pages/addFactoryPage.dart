import 'package:flutter/material.dart';
import '../models/factory.dart';

class AddFactoryPage extends StatefulWidget {
  final Factory? factory;
  final bool readOnly;
  final Function(Factory)? onUpdateFactory;
  final Function(Factory) onAddFactory;

  const AddFactoryPage(
      {Key? key,
      this.factory,
      this.readOnly = false,
      this.onUpdateFactory,
      required this.onAddFactory})
      : super(key: key);

  @override
  _AddFactoryPageState createState() => _AddFactoryPageState();
}

class _AddFactoryPageState extends State<AddFactoryPage> {
  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _numberOfWorkersController =
      TextEditingController();
  late TextEditingController _numberOfMastersController =
      TextEditingController();
  late TextEditingController _numberOfShopsController = TextEditingController();
  late TextEditingController _workerSalaryController = TextEditingController();
  late TextEditingController _masterSalaryController = TextEditingController();
  late TextEditingController _profitPerWorkerController =
      TextEditingController();
  late TextEditingController _profitPerMasterController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.factory?.name ?? '');
    _numberOfWorkersController = TextEditingController(
        text: widget.factory?.numberOfWorkers.toString() ?? '');
    _numberOfMastersController = TextEditingController(
        text: widget.factory?.numberOfMasters.toString() ?? '');
    _numberOfShopsController = TextEditingController(
        text: widget.factory?.numberOfShops.toString() ?? '');
    _workerSalaryController = TextEditingController(
        text: widget.factory?.workerSalary.toString() ?? '');
    _masterSalaryController = TextEditingController(
        text: widget.factory?.masterSalary.toString() ?? '');
    _profitPerWorkerController = TextEditingController(
        text: widget.factory?.profitPerWorker.toString() ?? '');
    _profitPerMasterController = TextEditingController(
        text: widget.factory?.profitPerMaster.toString() ?? '');
  }

  void _addFactory() {
    final factory = Factory(
      name: _nameController.text,
      numberOfWorkers: int.parse(_numberOfWorkersController.text),
      numberOfShops: int.parse(_numberOfShopsController.text),
      workerSalary: double.parse(_workerSalaryController.text),
      masterSalary: double.parse(_masterSalaryController.text),
      profitPerWorker: double.parse(_profitPerWorkerController.text),
      profitPerMaster: double.parse(_profitPerMasterController.text),
    );

    widget.onAddFactory(factory);
    Navigator.pop(context);
  }

  void _hireWorker() {
    try {
      widget.factory?.hireWorker();
      setState(() {
        _numberOfWorkersController.text =
            widget.factory?.numberOfWorkers.toString() ?? '';
        _numberOfMastersController.text =
            widget.factory?.numberOfMasters.toString() ?? '';
      });
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  void _dismissWorker() {
    try {
      widget.factory?.dismissWorker();
      setState(() {
        _numberOfWorkersController.text =
            widget.factory?.numberOfWorkers.toString() ?? '';
        _numberOfMastersController.text =
            widget.factory?.numberOfMasters.toString() ?? '';
      });
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  void _showProfitFromInvestment() {
    try {
      final profit = widget.factory?.profitFromInvestment(1000, 1);
      _showInformationDialog('Profit from investment: $profit');
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showInformationDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Information"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.readOnly ? 'Factory Details' : 'Add Factory')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Factory Name'),
              readOnly: widget.readOnly,
            ),
            TextField(
              controller: _numberOfWorkersController,
              decoration: const InputDecoration(labelText: 'Number of Workers'),
              keyboardType: TextInputType.number,
              readOnly: widget.readOnly,
            ),
            TextField(
              controller: _numberOfMastersController,
              decoration: const InputDecoration(labelText: 'Number of Masters'),
              keyboardType: TextInputType.number,
              readOnly: true,
            ),
            TextField(
              controller: _numberOfShopsController,
              decoration: const InputDecoration(labelText: 'Number of Shops'),
              keyboardType: TextInputType.number,
              readOnly: widget.readOnly,
            ),
            TextField(
              controller: _workerSalaryController,
              decoration: const InputDecoration(labelText: 'Worker Salary'),
              keyboardType: TextInputType.number,
              readOnly: widget.readOnly,
            ),
            TextField(
              controller: _masterSalaryController,
              decoration: const InputDecoration(labelText: 'Master Salary'),
              keyboardType: TextInputType.number,
              readOnly: widget.readOnly,
            ),
            TextField(
              controller: _profitPerWorkerController,
              decoration: const InputDecoration(labelText: 'Profit per Worker'),
              keyboardType: TextInputType.number,
              readOnly: widget.readOnly,
            ),
            TextField(
              controller: _profitPerMasterController,
              decoration: const InputDecoration(labelText: 'Profit per Master'),
              keyboardType: TextInputType.number,
              readOnly: widget.readOnly,
            ),
            if (widget.readOnly) // Check if in read-only mode
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  height: 60, // Adjust height as needed
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio:
                        3, // Adjust for desired width to height ratio
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: _hireWorker,
                        child: const Text('Hire Worker'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ), // Implement this method
                      ),
                      ElevatedButton(
                        onPressed: _dismissWorker,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ), 
                        child: const Text('Dismiss Worker'), 
                      ),
                    ],
                  ),
                ),
              ),
            // Button for displaying profitFromInvestment
            if (widget.readOnly)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: _showProfitFromInvestment,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  child: const Text('Show Profit from Investment'),
                ),
              ),
            if (!widget.readOnly)
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: _addFactory,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(6.0), // 4 px corner radius
                      ),
                    ),
                    child: const Text('Add Factory'),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    // Dispose other controllers
    super.dispose();
  }
}
