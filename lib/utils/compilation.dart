library zeus_api;

import 'package:zeus_api/services/api/model/client_model.dart';
import 'package:zeus_api/services/api/model/relationship_model.dart';
import 'package:zeus_api/services/api/model/role_model.dart';
import 'package:zeus_api/services/repository/auth_repo.dart';
import 'package:zeus_api/services/repository/client_repo.dart';
import 'package:zeus_api/services/repository/relationship_repo.dart';
import 'package:zeus_api/services/repository/role_repo.dart';

class APICompile {
  static AuthRepo authRepo = AuthRepo();
  static ClientRepo clientRepo = ClientRepo();
  static RoleRepo roleRepo = RoleRepo();
  static RelationshipRepo relationshipRepo = RelationshipRepo();

  static Future<Map<String, dynamic>?> getAccessToken({email, password}) async {
    var result =
        await authRepo.createAccessToken(email: email, password: password);

    if (result.isSuccess) {
      Map<String, dynamic>? map = <String, dynamic>{};
      map["access"] = result.data["access"];
      map["refresh"] = result.data["refresh"];

      return {
        "access": result.data["access"],
        "refresh": result.data["refresh"]
      };
    } else {
      print(result.message);
      return null;
    }
  }

  static Future<Map<String, dynamic>?> refreshToken({refreshToken}) async {
    var result =
        await authRepo.refreshToken(refreshToken: refreshToken);

    if (result.isSuccess) {
      Map<String, dynamic>? map = <String, dynamic>{};
      map["access"] = result.data["access"];

      return {
        "access": result.data["access"],
      };
    } else {
      print(result.message);
      return null;
    }
  }

  static Future<List<Client>?> getAllClients({accessToken}) async {
    List<Client> clients = [];
    var result = await clientRepo.getAllClients(accessToken: accessToken);

    if (result.isSuccess) {
      for (int i = 0; i < result.data.length; i += 1) {
        clients.add(result.data[i]);
      }
      return clients;
    } else {
      print(result.message);

      return null;
    }
  }

  static Future<List<Client>?> getClientById({accessToken, clientId}) async {
    List<Client> clients = [];
    var result = await clientRepo.getClientById(
        accessToken: accessToken, clientId: clientId);

    if (result.isSuccess) {
      for (int i = 0; i < result.data.length; i += 1) {
        clients.add(result.data[i]);
      }
      return clients;
    } else {
      print(result.message);
      return null;
    }
  }

  static Future<String?> saveClient(
      {accessToken, createdById, name, attribute, clientId}) async {
    var result = await clientRepo.saveClient(
        accessToken: accessToken,
        createdById: createdById,
        name: name,
        attribute: attribute,
        clientId: clientId);

    if (result.isSuccess) {
      return result.data;
    } else {
      print(result.message);
      return null;
    }
  }

  static Future<String?> deleteClient({accessToken, clientId}) async {
    var result = await clientRepo.deleteClient(
        accessToken: accessToken, clientId: clientId);

    if (result.isSuccess) {
      return result.data;
    } else {
      print(result.message);
      return null;
    }
  }

  static Future<List<Role>?> getAllRoles({accessToken}) async {
    List<Role> clients = [];
    var result = await roleRepo.getAllRoles(accessToken: accessToken);

    if (result.isSuccess) {
      for (int i = 0; i < result.data.length; i += 1) {
        clients.add(result.data[i]);
      }
      return clients;
    } else {
      print(result.message);

      return null;
    }
  }

  static Future<List<Role>?> getRoleById({accessToken, roleId}) async {
    List<Role> roles = [];
    var result =
        await roleRepo.getRoleById(accessToken: accessToken, roleId: roleId);

    if (result.isSuccess) {
      for (int i = 0; i < result.data.length; i += 1) {
        roles.add(result.data[i]);
      }
      return roles;
    } else {
      print(result.message);
      return null;
    }
  }

  static Future<String?> saveRole(
      {accessToken, createdById, name, attribute, roleId}) async {
    var result = await roleRepo.saveRole(
        accessToken: accessToken,
        createdById: createdById,
        name: name,
        attribute: attribute,
        roleId: roleId);

    if (result.isSuccess) {
      return result.data;
    } else {
      print(result.message);
      return null;
    }
  }

  static Future<String?> deleteRole({accessToken, roleId}) async {
    var result =
        await roleRepo.deleteRole(accessToken: accessToken, roleId: roleId);

    if (result.isSuccess) {
      return result.data;
    } else {
      print(result.message);
      return null;
    }
  }

  static Future<List<Relationship>?> getAllRelationship({accessToken}) async {
    List<Relationship> relationships = [];
    var result =
        await relationshipRepo.getAllRelationships(accessToken: accessToken);

    if (result.isSuccess) {
      for (int i = 0; i < result.data.length; i += 1) {
        relationships.add(result.data[i]);
      }
      return relationships;
    } else {
      print(result.message);

      return null;
    }
  }

  static Future<List<Relationship>?> getRelationshipById(
      {accessToken, clientRoleRelId}) async {
    List<Relationship> relationships = [];
    var result = await relationshipRepo.getRelationshipById(
        accessToken: accessToken, clientRoleRelId: clientRoleRelId);

    if (result.isSuccess) {
      for (int i = 0; i < result.data.length; i += 1) {
        relationships.add(result.data[i]);
      }
      return relationships;
    } else {
      print(result.message);
      return null;
    }
  }

  static Future<String?> saveRelationship(
      {accessToken,
      createdById,
      clientRoleRelId,
      permission,
      client,
      role}) async {
    var result = await relationshipRepo.saveRelationship(
        accessToken: accessToken,
        createdById: createdById,
        clientRoleRelId: clientRoleRelId,
        permission: permission,
        role: role,
        client: client);

    if (result.isSuccess) {
      return result.data;
    } else {
      print(result.message);
      return null;
    }
  }

  static Future<String?> deleteRelationship(
      {accessToken, clientRoleRelId}) async {
    var result = await relationshipRepo.deleteRelationship(
        accessToken: accessToken, clientRoleRelId: clientRoleRelId);

    if (result.isSuccess) {
      return result.data;
    } else {
      print(result.message);
      return null;
    }
  }

  static Future<String?> isAuthorized(
      {accessToken, roleId, clientId, permission}) async {
    var result = await relationshipRepo.isAuthorized(
        accessToken: accessToken,
        roleId: roleId,
        clientId: clientId,
        permission: permission);

    if (result.isSuccess) {
      return result.data.toString();
    } else {
      print(result.message);
      return null;
    }
  }
}
