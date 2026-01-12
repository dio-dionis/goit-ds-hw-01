--- отримати всі завдання для користувача з ID 1
SELECT *
FROM tasks
WHERE user_id = 1;

--- вибрати всі завдання зі статусом 'new'
SELECT *
FROM tasks
WHERE status_id = (
    SELECT id FROM status WHERE name = 'new'
);

--- оновити статус завдання з ID 1 на 'in progress'
UPDATE tasks
SET status_id = (
    SELECT id FROM status WHERE name = 'in progress'
)
WHERE id = 1;

--- користувачі, які не мають жодного завдання
SELECT *
FROM users
WHERE id NOT IN (
    SELECT user_id FROM tasks WHERE user_id IS NOT NULL
);

--- додати нове завдання з статусом 'new' для користувача з ID 1
INSERT INTO tasks (title, description, status_id, user_id)
VALUES (
    'New task',
    'Task description',
    (SELECT id FROM status WHERE name = 'new'),
    1
);

--- отримати всі завдання, які не мають статус 'completed'
SELECT *
FROM tasks
WHERE status_id != (
    SELECT id FROM status WHERE name = 'completed'
);

--- видалити завдання з ID 1
DELETE FROM tasks
WHERE id = 1;

--- отримати всіх користувачів з електронною поштою 'example.com'
SELECT *
FROM users
WHERE email LIKE '%@example.com';

--- оновити повне ім'я користувача з ID 1 на 'New Name'
UPDATE users
SET fullname = 'New Name'
WHERE id = 1;

--- підрахувати кількість завдань для кожного статусу
SELECT s.name, COUNT(t.id) AS total
FROM status s
LEFT JOIN tasks t ON t.status_id = s.id
GROUP BY s.name;

--- отримати всі завдання користувачів з доменом електронної пошти 'example.com'
SELECT t.*
FROM tasks t
JOIN users u ON t.user_id = u.id
WHERE u.email LIKE '%@example.com';

--- отримати всі завдання без опису
SELECT *
FROM tasks
WHERE description IS NULL;

--- отримати ім'я користувача та назву завдання для всіх завдань зі статусом 'in progress'
SELECT u.fullname, t.title
FROM users u
INNER JOIN tasks t ON u.id = t.user_id
INNER JOIN status s ON t.status_id = s.id
WHERE s.name = 'in progress';

--- підрахувати кількість завдань для кожного користувача
SELECT u.fullname, COUNT(t.id) AS task_count
FROM users u
LEFT JOIN tasks t ON u.id = t.user_id
GROUP BY u.id;







