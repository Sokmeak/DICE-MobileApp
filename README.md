


# EduFunApp 📱🎓  
**"Engage, Learn, and Excel – All in Real-Time!"**

EduFunApp is a cross-platform mobile application designed to revolutionize education and training through real-time, gamified quizzes. It enhances classroom engagement by offering live quizzes, instant feedback, and comprehensive performance analytics, creating an interactive and dynamic learning experience.

---

## 📌 Project Overview

### 🔍 Problem Statement
- **Limited Engagement**: Traditional classroom settings often lack real-time interaction.  
- **Inefficient Processes**: Paper-based quizzes are time-consuming and resource-intensive.  
- **Accessibility Barriers**: Many quiz platforms restrict features for free users.  

### ✅ Solution
EduFunApp addresses these challenges by providing:

- **Live Quizzes**: Real-time scoring and immediate feedback.  
- **Gamified Experience**: Engaging leaderboards, points, and badges.  
- **Analytics Dashboard**: Detailed insights for teachers to track student progress.

---

## 🚀 Features

### 👩‍🏫 For Teachers
- Create and manage quizzes with diverse question types (e.g., multiple-choice, true/false).  
- Launch live quizzes and monitor real-time student responses.  
- Access detailed performance analytics and exportable reports.  
- Offline quiz creation for flexibility.

### 👨‍🎓 For Students
- Join live quizzes with instant scoring and feedback.  
- Compete on global or class-specific leaderboards.  
- Review past quizzes and track personal progress.

### 🌐 General
- **Gamification**: Earn points, unlock badges, and climb leaderboards.  
- **Cross-Platform**: Available on iOS, Android, and Web.  
- **Scalable Architecture**: Built to handle large-scale quiz sessions.

---

## 🛡️ Security
- **End-to-End Encryption**: Protects user data during transmission.  
- **OAuth 2.0 & 2FA**: Secure authentication with Passport.js integration.  
- **Role-Based Access Control (RBAC)**: Ensures appropriate access levels.  
- **Regular Audits**: Ongoing security assessments to maintain integrity.

---

## 🛠️ Tech Stack

### 🔧 Frontend (Mobile & Web)
- **Framework**: Flutter (Dart)  
- **Why Flutter?** Cross-platform development, high performance, and rich UI components for a seamless user experience.

### 🔧 Backend
- **Framework**: NestJS (TypeScript)  
- **Why NestJS?**  
  - Modular architecture for scalability  
  - Native WebSocket support for real-time quiz functionality  
  - TypeScript for type safety and maintainability

- **Database**: PostgreSQL  
  - Robust, scalable, and reliable for handling quiz data.

- **Real-Time Layer**: Redis + WebSocket Gateway  
- **Authentication**: OAuth 2.0 via Passport.js

### ☁️ Hosting
- **AWS or Google Cloud Platform**  
  - Scalable infrastructure with load balancing and auto-scaling.

---

## 🖌️ Design

- **Tool**: Figma for wireframes and prototyping.  

### User Flows
**Teachers**:  
`Login → Create Quiz → Launch Quiz → Monitor Responses → Export Reports`

**Students**:  
`Login → Join Quiz → Answer Questions → View Results → Track Progress`

---

## 📲 Installation (Flutter App)

### Prerequisites
- Flutter SDK (v3.0.0 or higher)  
- Dart (compatible with Flutter version)  
- IDE (e.g., VS Code, Android Studio)

### Steps

1. **Clone the Repository**
   ```bash
   git clone https://github.com/Sokmeak/DICE-MobileApp.git
   cd EduFunApp

2. **Install Dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the App**

   ```bash
   flutter run
   ```

---

## 🔗 API Configuration

Update the API endpoint in the Flutter app:

Edit `lib/config/api.dart`:

```dart
const String baseUrl = "http://your-backend-ip-or-domain/api";
```

Replace `your-backend-ip-or-domain` with your deployed backend URL.

---

## ⚙️ Installation (NestJS Backend)

### Prerequisites

* Node.js (v18 or higher)
* npm or yarn
* PostgreSQL (v15 or higher)
* Redis (v7 or higher)

### Steps

1. **Clone the Backend Repository**

   ```bash
   git clone https://github.com/yourusername/edufun-backend.git
   cd edufun-backend
   ```

2. **Install Dependencies**

   ```bash
   npm install
   ```

3. **Set Up Environment Variables**
   Create a `.env` file in the root directory:

   ```
   DATABASE_HOST=localhost
   DATABASE_PORT=5432
   DATABASE_USER=yourusername
   DATABASE_PASS=yourpassword
   DATABASE_NAME=edufun
   JWT_SECRET=your_jwt_secret
   REDIS_HOST=localhost
   REDIS_PORT=6379
   ```

4. **Run the Server**

   ```bash
   npm run start:dev
   ```

---

## 🧪 Testing

### Frontend (Flutter)

Run unit and widget tests:

```bash
flutter test
```

### Backend (NestJS)

Run unit and integration tests:

```bash
npm run test
```

---

## 📈 Future Enhancements

* **AI-Powered Analytics**: Personalized learning insights using machine learning.
* **Multi-Language Support**: Expand accessibility with localization.
* **LMS Integrations**: Seamless compatibility with Google Classroom, Moodle, etc.
* **Advanced Security**: Biometric authentication and blockchain-based data integrity.

---

## 📬 Contact

For suggestions, questions, or collaboration, reach out at:
📧 **[team@edufun.dev](mailto:team@edufun.dev)**

---

## 📜 License

This project is licensed under the **MIT License**.

