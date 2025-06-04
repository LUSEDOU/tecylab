---
author: Luis Dolorier
title: FFR - Fluter & Firebase & Real Time Database
date: 2025-06-05
institute: "Tecylab"
theme: "Copenhagen"
fontsize: 10pt
linkstyle: bold
aspectratio: 169
...


# Flutter

::: columns

:::: column

![Flutter icon](./img/img.png){ height=150px }

::::

:::: column

![My Firebase config](./img/qr.png){ height=150px }

::::

:::

---

# Backend as a Service

::: columns

:::: column

![Firabase logo](./img/firabase.png){ height=100px }

![Supabase](./img/supabase.png){ height=100px }

::::

:::: column

![Pocketbase](./img/pocketbase.png){ height=100px }

![Turso](./img/turso.png){ height=100px }

::::

:::


---

# The Real Time Ilusion

- Polling vs Sockets vs Server-Sent Events
- Firebase Realtime Database = WebSockets
- `Stream<T>`

---

# Firebase Setup

## Fresh Project

```bash
npm install -g firebase-tools
firebase login
dart pub global activate flutterfire_cli
flutterfire configure
```

---

# Firebase Setup

## Add Packages

```bash
flutter pub add firebase_core
flutter pub add firebase_database
flutter pub add firebase_auth
```

---

# Firebase Setup

## Initialize Firebase

```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseDatabase.instance;
  FirebaseAuth.instance;
  runApp(MyApp());
}
```

---

# Firebase Setup

## Firebase Auth
```dart
import 'package:firebase_auth/firebase_auth.dart';

await FirebaseAuth.instance.signInWithEmailAndPassword(
  email: email,
  password: password,
);
```

# Firebase Setup

## Firebase Realtime Database

```dart
import 'package:firebase_database/firebase_database.dart';

FirebaseDatabase.instance
  .ref()
  .onChildAdded(
    (event) => print('New child added: ${event.snapshot.value}'),
  );
```
