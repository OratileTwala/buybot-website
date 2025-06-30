# buybot-website
BuyBot Website Frontend &amp; PHP Backend with JSON Data
# BuyBot Website

This repository contains the frontend (HTML, CSS, JavaScript) and a basic PHP backend for the BuyBot website. The PHP backend is designed to interact with flat JSON files for data persistence, simulating a simple database. A MySQL schema is also provided as a more robust database alternative.

## Table of Contents

- [Features](#features)
- [Project Structure](#project-structure)
- [Setup Instructions](#setup-instructions)
  - [Prerequisites](#prerequisites)
  - [Frontend Setup](#frontend-setup)
  - [Backend (PHP & JSON) Setup](#backend-php--json-setup)
  - [Alternative: MySQL Database Setup](#alternative-mysql-database-setup)
- [Usage](#usage)
- [Important Notes](#important-notes)

## Features

- **User Authentication (Simulated Signup):** Users can create new accounts.
- **Homepage:** Displays "Top Sellers" products.
- **Merchant Join:** Allows users to "join" merchant training programs.
- **Shop Page:** Displays a list of products with search functionality.
- **Admin Page:** Displays a specific product detail and a list of registered users.
- **Navigation:** Simple navigation menu.
- **Data Persistence:** Handled by PHP scripts writing to/reading from JSON files.

## Project Structure

buybot-website/├── api/                  # PHP backend scripts│   ├── create_user.php│   ├── join_program.php│   ├── read_all_users.php│   ├── read_products.php│   └── read_training_programs.php├── data/                 # JSON data files (simulated database)│   ├── products.json│   ├── training_programs.json│   └── users.json├── html/                 # All HTML files (with inline CSS/JS)│   ├── admin.html│   ├── homepage.html│   ├── index.html        # Signup page│   ├── merchantjoin.html│   └── merchanttrain.html├── mysql_schema.sql      # SQL schema for MySQL database (alternative)└── README.md             # This file
## Setup Instructions

### Prerequisites

To run this website, you will need:

1.  **A Web Server:** Apache, Nginx, or similar.
2.  **PHP:** Version 7.4 or higher installed on your web server.
3.  **Optional (for MySQL):** A MySQL server instance.

### Frontend Setup

1.  **Clone the repository:**
    ```bash
    git clone <your-repo-url> buybot-website
    cd buybot-website
    ```
2.  **Place `html/` folder:** Copy the entire `html/` folder to your web server's document root (e.g., `htdocs` for Apache, `www` for Nginx). You might want to rename it or place its contents directly into your root for easier access (e.g., `http://localhost/index.html`).

### Backend (PHP & JSON) Setup

1.  **Place `api/` and `data/` folders:** Copy both the `api/` and `data/` folders into the same directory as your `html/` folder (or your web server's document root). Ensure the `api/` directory is directly accessible relative to your HTML files (e.g., if HTML is at `http://localhost/`, `api/` should be at `http://localhost/api/`).
2.  **File Permissions:** Ensure that your web server has **write permissions** to the `data/` directory and all `.json` files within it. This is crucial for the `create_user.php` and `join_program.php` scripts to function correctly.
    * On Linux/macOS, you might use: `sudo chmod -R 777 data/` (use with caution in production; `775` or `770` with proper user/group ownership is safer).
    * On Windows, ensure the IIS/Apache user has write access.
3.  **JSON Data:** The `data/` folder already contains initial data for `products.json`, `training_programs.json`, and `users.json`. These will be used by the PHP scripts.

### Alternative: MySQL Database Setup

If you wish to use MySQL instead of flat JSON files (recommended for production):

1.  **Create Database:** Create a new database in your MySQL server (e.g., `buybot_db`).
2.  **Run SQL Schema:** Execute the SQL commands from `mysql_schema.sql` in your MySQL client to create the necessary tables and populate them with initial data.
3.  **Modify PHP:**
    * **Create `api/db_connect.php`:** Add the database connection details (replace placeholders with your actual MySQL credentials).
        ```php
        <?php
        // api/db_connect.php
        define('DB_SERVER', 'localhost');
        define('DB_USERNAME', 'your_mysql_user');
        define('DB_PASSWORD', 'your_mysql_password');
        define('DB_NAME', 'buybot_db');

        $conn = new mysqli(DB_SERVER, DB_USERNAME, DB_PASSWORD, DB_NAME);

        if ($conn->connect_error) {
            die("Connection failed: " . $conn->connect_error);
        }
        $conn->set_charset("utf8mb4");
        ?>
        ```
    * You would then need to rewrite each `api/*.php` script to use `mysqli` (or PDO) for database operations instead of `file_get_contents` and `json_encode`. This requires significant changes to the PHP logic beyond simply swapping files. The provided PHP files are currently configured for JSON file interaction.

## Usage

1.  **Start your web server.**
2.  **Open the website:** Navigate to `http://localhost/html/index.html` (or your specific path) in your web browser.
3.  **Explore:**
    * Use the "Sign up" form to create a new (simulated) account.
    * Navigate through the pages using the hamburger menu (top left) or the action buttons.
    * Observe how data is loaded from the JSON files.
    * When you "Sign up" or "JOIN" a program, the PHP script will attempt to modify the JSON file on the server. If permissions are correct, these changes will persist.

## Important Notes

* **Security (JSON Backend):** Using flat JSON files for a backend is **NOT recommended for production applications** due to severe limitations in concurrency, data integrity, and security. It's suitable only for very small, single-user, or read-only applications, or as a learning exercise.
* **Permissions:** Incorrect file permissions are a common issue when setting up PHP to write to files. If data isn't persisting, check your web server's write access to the `data/` folder.
* **Error Handling:** The PHP scripts have basic error handling. For production, more robust error logging and user-friendly error messages would be necessary.
* **Authentication:** The current system does not implement a secure user login/session management. The "user ID" is simply persisted via `localStorage` in the browser for demonstration. A proper authentication system is essential for any real-world application.
* **Scalability:** For any significant user base or data volume, migrating to a proper relational database (like MySQL, PostgreSQL) or a NoSQL database (like MongoDB, Firebase Firestore) is highly recommended.
