import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await Hive.openBox('favoritesBox');
 // await uploadInitialJokesToFirebase();
  runApp(const MyApp());
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
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "Laugh, relax and enjoy the best jokes anytime!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ),
            const SizedBox(height: 50),
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Made with ❤️ for fun",
              style: TextStyle(color: Colors.white70, fontSize: 14),
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
    var favoritesBox = Hive.box('favoritesBox');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Jokes"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final result = await showSearch(
                context: context,
                delegate: JokeSearchDelegate(),
              );
              if (result != null) setState(() => searchText = result);
            },
          ),
          IconButton(
            icon: const Icon(Icons.casino),
            onPressed: () async {
              final snapshot =
                  await FirebaseFirestore.instance.collection('jokes').get();
              final docs = snapshot.docs;
              if (docs.isEmpty) return;
              final random = Random();
              final joke = docs[random.nextInt(docs.length)];
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
            onPressed: () => Navigator.pushNamed(context, '/about'),
          ),
        ],
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
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('jokes').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final docs = snapshot.data!.docs
                    .where((joke) =>
                        selectedCategory == 'All' ||
                        joke['category'] == selectedCategory)
                    .toList();
                if (searchText.isNotEmpty) {
                  docs.retainWhere((j) => j['text']
                      .toString()
                      .toLowerCase()
                      .contains(searchText.toLowerCase()));
                }
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final joke = docs[index];
                    final isFav = favoritesBox.values
                        .any((fav) => fav['text'] == joke['text']);

                    return Card(
                      child: ListTile(
                        title: Text(joke['text']),
                        subtitle: Text(joke['category']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                color: isFav ? Colors.red : null,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (isFav) {
                                    final key = favoritesBox.keys.firstWhere(
                                      (k) => favoritesBox.get(k)['text'] ==
                                          joke['text'],
                                    );
                                    favoritesBox.delete(key);
                                  } else {
                                    favoritesBox.add({
                                      'text': joke['text'],
                                      'category': joke['category'],
                                    });
                                  }
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                showEditJokeDialog(
                                    context, joke, joke.id);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.grey),
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('jokes')
                                    .doc(joke.id)
                                    .delete();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
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
              decoration: const InputDecoration(hintText: "Write your joke here"),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedCategory,
              items: ['Tech', 'Funny', 'General']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                selectedCategory = value!;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              if (jokeController.text.isNotEmpty) {
                FirebaseFirestore.instance.collection('jokes').add({
                  'text': jokeController.text,
                  'category': selectedCategory,
                  'createdAt': Timestamp.now(),
                });
                Navigator.pop(context);
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  void showEditJokeDialog(BuildContext context, dynamic joke, String docId) {
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
            TextField(controller: jokeController),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: category,
              items: ['Tech', 'Funny', 'General']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                category = value!;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              FirebaseFirestore.instance.collection('jokes').doc(docId).update({
                'text': jokeController.text,
                'category': category,
              });
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
  @override
  Widget buildResults(BuildContext context) => Container();

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('jokes').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();
        final docs = snapshot.data!.docs;
        return ListView(
          children: docs.map<Widget>((j) => ListTile(
            title: Text(j['text']),
          )).toList(),
        );
      },
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
      appBar: AppBar(title: const Text("About App")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Jokes App 😂",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Version: 3.1.0"),
            SizedBox(height: 10),
            Text(
                "This is a semester project developed using Flutter. The app provides jokes in different categories such as Tech, Funny, and General. It works completely offline using Hive database for favorites and Firebase Firestore for jokes."),
            SizedBox(height: 20),
            Text("Developer:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Hira Siddique"),
            SizedBox(height: 20),
            Text("Tools Used:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("- Flutter\n- Dart\n- Hive Database (Favorites)\n- Firebase Firestore (Jokes)"),
          ],
        ),
      ),
    );
  }
}
