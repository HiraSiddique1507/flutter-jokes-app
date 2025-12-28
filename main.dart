import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('jokesBox');
  await Hive.openBox('favoritesBox');

  addJokesIfEmpty();
  runApp(const MyApp());
}

void addJokesIfEmpty() {
  var box = Hive.box('jokesBox');

  if (box.isEmpty) {
    box.addAll([
      {"text": "Why don’t programmers like nature? Too many bugs.", "category": "Tech"},
      {"text": "Why do Java developers wear glasses? Because they don’t see sharp.", "category": "Tech"},
      {"text": "Debugging is like being a detective.", "category": "Tech"},
      {"text": "Why was the computer cold? It forgot to close Windows.", "category": "Funny"},
      {"text": "I told my computer I needed a break, it froze.", "category": "Funny"},
  {"text": "There are 10 types of people in the world: those who understand binary and those who don’t.", "category": "Tech"},
  {"text": "Why did the student eat his homework? Because the teacher said it was a piece of cake.", "category": "General"},
  {"text": "My computer is so slow, it started buffering my thoughts.", "category": "Tech"},
  {"text": "Why don’t programmers like nature? Too many bugs.", "category": "Tech"},
  {"text": "I told my phone to behave, now it’s on silent mode.", "category": "General"},
  {"text": "Why was the math book sad? Because it had too many problems.", "category": "General"},
  {"text": "My WiFi and I have a love-hate relationship.", "category": "Tech"},
  {"text": "Why did the computer go to the doctor? Because it caught a virus.", "category": "Tech"},
  {"text": "Student life is when you study nothing and worry about everything.", "category": "General"},
  {"text": "I put my phone on airplane mode, but it didn’t fly.", "category": "General"},
  {"text": "Why did the programmer quit his job? Because he didn’t get arrays.", "category": "Tech"},
  {"text": "Exams are easy, it’s remembering the answers that’s hard.", "category": "General"},
  {"text": "My brain has too many tabs open.", "category": "General"},
  {"text": "Why was the computer cold? It forgot to close Windows.", "category": "Tech"},
  {"text": "I started studying, but my phone needed me more.", "category": "General"},
  {"text": "Debugging is like being a detective in a crime movie where you are also the criminal.", "category": "Tech"},
  {"text": "I set my alarm early, just to turn it off confidently.", "category": "General"},
  {"text": "Why do Java developers wear glasses? Because they don’t see sharp.", "category": "Tech"},
  {"text": "Homework teaches us responsibility, especially avoiding it.", "category": "General"},
  {"text": "My laptop understands me, it also freezes under pressure.", "category": "Tech"},
  {"text": "Why did the student bring a ladder to class? Because education is about climbing.", "category": "General"},
  {"text": "A clean code is like a clean room, very rare.", "category": "Tech"},
  {"text": "I have a lot of motivation, it’s just not active right now.", "category": "General"},
  {"text": "Why was the smartphone tired? Too many apps running.", "category": "Tech"},
  {"text": "Studying last night is my favorite plan.", "category": "General"},
  {"text": "The best thing about a computer is the undo button.", "category": "Tech"},
  {"text": "I’m not lazy, I’m on energy-saving mode.", "category": "General"},
  {"text": "Why do programmers prefer dark mode? Because light attracts bugs.", "category": "Tech"},
  {"text": "Online classes taught me multitasking: sleep and listen.", "category": "General"},
  {"text": "My code works, I don’t know why.", "category": "Tech"},
  {"text": "Teacher: Any questions? Students: No signal.", "category": "Funny"},
  {"text": "My life feels like a test I didn’t study for.", "category": "Funny"},
  {"text": "When my phone falls, my heart skips a beat.", "category": "Funny"},
  {"text": "Online exams are just open-book tests with trust issues.", "category": "Funny"},
  {"text": "Student diary has only one line: Kal se pakka parhai.", "category": "Funny"},
  {"text": "I opened my book and my brain went offline.", "category": "Funny"},
  {"text": "My motivation comes and goes like WiFi signals.", "category": "Funny"},
  {"text": "I study best when exams are already over.", "category": "Funny"},
  {"text": "Brain.exe stopped working during exams.", "category": "Funny"},
  {"text": "I planned to study, but then I needed a break.", "category": "Funny"},
  {"text": "When syllabus is huge and time is small, Allah Malik hai.", "category": "Funny"},
  {"text": "I don’t skip class, my alarm does.", "category": "Funny"},
  {"text": "Student life is stress with free memes.", "category": "Funny"},
  {"text": "I read the question paper like it’s a horror story.", "category": "Funny"},
  {"text": "My sleep schedule is more confused than me.", "category": "Funny"},
  {"text": "I joined the online class for attendance only.", "category": "Funny"},
  {"text": "Homework sees me, I pretend I didn’t see it.", "category": "Funny"},
  {"text": "Exams test memory, not intelligence.", "category": "Funny"},
    ]);
  }
}

