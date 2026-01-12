import sqlite3
from faker import Faker
import random

fake = Faker()

DB_NAME = "tasks.db"

def seed_database():
    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()

    # Додаємо статуси
    statuses = ['new', 'in progress', 'completed']
    cursor.executemany(
        "INSERT OR IGNORE INTO status (name) VALUES (?)",
        [(status,) for status in statuses]
    )

    # Додаємо користувачів
    users = []
    for _ in range(10):
        users.append((
            fake.name(),
            fake.unique.email()
        ))

    cursor.executemany(
        "INSERT INTO users (fullname, email) VALUES (?, ?)",
        users
    )

    # Отримуємо id користувачів і статусів
    cursor.execute("SELECT id FROM users")
    user_ids = [row[0] for row in cursor.fetchall()]

    cursor.execute("SELECT id FROM status")
    status_ids = [row[0] for row in cursor.fetchall()]

    # Додаємо завдання
    tasks = []
    for _ in range(20):
        tasks.append((
            fake.sentence(nb_words=4),
            fake.text() if random.choice([True, False]) else None,
            random.choice(status_ids),
            random.choice(user_ids)
        ))

    cursor.executemany(
        """
        INSERT INTO tasks (title, description, status_id, user_id)
        VALUES (?, ?, ?, ?)
        """,
        tasks
    )

    conn.commit()
    conn.close()


if __name__ == "__main__":
    seed_database()
