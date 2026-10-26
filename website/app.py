import os
import uuid
from flask import Flask, render_template, request, redirect, url_for, flash
from werkzeug.utils import secure_filename
import mysql.connector

app = Flask(__name__)
app.secret_key = "anu_lab3_secret_key"

# MySQL Configuration (User Credentials)
DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "RootAlaaSql2028",
    "database": "library"
}

UPLOAD_COVERS = os.path.join(app.root_path, "static", "uploads", "covers")
UPLOAD_AUTHORS = os.path.join(app.root_path, "static", "uploads", "authors")
os.makedirs(UPLOAD_COVERS, exist_ok=True)
os.makedirs(UPLOAD_AUTHORS, exist_ok=True)


def get_db_connection():
    return mysql.connector.connect(**DB_CONFIG)


def save_uploaded_image(file_storage, subfolder):
    if file_storage and file_storage.filename:
        ext = os.path.splitext(secure_filename(file_storage.filename))[1].lower()
        filename = f"{uuid.uuid4().hex}{ext}"
        rel_path = f"/static/uploads/{subfolder}/{filename}"
        abs_path = os.path.join(app.root_path, "static", "uploads", subfolder, filename)
        file_storage.save(abs_path)
        return rel_path
    return None


# F2.1: Display Books and Authors tables using simple SELECT queries
@app.route("/")
def index():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT author_id, name, country, photo_path FROM AUTHOR ORDER BY author_id ASC")
    authors = cursor.fetchall()
    cursor.execute("SELECT book_id, title, price, author_id, cover_path FROM BOOK ORDER BY book_id ASC")
    books = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template("index.html", authors=authors, books=books)


# F2.2: Add an Author
@app.route("/authors/add", methods=["POST"])
def add_author():
    author_id = request.form["author_id"]
    name = request.form["name"]
    country = request.form["country"]
    photo_path = save_uploaded_image(request.files.get("photo_file"), "authors")

    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(
            "INSERT INTO AUTHOR (author_id, name, country, photo_path) VALUES (%s, %s, %s, %s)",
            (author_id, name, country, photo_path)
        )
        conn.commit()
        flash(f"Author #{author_id} added successfully.", "success")
    except mysql.connector.Error as err:
        flash(f"MySQL Error: {err}", "danger")
    finally:
        cursor.close()
        conn.close()
    return redirect(url_for("index"))


# F2.3: Edit an Author
@app.route("/authors/edit", methods=["POST"])
def edit_author():
    author_id = request.form["author_id"]
    name = request.form["name"]
    country = request.form["country"]
    photo_path = save_uploaded_image(request.files.get("photo_file"), "authors")

    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        if photo_path:
            cursor.execute(
                "UPDATE AUTHOR SET name = %s, country = %s, photo_path = %s WHERE author_id = %s",
                (name, country, photo_path, author_id)
            )
        else:
            cursor.execute(
                "UPDATE AUTHOR SET name = %s, country = %s WHERE author_id = %s",
                (name, country, author_id)
            )
        conn.commit()
        flash(f"Author #{author_id} updated successfully.", "success")
    except mysql.connector.Error as err:
        flash(f"MySQL Error: {err}", "danger")
    finally:
        cursor.close()
        conn.close()
    return redirect(url_for("index"))


# F2.5: Remove an Author (ON DELETE CASCADE automatically deletes their books)
@app.route("/authors/delete/<int:author_id>", methods=["POST"])
def delete_author(author_id):
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("DELETE FROM AUTHOR WHERE author_id = %s", (author_id,))
        conn.commit()
        flash(f"Author #{author_id} and all their books were removed (ON DELETE CASCADE).", "warning")
    except mysql.connector.Error as err:
        flash(f"MySQL Error: {err}", "danger")
    finally:
        cursor.close()
        conn.close()
    return redirect(url_for("index"))


# F2.2: Add a Book
@app.route("/books/add", methods=["POST"])
def add_book():
    book_id = request.form["book_id"]
    title = request.form["title"]
    price = request.form["price"]
    author_id = request.form["author_id"]
    cover_path = save_uploaded_image(request.files.get("cover_file"), "covers")

    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(
            "INSERT INTO BOOK (book_id, title, price, author_id, cover_path) VALUES (%s, %s, %s, %s, %s)",
            (book_id, title, price, author_id, cover_path)
        )
        conn.commit()
        flash(f"Book #{book_id} added successfully.", "success")
    except mysql.connector.Error as err:
        flash(f"MySQL Error: {err}", "danger")
    finally:
        cursor.close()
        conn.close()
    return redirect(url_for("index"))


# F2.3: Edit a Book
@app.route("/books/edit", methods=["POST"])
def edit_book():
    book_id = request.form["book_id"]
    title = request.form["title"]
    price = request.form["price"]
    author_id = request.form["author_id"]
    cover_path = save_uploaded_image(request.files.get("cover_file"), "covers")

    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        if cover_path:
            cursor.execute(
                "UPDATE BOOK SET title = %s, price = %s, author_id = %s, cover_path = %s WHERE book_id = %s",
                (title, price, author_id, cover_path, book_id)
            )
        else:
            cursor.execute(
                "UPDATE BOOK SET title = %s, price = %s, author_id = %s WHERE book_id = %s",
                (title, price, author_id, book_id)
            )
        conn.commit()
        flash(f"Book #{book_id} updated successfully.", "success")
    except mysql.connector.Error as err:
        flash(f"MySQL Error: {err}", "danger")
    finally:
        cursor.close()
        conn.close()
    return redirect(url_for("index"))


# F2.4: Remove a Book
@app.route("/books/delete/<int:book_id>", methods=["POST"])
def delete_book(book_id):
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("DELETE FROM BOOK WHERE book_id = %s", (book_id,))
        conn.commit()
        flash(f"Book #{book_id} removed successfully.", "info")
    except mysql.connector.Error as err:
        flash(f"MySQL Error: {err}", "danger")
    finally:
        cursor.close()
        conn.close()
    return redirect(url_for("index"))


if __name__ == "__main__":
    app.run(debug=True, port=5000)
