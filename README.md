# 📱 LaymanApp

LaymanApp is a simple and intuitive iOS application that helps users understand business, tech, and startup news in **easy, conversational language**.

It combines real-time news, authentication, and an AI-powered chatbot to deliver information in a way anyone can understand.

---

## 🚀 Features

### 🔐 Authentication

* User Sign Up & Login using Supabase

* Secure session handling

* User profile with name & email

* Logout functionality

### 📰 Home (Articles Screen)

* Featured articles carousel (horizontal swipe)

* “Today’s Picks” section (vertical list)

* Clean UI with readable headlines

* Articles fetched from News API

### 📖 Article Detail Screen

* Article image and headline

* 3 swipeable content cards (simple explanations)

* Bookmark (Save) functionality

* Share & open original article inside app

* "Ask Layman" AI chatbot button

### ❤️ Saved Screen

* Save articles with bookmark icon

* View saved articles in list format

* Persistent UI for saved content

### 👤 Profile Screen

* Displays user name and email

* Settings / Help UI (basic)

* Sign out functionality

### 🤖 Ask Layman (AI Chat)

* Context-aware chatbot (based on selected article)

* 3 auto-generated question suggestions

* Simple 1–2 sentence answers

* Built using Google Gemini API

---

## 🧠 Tech Stack

* **SwiftUI** (UI Development)

* **MVVM Architecture**

* **Supabase** (Authentication)

* **NewsData API** (Articles)

* **Google Gemini API** (AI Chat)

* **Swift Package Manager** (Dependencies)

---

## ⚙️ Setup Instructions

### 1. Clone the repository

```

git clone https://github.com/yourusername/LaymanApp.git

```

### 2. Open in Xcode

```

LaymanApp.xcodeproj

```

### 3. Add API Keys

Open `Config.swift` and replace:

```swift

static let geminiAPIKey = "YOUR_GEMINI_KEY"

static let newsAPIKey = "YOUR_NEWS_API_KEY"

```

👉 Get keys from:

* Gemini API: https://aistudio.google.com/app/apikey

* News API: https://newsdata.io

---

### 4. Run the app

* Select simulator

* Click ▶️ Run

---

## 📌 Notes

* Dependencies are managed via **Swift Package Manager**

* Packages will automatically install when opening the project

* No manual setup required for libraries

---

## 🎯 Highlights

* Clean and modern SwiftUI UI

* Real-time API integration

* AI-powered contextual chat

* User-friendly and minimal design

* Fully functional end-to-end flow

---

## 📧 Author

**Raghavendra Chary**

iOS Developer

---

## ⭐️ If you like this project

Give it a ⭐️ on GitHub!
