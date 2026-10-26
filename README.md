# Introduction to Database Systems — Lab 3: Foreign Keys and Simple SQL

**Alexandria National University — Faculty of Engineering (Fall 2026)**

## Student Information
| Student Name | Student ID |
| :--- | :--- |
| **A'laa Sherif Ibrahim** | `2304249` |
| **Mariam Mohamed Ali** | `2304251` |

---

## Repository Structure
```text
lab3-2304249-2304251/
├── problem1_DDL.sql              # Part I: DDL script creating the `company` database and Foreign Keys
├── problem1_DML.sql              # Part I: DML script inserting 4 records into each table
├── problem1_Answers.txt          # Part I: SQL statements, MySQL outputs/errors, and explanations for Q1.1–Q1.3
├── problem2_DDL.sql              # Part II: DDL script creating the `library` database with ON DELETE CASCADE
├── problem2_DML.sql              # Part II: DML script seeding 4 authors and 8 books
├── run_lab3.bat                  # One-click automated database & Flask launcher for Windows
├── run_lab3.sh                   # One-click automated database & Flask launcher for Linux/macOS/Git Bash
├── README.md                     # Step-by-step instructions to run the SQL scripts and Flask web application
└── website/                      # Part II: Python Flask CRUD Website (F2.1–F2.5 + Bonus Image Upload)
    ├── app.py                    # Flask server and MySQL CRUD routes
    ├── requirements.txt          # Python package dependencies
    ├── templates/
    │   └── index.html            # Frontend UI displaying AUTHOR and BOOK tables, forms, and images
    └── static/
        └── uploads/              # Directory where uploaded author photos and book covers are saved
            ├── authors/
            └── covers/
```

---

## Prerequisites
1. **MySQL Server 8.x** running locally on `localhost:3306`.
   - **Host:** `localhost`
   - **User:** `root`
   - **Password:** `RootAlaaSql2028`
   *(Note: If your local MySQL root password differs, update `"password"` inside `website/app.py` on line 15).*
2. **Python 3.8+** and `pip` installed.

---

## Quick Start (One-Click Automated Run on Windows)
Double-click `run_lab3.bat` or run it from the terminal in the repository root folder:
```cmd
run_lab3.bat
```
This script automatically executes `problem1_DDL.sql`, `problem1_DML.sql`, `problem2_DDL.sql`, and `problem2_DML.sql`, installs the Python dependencies, and launches the website at **[http://127.0.0.1:5000](http://127.0.0.1:5000)**.

---

## Step-by-Step Manual Execution Guide

### Step 1: Run Part I SQL Scripts (`company` Database)
Open a terminal in the root directory of the repository and run:

```bash
mysql -u root -p < problem1_DDL.sql
mysql -u root -p < problem1_DML.sql
```
*(When prompted for a password, enter: `RootAlaaSql2028`)*

To verify the `company` database tables and records interactively:
```bash
mysql -u root -p company
```
```sql
SELECT * FROM DEPARTMENT;
SELECT * FROM EMPLOYEE;
SELECT * FROM PROJECT;
EXIT;
```
All answers, SQL snippets, and MySQL error outputs (`ERROR 1451` and `ERROR 1452`) for **Q1.1**, **Q1.2**, and **Q1.3** are documented in `problem1_Answers.txt`.

---

### Step 2: Run Part II SQL Scripts (`library` Database)
From the root directory of the repository, build and seed the `library` database:

```bash
mysql -u root -p < problem2_DDL.sql
mysql -u root -p < problem2_DML.sql
```

To verify that the 4 seed authors and 8 seed books were inserted:
```bash
mysql -u root -p library -e "SELECT * FROM AUTHOR; SELECT * FROM BOOK;"
```

---

### Step 3: Launch the Python Flask Website (`website/`)
1. Navigate into the `website/` folder:
   ```bash
   cd website
   ```
2. *(Optional)* Create and activate a Python virtual environment:
   ```bash
   python -m venv venv
   # On Windows CMD:
   venv\Scripts\activate.bat
   # On Windows PowerShell:
   .\venv\Scripts\Activate
   # On macOS/Linux/Git Bash:
   source venv/bin/activate
   ```
3. Install the required Python packages:
   ```bash
   pip install -r requirements.txt
   ```
4. Run the Flask server:
   ```bash
   python app.py
   ```
5. Open your browser and visit:
   **[http://127.0.0.1:5000](http://127.0.0.1:5000)**

---

## Implemented Website Features (Part II Rubric)
- **F2.1 — Display Tables:** Displays the `AUTHOR` table (`author_id`, `name`, `country`, `photo_path`) and the `BOOK` table (`book_id`, `title`, `price`, `author_id`, `cover_path`) using simple `SELECT` queries without `JOIN`, `GROUP BY`, or `HAVING`.
- **F2.2 — Add Book & Add Author:** Dedicated forms to insert new rows into `AUTHOR` and `BOOK` using parameterized `INSERT INTO` statements. Attempting to insert a book with a non-existent `author_id` displays the MySQL foreign key error message cleanly on the page.
- **F2.3 — Edit Book & Edit Author:** Clicking **Edit** on any row populates the update form and executes an `UPDATE ... WHERE` statement for that primary key.
- **F2.4 — Remove a Book:** Clicking **Remove** on a book executes `DELETE FROM BOOK WHERE book_id = %s`.
- **F2.5 — Remove an Author (`ON DELETE CASCADE`):** Clicking **Remove** on an author executes `DELETE FROM AUTHOR WHERE author_id = %s`, which automatically deletes all books belonging to that author via the foreign key's `ON DELETE CASCADE` constraint.
- **Bonus — Book Covers & Author Photos:** Supports uploading image files when adding or editing both books and authors. Uploaded files are saved under `website/static/uploads/covers/` and `website/static/uploads/authors/` and rendered directly in the tables.
