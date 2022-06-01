library zeus_api;

import 'package:zeus_api/services/api/model/relationship_model.dart';
import 'package:zeus_api/services/api/model/role_model.dart';
import 'package:zeus_api/utils/compilation.dart';

import 'services/api/model/client_model.dart';

class ZeusControl {
  static Future<Map<String, dynamic>?> getTokens({email, password}) async =>
      (await APICompile.getAccessToken(email: email, password: password));

  static Future<List<Client>?> getAllClients({accessToken}) async =>
      (await APICompile.getAllClients(accessToken: accessToken));

  static Future<List<Client>?> getClientById({accessToken, clientId}) async =>
      await APICompile.getClientById(
          accessToken: accessToken, clientId: clientId);
  static Future<String?> saveClient(
          {accessToken, createdById, name, attribute, clientId}) async =>
      await APICompile.saveClient(
          accessToken: accessToken,
          createdById: createdById,
          name: name,
          attribute: attribute,
          clientId: clientId);
  static Future<String?> deleteClient({accessToken, clientId}) async =>
      await APICompile.deleteClient(
          accessToken: accessToken, clientId: clientId);

  static Future<List<Role>?> getAllRoles({accessToken}) async =>
      (await APICompile.getAllRoles(accessToken: accessToken));

  static Future<List<Role>?> getRoleById({accessToken, roleId}) async =>
      await APICompile.getRoleById(accessToken: accessToken, roleId: roleId);
  static Future<String?> saveRole(
          {accessToken, createdById, name, attribute, roleId}) async =>
      await APICompile.saveRole(
          accessToken: accessToken,
          createdById: createdById,
          name: name,
          attribute: attribute,
          roleId: roleId);
  static Future<String?> deleteRole({accessToken, roleId}) async =>
      await APICompile.deleteRole(accessToken: accessToken, roleId: roleId);

  static Future<List<Relationship>?> getAllRelationship({accessToken}) async =>
      (await APICompile.getAllRelationship(accessToken: accessToken));

  static Future<List<Relationship>?> getRelationshipById(
          {accessToken, clientRoleRelId}) async =>
      await APICompile.getRelationshipById(
          accessToken: accessToken, clientRoleRelId: clientRoleRelId);

  static Future<String?> saveRelationship(
          {accessToken,
          createdById,
          clientRoleRelId,
          permission,
          client,
          role}) async =>
      await APICompile.saveRelationship(
          accessToken: accessToken,
          createdById: createdById,
          clientRoleRelId: clientRoleRelId,
          permission: permission,
          client: client,
          role: role);

  static Future<String?> deleteRelationship(
          {accessToken, clientRoleRelId}) async =>
      await APICompile.deleteRelationship(
          accessToken: accessToken, clientRoleRelId: clientRoleRelId);
  static Future<String?> isAuthorized(
          {accessToken, roleId, clientId, permission}) async =>
      await APICompile.isAuthorized(
        accessToken: accessToken,
        clientId: clientId,
        roleId: roleId,
        permission: permission,
      );
}
