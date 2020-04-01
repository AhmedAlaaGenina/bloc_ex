import 'dart:async';
import 'employee.dart';

class EmployeeBloc {
  //* List Of Employee
  List<Employee> _employeeList = [
    Employee(1, 'Employee One', 1000),
    Employee(2, 'Employee Two', 2000),
    Employee(3, 'Employee Three', 3000),
    Employee(4, 'Employee Four', 4000),
    Employee(5, 'Employee Five', 5000),
    Employee(6, 'Employee Six', 6000),
  ];

  //*Stream Controller

  final _employeeListStreamController = StreamController<List<Employee>>();
  final _employeeSalaryIncrementStreamController = StreamController<Employee>();
  final _employeeSalaryDecrementStreamController = StreamController<Employee>();

  //*Stream Getter

  //* get Data (OutPut) =>Stream

  Stream<List<Employee>> get employeeListStream =>
      _employeeListStreamController.stream;

  //*Set Data(InPut) =>Sink

  StreamSink<List<Employee>> get employeeListSink =>
      _employeeListStreamController.sink;

  StreamSink<Employee> get employeeSalaryIncrement =>
      _employeeSalaryIncrementStreamController.sink;

  StreamSink<Employee> get employeeSalaryDecrement =>
      _employeeSalaryDecrementStreamController.sink;

//*Constructor - AddData ; listen to Changes
  EmployeeBloc() {
    _employeeListStreamController.add(_employeeList);
    _employeeSalaryIncrementStreamController.stream.listen(_increment);
    _employeeSalaryDecrementStreamController.stream.listen(_decrement);
  }

  //*Core Function

  _increment(Employee employee) {
    double salary = employee.salary;
    double icrementSalary = salary * 20 / 100;

    _employeeList[employee.id - 1].salary = salary + icrementSalary;

    employeeListSink.add(_employeeList);
  }

  _decrement(Employee employee) {
    double salary = employee.salary;
    double derementSalary = salary * 20 / 100;

    _employeeList[employee.id - 1].salary = salary - derementSalary;

    employeeListSink.add(_employeeList);
  }

  //* Dispose

  void dispose() {
    _employeeSalaryIncrementStreamController.close();
    _employeeSalaryDecrementStreamController.close();
    _employeeListStreamController.close();
  }
}
