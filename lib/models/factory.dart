class Factory implements Comparable<Factory> {
  final String _name;
  int _numberOfWorkers;
  final int _numberOfShops;
  double _workerSalary;
  double _masterSalary;
  final double _profitPerWorker;
  final double _profitPerMaster;

  Factory({
    required String name,
    required int numberOfWorkers,
    required int numberOfShops,
    required double workerSalary,
    required double masterSalary,
    required double profitPerWorker,
    required double profitPerMaster,
  })  : _name = name,
        _numberOfWorkers = numberOfWorkers,
        _numberOfShops = numberOfShops,
        _workerSalary = workerSalary,
        _masterSalary = masterSalary,
        _profitPerWorker = profitPerWorker,
        _profitPerMaster = profitPerMaster;

  // Copy constructor
  Factory.copy(Factory factory)
      : _name = factory._name,
        _numberOfWorkers = factory._numberOfWorkers,
        _numberOfShops = factory._numberOfShops,
        _workerSalary = factory._workerSalary,
        _masterSalary = factory._masterSalary,
        _profitPerWorker = factory._profitPerWorker,
        _profitPerMaster = factory._profitPerMaster;

  Factory operator +(Factory other) => Factory(
        name: "$_name & ${other._name}",
        numberOfWorkers: _numberOfWorkers + other._numberOfWorkers,
        numberOfShops: _numberOfShops + other._numberOfShops,
        workerSalary: (_workerSalary + other._workerSalary) / 2,
        masterSalary: (_masterSalary + other._masterSalary) / 2,
        profitPerWorker: _profitPerWorker + other._profitPerWorker,
        profitPerMaster: _profitPerMaster + other._profitPerMaster,
      );

  int get numberOfMasters =>
      (_numberOfWorkers / 10).ceil(); // 1 master for every 10 workers

  String get name => _name;

  int get numberOfWorkers => _numberOfWorkers;

  int get numberOfShops => _numberOfShops;

  double get workerSalary => _workerSalary;

  double get masterSalary => _masterSalary;

  double get profitPerWorker => _profitPerWorker;

  double get profitPerMaster => _profitPerMaster;

  void hireWorker() => _changeWorkerCount(1);

  void dismissWorker() => _changeWorkerCount(-1);

  void hireMaster() => _changeMasterCount(1);

  void dismissMaster() => _changeMasterCount(-1);

  void setSalary(double salary) => _workerSalary = salary;
  
  void setMasterSalary(double salary) => _masterSalary = salary;

  double totalSalary() =>
      (_numberOfWorkers * _workerSalary) + (numberOfMasters * _masterSalary);

  @override
  int compareTo(Factory other) =>
      _numberOfWorkers.compareTo(other._numberOfWorkers);

  double profitFromInvestment(double investmentAmount, int durationInMonths) {
    double profit = 0;
    double profitPerMonth = _profitPerWorker * _numberOfWorkers +
        _profitPerMaster * numberOfMasters -
        totalSalary();

    for (int i = 0; i < durationInMonths; i++) {
      profit += profitPerMonth;
      profit += profit * (investmentAmount / 100);
    }

    return profit;
  }

  // Private methods
  void _changeWorkerCount(int count) {
    if (_numberOfWorkers + count < 0) {
      throw Exception("Can't have negative number of workers");
    }
    _numberOfWorkers += count;
  }

  void _changeMasterCount(int count) {
    int newMasterCount = numberOfMasters + count;
    int requiredWorkers = newMasterCount * 10;

    if (requiredWorkers <= _numberOfWorkers) {
      _numberOfWorkers = requiredWorkers;
    } else {
      throw Exception(
          "Not enough workers to support the new number of masters");
    }
  }
}
