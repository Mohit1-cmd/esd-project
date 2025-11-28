# 🎓 Backend Code Walkthrough: File-by-File Explanation

This guide takes you through the codebase file-by-file. This is the best way to explain the project in a viva: "I'll walk you through the flow, starting from configuration to the actual logic."

---

## 🛠️ 1. Configuration Files (The Setup)

### `pom.xml`
**What it is:** The "Shopping List" for the project.
**What it does:**
- It tells Maven (our build tool) what libraries to download.
- **Key Dependencies:**
    - `spring-boot-starter-web`: Allows us to build REST APIs.
    - `spring-boot-starter-data-jpa`: Lets us talk to the database easily.
    - `spring-boot-starter-oauth2-client`: Handles "Login with Google".
    - `mysql-connector-j`: The driver to connect to MySQL.

### `src/main/resources/application.properties`
**What it is:** The "Settings File".
**What it does:**
- **Database Config**: Sets the URL (`jdbc:mysql://...`), username, and password for MySQL.
- **OAuth Config**: Stores your Google Client ID and Secret (loaded from environment variables for security).
- **JPA Config**: `spring.jpa.hibernate.ddl-auto=none` tells Hibernate "Don't delete my data! I'll manage the tables myself."

---

## 🚀 2. The Entry Point

### `EndProjectApplication.java`
**Location:** `com.mohit.end_project`
**What it is:** The "Start Button".
**What it does:**
- Contains the `main` method.
- `@SpringBootApplication`: This single annotation triggers the entire Spring Boot auto-configuration magic. It scans your project for components and starts the Tomcat server on port 8080.

---

## 🔐 3. Security Configuration (The Bouncer)

### `config/SecurityConfig.java`
**What it is:** The "Security Guard".
**What it does:**
- **`securityFilterChain` method**: Defines the security rules.
    - `.csrf(csrf -> csrf.disable())`: We disable CSRF because we are building a stateless API, not a server-side rendered website.
    - `.authorizeHttpRequests(...)`:
        - Allows public access to `/` and `/login`.
        - (Currently allows `/api/**` for demo purposes, but normally would lock this down).
    - `.oauth2Login(...)`: Activates the "Login with Google" flow.
    - **Custom Resolver**: We added code here to send `prompt=select_account` to Google, forcing the account chooser screen every time.

### `config/CorsConfig.java`
**What it is:** The "Bridge".
**What it does:**
- **CORS (Cross-Origin Resource Sharing)**: By default, browsers block the Frontend (port 5173) from calling the Backend (port 8080).
- This file explicitly says: "Allow requests from `http://localhost:5173`".

### `security/OAuth2LoginSuccessHandler.java`
**What it is:** The "Greeter".
**What it does:**
- This runs *after* Google says "Login Successful".
- It gets the user's email from Google.
- It checks our database: "Do we know this person?"
- If yes, it redirects them to the Frontend Dashboard.
- If no, it could create a new user or show an error.

---

## 📦 4. Entities (The Data Structure)

**Location:** `com.mohit.end_project.entity`
**What they are:** Java classes that look exactly like your Database Tables.

### `Student.java`
- Maps to the `student` table.
- Fields: `studentId`, `firstName`, `email`, `cgpa`, etc.
- **Annotations**:
    - `@Entity`: "This is a database table."
    - `@Id`: "This is the Primary Key."
    - `@OneToMany`: "One student has many courses."

### `Course.java`
- Maps to the `course` table.
- Fields: `courseId`, `courseCode`, `name`, `credits`.

### `Specialization.java`
- Maps to the `specialization` table.
- Fields: `specializationId`, `name`, `requiredCredits` (usually 20).

---

## 🗄️ 5. Repositories (The Data Fetchers)

**Location:** `com.mohit.end_project.repository`
**What they are:** Interfaces that talk to the database.

### `StudentRepository.java`, `CourseRepository.java`, etc.
- **What they do:** They extend `JpaRepository`.
- **The Magic:** You don't write SQL here! Spring automatically creates methods for you:
    - `findAll()`
    - `findById()`
    - `save()`
    - `delete()`

---

## 🧠 6. Services (The Business Logic)

**Location:** `com.mohit.end_project.service`
**What they are:** The "Brain" of the application. This is where the real work happens.

### `StudentService.java`
- **What it does:** Simple logic.
- `getAllStudents()`: Calls `studentRepository.findAll()` and returns the list.
- `addStudent()`: Validates input and calls `studentRepository.save()`.

### `SpecializationService.java` (CRITICAL FILE)
- **What it does:** Calculates if a student has earned a specialization.
- **The Logic (`getStudentSpecializations` method):**
    1.  It takes a `studentId`.
    2.  It gets all courses that student has passed (`studentCourseRepository`).
    3.  It gets all available specializations.
    4.  **The Loop**: It goes through every specialization.
    5.  **The Check**: It sums up the credits of the student's courses that belong to that specialization.
    6.  **The Threshold**: `if (totalCredits >= 20)` -> The student earns the specialization!
    7.  It returns a list of `StudentSpecializationDTO` (Data Transfer Object) to show on the frontend.

---

## 🗣️ 7. Controllers (The API Endpoints)

**Location:** `com.mohit.end_project.controller`
**What they are:** The "Receptionists". They handle HTTP requests from the Frontend.

### `StudentController.java`
- `@RestController`: "I speak JSON."
- `@GetMapping("/api/students")`: When the frontend asks for students, this method runs.
- It calls `studentService.getAllStudents()` and sends the result back.

### `AdminController.java`
- **What it does:** Handles the Reports page data.
- `@GetMapping("/api/admin/students/specializations")`:
    - This is the endpoint for the "Domain Specialization" page.
    - It calls `specializationService.getAllStudentSpecializations()`.
    - It sends the calculated list of students and their earned specializations to the frontend.

---

## � Summary for Viva

If asked **"How does the Specialization feature work?"**, you can say:

1.  "The **Frontend** calls the `AdminController`."
2.  "The **Controller** asks the `SpecializationService` for data."
3.  "The **Service** gets the student's courses from the `Repository`."
4.  "The **Service** runs a logic loop: it sums up credits for each specialization."
5.  "If the sum is **20 or more**, it marks the student as having that specialization."
6.  "The result is sent back to the Frontend to display."
