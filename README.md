This is a set of access control API which is listed in the Zeus API documentation. 
The usage, requests and responses are same as the Zeus API documentation.

## Features

It allows you to implement the access control system more easily by assigning the
client to a role with a specifc permission.

## Getting started

Register an account in Zeus API official web first before using this plugin.

## Usage

```dart
import 'package:zeus_api/services/api/model/client_model.dart';
import 'package:zeus_api/zeus_api.dart';

// Get Tokens
var tokens = await ZeusControl.getTokens(
        email: "email@domain.com", password: "123456");

// Get All Clients
List<Client>? clients = await ZeusControl.getAllClients(
      accessToken: _accessToken,
    );
```

## Additional information

To know more information, you can read https://nine-temple-484.notion.site/Zeus-API-Documentation-8d6c0c695fa445f4a237357ce9739562.
