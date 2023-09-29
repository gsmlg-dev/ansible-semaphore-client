import 'package:ansible_semaphore/ansible_semaphore.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:semaphore/database/database.dart';
import 'package:semaphore/database/schema/semaphore_server.dart';

part 'server.g.dart';

@riverpod
class Servers extends _$Servers {
  @override
  List<SemaphoreServer> build() {
    try {
      final db = Database().instance;
      return db.txnSync(() {
        return db.semaphoreServers.where().idGreaterThan(0).findAllSync();
      });
    } catch (e) {
      return <SemaphoreServer>[];
    }
  }

  void putServer(SemaphoreServer server) {
    final db = Database().instance;
    db.writeTxnSync(() {
      db.semaphoreServers.putSync(server..password = null);
    });
    reload();
  }

  void reload() {
    state = build();
  }

  void activeServer(SemaphoreServer server) {
    final db = Database().instance;
    db.writeTxnSync(() {
      db.semaphoreServers
          .putAllSync(state.map((s) => s..isActive = false).toList());
      db.semaphoreServers.putSync(server..isActive = true);
    });
    reload();
  }

  void removeServer(SemaphoreServer server) {
    final db = Database().instance;
    db.writeTxnSync(() {
      db.semaphoreServers.deleteSync(server.id);
    });
    reload();
  }

  SemaphoreServer? currentServer() {
    final s = state.firstWhere((s) => s.isActive == true,
        orElse: () => SemaphoreServer());
    if (s.isActive == null) {
      return null;
    }
    return s;
  }
}

@riverpod
class ServerFamily extends _$ServerFamily {
  @override
  SemaphoreServer? build(int? serverId) {
    if (serverId == null) {
      return null;
    }
    try {
      final db = Database().instance;
      return db.txnSync(() {
        return db.semaphoreServers.filter().idEqualTo(serverId).findFirstSync();
      });
    } catch (e) {
      return null;
    }
  }
}

@riverpod
class ServerFormState extends _$ServerFormState {
  @override
  SemaphoreServer build(SemaphoreServer? server) {
    if (server == null) {
      return SemaphoreServer();
    }
    return server;
  }

  void updateWith({
    String? name,
    String? apiUrl,
    String? username,
    String? password,
    String? token,
  }) {
    state = SemaphoreServer()
      ..id = state.id
      ..isActive = state.isActive
      ..createdAt = state.createdAt
      ..name = name ?? state.name
      ..apiUrl = apiUrl ?? state.apiUrl
      ..username = username ?? state.username
      ..password = password ?? state.password
      ..token = token ?? state.token;
  }

  Future<String?> getTokenFromServer() async {
    final api = AnsibleSemaphore(
      basePathOverride: state.apiUrl,
    );

    final result = await api.getAuthenticationApi().authLoginPost(
        loginBody: Login(auth: state.username, password: state.password));
    final headers = result.headers;
    final cookie = headers.value('set-cookie');

    final resp = await api
        .getAuthenticationApi()
        .userTokensPost(headers: {'cookie': cookie});

    final data = resp.data;
    if (data != null && data.id != null) {
      return data.id;
    } else {
      return null;
    }
  }
}
