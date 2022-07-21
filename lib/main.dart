import 'package:flutter/material.dart';
import 'package:zeus_api/services/api/model/client_model.dart';
import 'package:zeus_api/services/api/model/relationship_model.dart';
import 'package:zeus_api/services/api/model/role_model.dart';
import 'package:zeus_api/zeus_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _response = "";
  String _accessToken = "";
  String _refreshToken = "";

  Future<void> getAccessToken() async {
    var tokens = await ZeusControl.getTokens(
        email: "email@domain.com", password: "123456");
    _response = "Tokens are retrieved";
    setState(() {
      _accessToken = tokens!["access"];
      _refreshToken = tokens["refresh"];
    });
    print(_response);
  }

  Future<void> refreshToken() async {
    var tokens = await ZeusControl.refreshToken(refreshToken: _refreshToken);
    _response = "Tokens are retrieved";
    setState(() {
      _accessToken = tokens!["access"];
    });
    print(_response);
  }

  Future<void> getAllClients() async {
    List<Client>? clients = await ZeusControl.getAllClients(
      accessToken: _accessToken,
    );
    _response = clients![0].name!;
    print(_response);
  }

  Future<void> getClientById() async {
    List<Client>? clients = await ZeusControl.getClientById(
        accessToken: _accessToken, clientId: "id");
    _response = clients![0].name!;
    print(_response);
  }

  Future<void> saveClient() async {
    String? client = await ZeusControl.saveClient(
      accessToken: _accessToken,
      createdById: "user id",
      name: "Janet",
      attribute: [
        ClientAttribute(key: "IQ", value: "100"),
        ClientAttribute(key: "Potential", value: "High")
      ],
    );
    _response = client!;
    print(_response);
  }

  Future<void> deleteClient() async {
    String? isDeleted = await ZeusControl.deleteClient(
        accessToken: _accessToken, clientId: "client id");
    _response = isDeleted!;
    print(_response);
  }

  Future<void> getAllRoles() async {
    List<Role>? roles = await ZeusControl.getAllRoles(
      accessToken: _accessToken,
    );
    _response = roles![0].roleId!;
    print(_response);
  }

  Future<void> getRoleById() async {
    List<Role>? roles = await ZeusControl.getRoleById(
        accessToken: _accessToken, roleId: "role id");
    _response = roles![0].name!;
    print(_response);
  }

  Future<void> saveRole() async {
    String? role = await ZeusControl.saveRole(
      accessToken: _accessToken,
      createdById: "user id",
      roleId: "role id",
      name: "PowerBI",
      attribute: [
        RoleAttribute(key: "Access", value: "True"),
      ],
    );
    _response = role!;
    print(_response);
  }

  Future<void> deleteRole() async {
    String? isDeleted = await ZeusControl.deleteRole(
        accessToken: _accessToken, roleId: "role id");
    _response = isDeleted!;
    print(_response);
  }

  Future<void> getAllRelationship() async {
    List<Relationship>? relationships = await ZeusControl.getAllRelationship(
      accessToken: _accessToken,
    );
    _response = relationships![0].clientRoleRelId!;
    print(_response);
  }

  Future<void> getRelationshipById() async {
    List<Relationship>? relationships = await ZeusControl.getRelationshipById(
        accessToken: _accessToken, clientRoleRelId: "relationship id");
    _response = relationships![0].clientRoleRelId!;
    print(_response);
  }

  Future<void> saveRelationship() async {
    String? relationship = await ZeusControl.saveRelationship(
        accessToken: _accessToken,
        clientRoleRelId: "relationship id",
        createdById: "user id",
        permission: "viewer",
        client: "client id",
        role: "role id");
    _response = relationship!;
    print(_response);
  }

    Future<void> saveRelationshipABAC() async {
    String? relationship = await ZeusControl.saveRelationshipABAC(
        accessToken: _accessToken,
        clientRoleRelId: "relationship id",
        createdById: "user id",
        permission: "viewer",
        client: "client id",
        role: "role id"
        clientAttribute: [],
        roleAttribute: []);
    _response = relationship!;
    print(_response);
  }

  Future<void> deleteRelationship() async {
    String? isDeleted = await ZeusControl.deleteRelationship(
        accessToken: _accessToken, clientRoleRelId: "relationship id");
    _response = isDeleted!;
    print(_response);
  }

  Future<void> isAuthorozied() async {
    String? isAuthorized = await ZeusControl.isAuthorized(
        accessToken: _accessToken,
        clientId: "client id",
        roleId: "role id",
        permission: "editor");
    _response = isAuthorized!;
    print(_response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Message:',
            ),
            Text(
              _response,
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () => {getAccessToken()},
                child: Text("Get Access Token")),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () => {refreshToken()},
                child: Text("Refresh Token")),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () => {getAllClients()},
                child: Text("Get All Clients")),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () => {getClientById()},
                child: Text("Get Client By Id")),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () => {saveClient()}, child: Text("Save Client")),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () => {deleteClient()},
                child: Text("Delete Client")),
            /* Role */
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () => {getAllRoles()}, child: Text("Get All Role")),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () => {getRoleById()},
                child: Text("Get Role By Id")),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () => {saveRole()}, child: Text("Save Role")),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () => {deleteRole()}, child: Text("Delete Role")),
            /* Relationship */
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () => {(getAllRelationship())},
                child: Text("Get All Relationships")),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () => {(getRelationshipById())},
                child: Text("Get Relationship By Id")),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () => {(saveRelationship())},
                child: Text("Save Relationships")),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () => {(saveRelationshipABAC())},
                child: Text("Save Relationships ABAC")),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () => {(deleteRelationship())},
                child: Text("Delete Relationships")),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () => {(isAuthorozied())},
                child: Text("isAuthorized")),
          ],
        ),
      )),
    );
  }
}
