// Import the library.
import 'package:signalr_netcore/signalr_client.dart';

// The location of the SignalR Server.
final serverUrl = "192.168.10.50:51001";
// Creates the connection by using the HubConnectionBuilder.
final hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();
// When the connection is closed, print out a message to the console.

