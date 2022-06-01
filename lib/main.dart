import 'package:flutter/material.dart';
import 'package:zeus_api/services/api/model/client_model.dart';
import 'package:zeus_api/services/api/model/relationship_model.dart';
import 'package:zeus_api/services/api/model/role_model.dart';
import 'package:zeus_api/services/repository/auth_repo.dart';
import 'package:zeus_api/services/repository/client_repo.dart';
import 'package:zeus_api/services/repository/relationship_repo.dart';
import 'package:zeus_api/services/repository/role_repo.dart';

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
  AuthRepo authRepo = AuthRepo();
  ClientRepo clientRepo = ClientRepo();
  RoleRepo roleRepo = RoleRepo();
  RelationshipRepo relationshipRepo = RelationshipRepo();
  String _response = "";
  String _accessToken = "";
  List<Client> clients = [];
  List<Role> roles = [];
  List<Relationship> relationships = [];

  Future<void> getAccessToken() async {
    var result = await authRepo.createAccessToken(
        email: "gohsyang@gmail.com", password: "123456");

    if (result.isSuccess) {
      setState(() {
        _accessToken = result.data["access"];
        _response = "Access Token is received";
      });
    } else {
      print("here");
      if (mounted) {
        setState(() {
          _response = result.message;
        });
      }
    }
  }

  Future<void> getAllClients() async {
    var result = await clientRepo.getAllClients(accessToken: _accessToken);

    if (result.isSuccess) {
      if (result.data.length > 0) {
        if (mounted) {
          for (int i = 0; i < result.data.length; i += 1) {
            setState(() {
              clients.add(result.data[i]);
            });
          }
        }
      }
    } else {
      if (mounted) {
        setState(() {
          _response = result.message;
        });
      }
    }
  }

  Future<void> getClientById() async {
    var result = await clientRepo.getClientById(
        accessToken: _accessToken,
        clientId: "509915ae-d5e8-11ec-8c20-d2f71f84b1fe");

    if (result.isSuccess) {
      if (result.data.length > 0) {
        if (mounted) {
          for (int i = 0; i < result.data.length; i += 1) {
            setState(() {
              clients.add(result.data[i]);
            });
          }
        }
      }
    } else {
      if (mounted) {
        setState(() {
          _response = result.message;
        });
      }
    }
  }

  Future<void> saveClient() async {
    var result = await clientRepo.saveClient(
      accessToken: _accessToken,
      createdById: "k3D5dHv0nCWWouXrfSYVaGrwrOZ2",
      name: "Jane",
      attribute: [
        ClientAttribute(key: "IQ", value: "100"),
        ClientAttribute(key: "Potential", value: "Good")
      ],
    );

    if (result.isSuccess) {
      setState(() {
        _response = result.data;
      });
    } else {
      if (mounted) {
        setState(() {
          _response = result.message;
        });
      }
    }
    print(result.data);
  }

  Future<void> deleteClient() async {
    var result = await clientRepo.deleteClient(
        accessToken: _accessToken,
        clientId: "f7bfbab2-e101-11ec-9e81-ee636d807327");

    if (result.isSuccess) {
      setState(() {
        _response = result.data;
      });
    } else {
      if (mounted) {
        setState(() {
          _response = result.message;
        });
      }
    }
    print(result.data);
  }

  Future<void> getAllRoles() async {
    var result = await roleRepo.getAllRoles(accessToken: _accessToken);

    if (result.isSuccess) {
      if (result.data.length > 0) {
        if (mounted) {
          for (int i = 0; i < result.data.length; i += 1) {
            setState(() {
              roles.add(result.data[i]);
            });
          }
        }
      }
    } else {
      if (mounted) {
        setState(() {
          _response = result.message;
        });
      }
    }
    print(roles[0].roleId);
  }

  Future<void> getRoleById() async {
    var result = await roleRepo.getRoleById(
        accessToken: _accessToken,
        roleId: "263f3e86-d5e9-11ec-8a0a-d2f71f84b1fe");

    if (result.isSuccess) {
      if (result.data.length > 0) {
        if (mounted) {
          for (int i = 0; i < result.data.length; i += 1) {
            setState(() {
              roles.add(result.data[i]);
            });
          }
        }
      }
    } else {
      if (mounted) {
        setState(() {
          _response = result.message;
        });
      }
    }

    print(roles[0].roleId);
  }

  Future<void> saveRole() async {
    var result = await roleRepo.saveRole(
      accessToken: _accessToken,
      roleId: "b5b99d30-e111-11ec-b0be-927137e22ce7",
      createdById: "k3D5dHv0nCWWouXrfSYVaGrwrOZ2",
      name: "No-Code Application",
      attribute: [
        RoleAttribute(key: "Right", value: "free"),
        RoleAttribute(key: "Extensive", value: "True")
      ],
    );

    if (result.isSuccess) {
      setState(() {
        _response = result.data;
      });
    } else {
      if (mounted) {
        setState(() {
          _response = result.message;
        });
      }
    }
    print(result.data);
  }

  Future<void> deleteRole() async {
    var result = await roleRepo.deleteRole(
        accessToken: _accessToken,
        roleId: "b5b99d30-e111-11ec-b0be-927137e22ce7");

    if (result.isSuccess) {
      setState(() {
        _response = result.data;
      });
    } else {
      if (mounted) {
        setState(() {
          _response = result.message;
        });
      }
    }
    print(result.data);
  }

  Future<void> getAllRelationship() async {
    var result = await relationshipRepo.getAllRelationships(accessToken: _accessToken);

    if (result.isSuccess) {
      if (result.data.length > 0) {
        if (mounted) {
          for (int i = 0; i < result.data.length; i += 1) {
            setState(() {
              relationships.add(result.data[i]);
            });
          }
        }
      }
    } else {
      if (mounted) {
        setState(() {
          _response = result.message;
        });
      }
    }
    print(relationships[0].clientRoleRelId);
  }

  Future<void> getRelationshipById() async {
    var result = await relationshipRepo.getRelationshipById(
        accessToken: _accessToken,
        clientRoleRelId: "d6b2267c-d759-11ec-bc13-425b6470ee05");

    if (result.isSuccess) {
      if (result.data.length > 0) {
        if (mounted) {
          for (int i = 0; i < result.data.length; i += 1) {
            setState(() {
              relationships.add(result.data[i]);
            });
          }
        }
      }
    } else {
      if (mounted) {
        setState(() {
          _response = result.message;
        });
      }
    }

    print(relationships[0].clientRoleRelId);
  }

  Future<void> saveRelationship() async {
    var result = await relationshipRepo.saveRelationship(
      accessToken: _accessToken,
      clientRoleRelId: "d6b2267c-d759-11ec-bc13-425b6470ee05",
      createdById: "k3D5dHv0nCWWouXrfSYVaGrwrOZ2",
      permission: "editor",
      client: "953a3d54-db2a-11ec-bc25-9e58e32b3867",
      role:"263f3e86-d5e9-11ec-8a0a-d2f71f84b1fe"
    );

    if (result.isSuccess) {
      setState(() {
        _response = result.data;
      });
    } else {
      if (mounted) {
        setState(() {
          _response = result.message;
        });
      }
    }
    print(result.data);
  }

  Future<void> deleteRelationship() async {
    var result = await relationshipRepo.deleteRelationship(
        accessToken: _accessToken,
        clientRoleRelId: "d6b2267c-d759-11ec-bc13-425b6470ee05");

    if (result.isSuccess) {
      setState(() {
        _response = result.data;
      });
    } else {
      if (mounted) {
        setState(() {
          _response = result.message;
        });
      }
    }
    print(result.data);
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
              'You have pushed the button this many times:',
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
                onPressed: () => {(getAllRelationship())}, child: Text("Get All Relationships")),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () => {(getRelationshipById())}, child: Text("Get Relationship By Id")),
          const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () => {(saveRelationship())}, child: Text("Save Relationships")),
          const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () => {(deleteRelationship())}, child: Text("Delete Relationships")),
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {getAccessToken()},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
