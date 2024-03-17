# Task Hub - Task Management Application

Task Hub is a comprehensive Flutter application designed to facilitate efficient management of daily tasks. This README provides an extensive overview of the application's features, code structure, usage instructions, and customization options.

## Features

### Task Management

Task Hub offers robust functionalities for managing tasks effectively:

- **Create Tasks**: Users can easily create new tasks with titles, descriptions, schedules, priorities, and optional due dates.
- **Update Tasks**: Existing tasks can be edited to modify their details such as title, description, schedule, priority, and due date.
- **Delete Tasks**: Users have the option to remove tasks they no longer need from the task list.
- **Mark Completion**: Tasks can be marked as completed, providing users with a sense of accomplishment and progress tracking.
- **View Tasks**: The application provides a comprehensive view of all tasks, making it easy for users to stay organized and on top of their responsibilities.

### Database Integration

Task Hub integrates with SQLite database for seamless storage and retrieval of tasks. This ensures that users can access their tasks even when offline, offering reliability and flexibility.

## Code Structure

Task Hub follows a structured code organization for clarity and maintainability:

- **Model**: The `Task` class defines the structure of a task, encapsulating its attributes and behaviors.
- **Controller**: The `TaskController` class manages tasks and interacts with the database. It handles operations such as insertion, retrieval, updating, and deletion of tasks.
- **Screens**: Different screens of the application are encapsulated in separate Dart files. The primary screen, `DailyTasksPage`, serves as the main interface for task management.
- **Database Helper**: The `DBHelper` class provides utilities for initializing and interacting with the SQLite database, ensuring seamless data management.

## Getting Started

To use Task Hub and leverage its powerful features, follow these steps:

1. **Clone Repository**: Clone the Task Hub repository to your local machine using Git.

   ```bash
   git clone <repository-url>
   ```

2. **Install Dependencies**: Navigate to the project directory and install dependencies using Flutter's package manager.

   ```bash
   cd task_hub
   flutter pub get
   ```

3. **Run the Application**: Launch the application on your preferred device (emulator or physical device) using Flutter CLI.

   ```bash
   flutter run
   ```

4. **Explore Functionality**: Upon launching the application, navigate through the screens to explore various functionalities such as creating, updating, deleting, and marking tasks as completed.

## Dependencies

Task Hub relies on the following dependencies to deliver its functionalities:

- **Get**: A state management and navigation library for Flutter.
- **SQFLite**: A SQLite plugin for Flutter, facilitating local database management.
- **Path**: Provides utilities for handling file paths.
- **UUID**: Generates universally unique identifiers (UUIDs) for tasks.

## Additional Notes

- **Customization**: Task Hub's codebase is highly customizable. You can tailor the user interface, add new features, or integrate additional functionalities as per your requirements.
- **Firebase Integration**: While Task Hub does not include Firebase integration in the provided code snippet, you can refer to Firebase documentation for seamless integration of services such as authentication, cloud storage, and real-time database.

## Support and Contributions

For any inquiries, issues, or feature requests, feel free to open an issue on the Task Hub GitHub repository. Contributions via pull requests are welcomed and appreciated. Your feedback and contributions help enhance the application for the entire community.

Thank you for choosing Task Hub! Simplify your task management and boost productivity with Task Hub today!
Ajay Kumar 
