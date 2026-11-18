enum Role { user, ai }

class User {
  final String id, name, email;
  const User({required this.id, required this.name, required this.email});
}

class Message {
  final String id, text;
  final Role role;
  final DateTime time;
  Message(this.role, this.text) : id = DateTime.now().microsecondsSinceEpoch.toString(), time = DateTime.now();
  factory Message.user(String t) => Message(Role.user, t);
  factory Message.ai(String t) => Message(Role.ai, t);
}

class Conversation {
  final String id;
  String title;
  final List<Message> messages;
  Conversation({required this.id, required this.title, List<Message>? messages}) : messages = messages ?? [];
  factory Conversation.empty() => Conversation(id: DateTime.now().microsecondsSinceEpoch.toString(), title: 'New chat');
}

class UserSettings {
  bool notifications;
  String language;
  UserSettings({this.notifications = true, this.language = 'English'});
}
