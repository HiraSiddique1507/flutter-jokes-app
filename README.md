About Project

This is a Flutter-based Jokes App developed as a semester project.
The app provides jokes in different categories and allows users to interact with jokes.
It works offline for favorite jokes using Hive, and all other jokes are now stored in Firebase Firestore.

Features

View Jokes in Different Categories – Tech, Funny, General

Search Jokes – Search jokes by text

Add New Jokes – Users can add their own jokes

Edit Jokes – Update existing jokes

Delete Jokes – Remove jokes from the list

Random Joke Generator – Show a random joke

Save Favorite Jokes – Mark jokes as favorite (stored locally using Hive)

About App Page – Shows app info, developer, tools used

Offline Support – Favorite jokes accessible offline

Technologies Used

Flutter – Frontend

Dart – Programming language

Firebase Firestore – Store jokes online

Hive Database – Store favorite jokes offline

VS Code – Development IDE

GitHub – Version control

Database

Firebase Firestore

Collection: jokes → Stores all jokes

Each document contains:

text → Joke text

category → Tech / Funny / General

createdAt → Timestamp

Hive NoSQL Database

Box: favoritesBox → Stores favorite jokes locally

Data format: { "text": "...", "category": "..." }

Developer
Hira Siddique
