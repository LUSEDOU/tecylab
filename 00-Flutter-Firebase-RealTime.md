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

![Flutter icon](./img/img.png){ height=100px }

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

::: columns

:::: column

## Fresh Project

```bash
npm install -g firebase-tools
firebase login
dart pub global activate flutterfire_cli
flutterfire configure

flutter pub add firebase_core
flutter pub add firebase_database
flutter pub add firebase_auth
```

::::

:::: column

![My Firebase config](./img/img.png){ height=100px }

::::

:::

---

# Firebase Setup

