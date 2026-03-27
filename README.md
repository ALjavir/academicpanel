# 🎓 Campus Management System (Academic Panel)
A robust, real-time Flutter application designed to unify the academic experience. By consolidating fragmented university systems (SIMS, paper routines, emails) into a single mobile dashboard, this platform ensures students never miss a deadline, class, or payment.

---

## 🎯 Project Goal
Traditional university systems are often disconnected. This app unifies:
- **Academic Schedules:** Class, Exam, and Holiday tracking.
- **Academic Performance:** Real-time Results, CGPA tracking, and Credit progress.
- **Communication:** Departmental announcements and automated reminders.
- **Finances:** Tuition fees, installment tracking, and payment history.

---


## 📱 App Preview

### 🎥 Live Demo
<a href="https://youtu.be/KRyTtdjijj8"></a>



---

## ✨ Key Features

### 🔐 1. Secure Authentication & Profile Management
* **Firebase Auth:** Complete sign-up/sign-in flows with mandatory email verification.
* **Hybrid Storage Architecture:** User profile pictures are uploaded to **Google Drive** via a custom **Google Apps Script API**. The script returns a direct link stored in Firestore, optimizing Firebase storage quotas while maintaining high availability.

### 🏠 2. Intelligent Dashboard
* **Daily Briefing:** Real-time view of the day's classes or upcoming holidays.
* **Financial Insights:** Smart tracking of active installments. Displays a "Due Amount" alert or a "Paid vs. Due" progress graph for cleared accounts.
* **Academic Tracker:** Live updates of current CGPA and course completion percentages.
* **Priority Reminders:** Automated list of assignments, vivas, and quizzes—sorted by the closest deadline.

### 📅 3. Interactive Academic Planner
* **Smart Calendar:** Tap any date to instantly view the specific class routine or exam schedule for that day.
* **Assessment Management:** Filter assessments by status (Complete/Incomplete). Includes room numbers, syllabi, and deep-links to Google Classroom materials.

### 📊 4. Results & Analytics
* **Progress Visualization:** Graphical tracking of semester-over-semester improvement.
* **Credit Monitoring:** Visual breakdown of Completed vs. Enrolled vs. Remaining credits.

### 💳 5. Smart Financial Manager
* **Installment Engine:** Smartly tracks deadlines for specific installments and flags overdue payments to prevent registration delays.

### 📢 6. Communication Hub
* **Noticeboard:** Unified feed for Department and Course-specific announcements.
* **WhatsApp Integration:** Direct-to-faculty messaging via WhatsApp API integration.

---

## 🛠 Tech Stack
- **Frontend:** Flutter (Dart)
- **State Management:** GetX (Reactive approach)
- **Backend:** Firebase (Auth, Firestore, Realtime Database)
- **Middleware:** Google Apps Script (Drive API Bridge)
- **Design:** Figma (Prototyping & UML)

---

## 📽 Design & System Overview
📄 **[View Full Project Presentation](docs/Blue_and_Pink_Modern_Mobile_Apps_Presentation.pptx)**

The documentation includes:
- **UML Diagrams:** Class and Use Case diagrams.
- **Database Schema:** Detailed Firestore structure.
- **UI Wireframes:** High-fidelity Figma concepts.

---
## 📌 Development Progress
- ✅ UI prototyping (Figma)
- ✅ Database design (UML + Firebase structure)
- ✅ Authentication & core modules
- ✅ Dashboard & academic features

---

⭐ This project is part of my final year capstone and is being developed with a focus on scalability, clean architecture, and real-world usability.


