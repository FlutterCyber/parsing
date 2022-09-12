import 'package:flutter/material.dart';
import 'package:parsing/model/emplist_model.dart';
import 'package:parsing/model/empone_model.dart';
import '../model/emp_model.dart';
import '../model/user_model.dart';
import '../services/http_service.dart';

class HomePage extends StatefulWidget {
  static const String id = 'HomePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String data = "";
  List<Employee> items = [];
  late int count;

  @override
  void initState() {
    // TODO: implement initState
    //var user = new User(id: 1, name: "Muhammad", salary: "10200", age: "999");
    super.initState();
    _apiEmpList();
    //_apiEmpOne(3);
    //_apiCreateUser(user);
    //_apiUpdateUser(user);
    //_apiDeleteUser(user);
  }

  void _apiEmpList() {
    Network.GET(Network.API_EMP_LIST, Network.paramsEmpty())
        .then((response) => {
              print(response),
              _showResponse(response!),
            });
  }

  void _apiEmpOne(int id) {
    Network.GET(Network.API_EMP_ONE + id.toString(), Network.paramsEmpty())
        .then((response) => {
              print(response),
              _showResponse(response!),
            });
  }

  // void _apiCreateUser(User user1) {
  //   Network.POST(Network.API_EMP_CREATE, Network.paramsCreate(user1))
  //       .then((response) => {
  //             print(response),
  //             _showResponse(response!),
  //           });
  // }

  // void _apiUpdateUser(User user1) {
  //   Network.PUT(Network.API_EMP_UPDATE + user1.id.toString(),
  //           Network.paramsUpdate(user1))
  //       .then((var response) => {
  //             print(response),
  //             _showResponse(response!),
  //           });
  // }

  // void _apiDeleteUser(User user1) {
  //   Network.DELETE(
  //           Network.API_EMP_DELETE + user1.id.toString(), Network.paramsDelete())
  //       .then((response) => {
  //             print(response),
  //             _showResponse(response!),
  //           });
  // }

  void _showResponse(String response) {
    EmpList emplist = Network.parseEmpList(response);

    setState(() {
      items.addAll(emplist.data);
    });
    print("Length: ${items.length}");
    //print("Ma'lumotlar soni: ${emplist.data.length}");

    // EmpOne empone = Network.parseEmpOne(response);
    // print("ISMI: ${empone.data.employee_age}");

    // print("Nimadir: ${empone.data.employee_name}");

    // setState(() {
    //   data = response;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text('Employee List'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (ctx, i) {
              return itemsOfList(items[i]);
            }),
      ),
    );
  }

  Widget itemsOfList(Employee emp) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            emp.id.toString() +
                " " +
                emp.employee_name +
                ": " +
                emp.employee_age.toString(),
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          SizedBox(
            height: 18,
          ),
          Text(
            "Oylik: " + emp.employee_salary.toString() + " \$",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