// ---------------- APP ----------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jokes App',
      routes: {
        '/': (context) => const WelcomePage(),
        '/jokes': (context) => const JokesPage(),
        '/favorites': (context) => const FavoritesPage(),
        '/about': (context) => const AboutPage(),
      },
    );
  }
}

// ---------------- WELCOME PAGE ----------------
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF6A11CB),
              Color(0xFF2575FC),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Icon
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.emoji_emotions,
                size: 80,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 30),

            // App Title
            const Text(
              "Jokes App 😂",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),

            const SizedBox(height: 10),

            // Subtitle
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "Laugh, relax and enjoy the best jokes anytime!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ),

            const SizedBox(height: 50),

            // Get Started Button
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/jokes');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blueAccent,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 10,
              ),
              child: const Text(
                "Get Started",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Footer Text
            const Text(
              "Made with ❤️ for fun",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// ---------------- JOKES PAGE ----------------
class JokesPage extends StatefulWidget {
  const JokesPage({super.key});

  @override
  State<JokesPage> createState() => _JokesPageState();
}

class _JokesPageState extends State<JokesPage> {
  String searchText = '';
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    var jokesBox = Hive.box('jokesBox');
    var favoritesBox = Hive.box('favoritesBox');

    List jokes = jokesBox.values.where((joke) {
      final textMatch = joke['text']
          .toString()
          .toLowerCase()
          .contains(searchText.toLowerCase());
      final categoryMatch =
          selectedCategory == 'All' || joke['category'] == selectedCategory;
      return textMatch && categoryMatch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Jokes"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final result = await showSearch(
                context: context,
                delegate: JokeSearchDelegate(jokesBox.values.toList()),
              );
              if (result != null) {
                setState(() => searchText = result);
              }
            },
          ),
             IconButton(
            icon: const Icon(Icons.casino),
            onPressed: () {
              final random = Random();
              final joke = jokesBox.getAt(random.nextInt(jokesBox.length));
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Random Joke"),
                  content: Text(joke['text']),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => Navigator.pushNamed(context, '/favorites'),
          ),
           IconButton(
  icon: const Icon(Icons.info_outline),
  onPressed: () {
    Navigator.pushNamed(context, '/about');
  },
),  ],
      ),
      floatingActionButton: FloatingActionButton(
  onPressed: () {
    showAddJokeDialog(context);
  },
  child: const Icon(Icons.add),
),

      body: Column(
        children: [
          DropdownButton<String>(
            value: selectedCategory,
            items: ['All', 'Tech', 'Funny', 'General']
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (value) {
              setState(() => selectedCategory = value!);
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                final joke = jokes[index];
                final isFav = favoritesBox.values
                    .any((fav) => fav['text'] == joke['text']);

                return Card(
                  child: ListTile(
                    title: Text(joke['text']),
                    subtitle: Text(joke['category']),
                    trailing: Row(
  mainAxisSize: MainAxisSize.min,
  children: [

    // ❤️ Favorite
    IconButton(
      icon: Icon(
        isFav ? Icons.favorite : Icons.favorite_border,
        color: isFav ? Colors.red : null,
      ),
      onPressed: () {
        setState(() {
          if (isFav) {
            final key = favoritesBox.keys.firstWhere(
              (k) => favoritesBox.get(k)['text'] == joke['text'],
            );
            favoritesBox.delete(key);
          } else {
            favoritesBox.add(joke);
          }
        });
      },
    ),

    // ✏️ EDIT
    IconButton(
      icon: const Icon(Icons.edit, color: Colors.blue),
      onPressed: () {
        showEditJokeDialog(
          context,
          joke,
          jokesBox.values.toList().indexOf(joke),
        );
      },
    ),

    // 🗑 DELETE
    IconButton(
      icon: const Icon(Icons.delete, color: Colors.grey),
      onPressed: () {
        jokesBox.deleteAt(
          jokesBox.values.toList().indexOf(joke),
        );
        setState(() {});
      },
    ),
      ],
),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  void showAddJokeDialog(BuildContext context) {
  final TextEditingController jokeController = TextEditingController();
  String selectedCategory = 'General';

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text("Add Your Joke"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: jokeController,
            decoration: const InputDecoration(
              hintText: "Write your joke here",
            ),
          ),
          const SizedBox(height: 10),
          DropdownButton<String>(
            value: selectedCategory,
            items: ['Tech', 'Funny', 'General']
                .map((e) =>
                    DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (value) {
              selectedCategory = value!;
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            if (jokeController.text.isNotEmpty) {
              Hive.box('jokesBox').add({
                "text": jokeController.text,
                "category": selectedCategory,
              });
              setState(() {});
              Navigator.pop(context);
            }
          },
          child: const Text("Add"),
        ),
      ],
    ),
  );
}
void showEditJokeDialog(BuildContext context, dynamic joke, int index) {
  final TextEditingController jokeController =
      TextEditingController(text: joke['text']);

  String category = joke['category'];

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text("Edit Joke"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: jokeController,
          ),
          const SizedBox(height: 10),
          DropdownButton<String>(
            value: category,
            items: ['Tech', 'Funny', 'General']
                .map((e) =>
                    DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (value) {
              category = value!;
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            Hive.box('jokesBox').putAt(index, {
              "text": jokeController.text,
              "category": category,
              "author": joke['author'],
            });
            setState(() {});
            Navigator.pop(context);
          },
          child: const Text("Save"),
        ),
      ],
    ),
  );
}
}

// ---------------- FAVORITES PAGE ----------------
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('favoritesBox');

    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: ListView.builder(
        itemCount: box.length,
        itemBuilder: (context, index) {
          final joke = box.getAt(index);
          return ListTile(
            title: Text(joke['text']),
            subtitle: Text(joke['category']),
          );
        },
      ),
    );
  }
}

// ---------------- SEARCH DELEGATE ----------------
class JokeSearchDelegate extends SearchDelegate {
  final List jokes;

  JokeSearchDelegate(this.jokes);

  @override
  Widget buildResults(BuildContext context) => Container();

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = jokes
        .where((j) => j['text']
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();

    return ListView(
      children: results
          .map((j) => ListTile(title: Text(j['text'])))
          .toList(),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
      ];

  @override
  Widget buildLeading(BuildContext context) =>
      IconButton(onPressed: () => close(context, query), icon: const Icon(Icons.arrow_back));
}  
// ---------------- ABOUT APP PAGE ----------------
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Jokes App 😂",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),

            Text("Version: 3.1.0"),
            SizedBox(height: 10),

            Text(
              "This is a semester project developed using Flutter. "
              "The app provides jokes in different categories such as "
              "Tech, Funny, and General. "
              "It works completely offline using Hive database.",
            ),

            SizedBox(height: 20),

            Text(
              "Developer:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("Hira Siddique"),

            SizedBox(height: 20),

            Text(
              "Tools Used:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("- Flutter\n- Dart\n- Hive Database"),
          ],
        ),
      ),
    );
  }
}
