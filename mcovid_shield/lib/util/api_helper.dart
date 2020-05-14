import 'dart:convert';
import 'package:mcovidshield/util/globalVars.dart';
import 'package:http/http.dart' as http;

class ApiRequestsHelper {
  var status = false;

  registerUser(String cin, String phone, String mac) async {
    String myUrl = "${MyVars.apiUrl}/users?cin=$cin&phone=$phone&mac_adresse=$mac";
    final response = await http.post(myUrl,
        headers: {
          'Accept': 'application/json'
        },
        body: {});
    status = response.body.contains('error');

    var data = json.decode(response.body);

    if (!status) {
      print('Statut : ${data.toString()}');
      print('Data : ${data["msg"]}');
      status = (data["msg"] == 'ok') ? true : false;
    } else {
      print('Error : ${data.toString()}');
      status = false;
    }
  }

  uploadCollisions(String name, String date, String mac, String collision_with) async {
    String myUrl = "${MyVars.apiUrl}/collisions?name=$name&date=$date&mac_adresse=$mac&collision_with=$collision_with";
    final response = await http.post(myUrl,
        headers: {
          'Accept': 'application/json'
        },
        body: {});
    status = response.body.contains('error');

    var data = json.decode(response.body);

    if (!status) {
      print('Statut : ${data.toString()}');
      print('Data : ${data["msg"]}');
      status = (data["msg"] == 'ok') ? true : false;
    } else {
      print('Error : ${data.toString()}');
      status = false;
    }
  }
}