import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:audioplayers/audioplayers.dart';
import 'package:admin_pannel/core/services/models/order/order.dart';

class OrderAlertService {
  static final OrderAlertService _instance = OrderAlertService._internal();

  factory OrderAlertService() => _instance;

  OrderAlertService._internal();

  late WebSocketChannel _channel;
  final AudioPlayer _player = AudioPlayer();
  bool _connected = false;
  late GlobalKey<NavigatorState> _navigatorKey;

  void start(String socketUrl, GlobalKey<NavigatorState> navigatorKey) {
    if (_connected) return;

    _navigatorKey = navigatorKey;

    try {
      _channel = WebSocketChannel.connect(Uri.parse(socketUrl));
      _connected = true;
      print('🟢 WebSocket connected: $socketUrl');

      _channel.stream.listen(
        (message) {
          try {
            final json = jsonDecode(message);
            final order = OrderModel.fromJson(json);
            _playSound();
            _showOrderDialog(order);
            print('🔔 New order received: ${order.id}');
          } catch (e) {
            print('⚠️ Error decoding order: $e');
          }
        },
        onDone: () {
          print('🔌 WebSocket closed');
          _reconnect(socketUrl);
        },
        onError: (error) {
          print('❌ WebSocket error: $error');
          _reconnect(socketUrl);
        },
      );
    } catch (e) {
      print('🚫 Failed to connect to WebSocket: $e');
    }
  }

  void _reconnect(String socketUrl) async {
    _connected = false;
    await Future.delayed(const Duration(seconds: 5));
    print('🔁 Reconnecting to WebSocket...');
    start(socketUrl, _navigatorKey);
  }

  void _playSound() async {
    try {
      await _player.setReleaseMode(ReleaseMode.loop);
      await _player.play(AssetSource('sounds/order_alert.mp3'));

      // Stop the sound after 10 seconds automatically
      Future.delayed(const Duration(seconds: 10), () {
        _player.stop();
        _player.setReleaseMode(ReleaseMode.release);
      });
    } catch (e) {
      print('🎵 Failed to play sound: $e');
    }
  }

  void dispose() {
    _channel.sink.close(status.goingAway);
    _player.dispose();
  }

  void _showOrderDialog(OrderModel order) {
    final context = _navigatorKey.currentContext;
    if (context == null) return;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('🛒 New Order Received'),
          content: Text('Order ID: ${order.id}'),
          actions: [
            TextButton(
              onPressed: () {
                _player.stop();
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
