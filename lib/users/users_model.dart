class User {
  int id;
  String name;
  String role;
  String description;
  int age;
  String learningType;

  // Constructor
  User({
    required this.id,
    required this.name,
    required this.role,
    required this.description,
    required this.age,
    required this.learningType,
  });
}
  List<User> users = [
    User(
        id: 1,
        name: 'Jacky Suwandi',
        role: 'Just Need A Friend',
        description: 'Hello, My name is Jacky Suwandi. Im majoring in Cyber Security'
            'I need someone to chat while i study. Swipe right if you want :).',
        age: 19,
        learningType: 'Pomodoro'
    ),
    User(
        id: 1,
        name: 'Fernando Morientes',
        role: 'Open to Learn',
        description: 'Majoring in Cyber Security. Need to learn coding'
            'Hit me up if you feel can teach me one or two things!.',
        age: 20,
        learningType: 'Chill'
    ),
  ];


