DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_likes;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABlE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  subject_question INTEGER NOT NULL,
  parent_reply INTEGER NULL,
  reply_author_id INTEGER NOT NULL,
  body VARCHAR(255) NOT NULL,

  FOREIGN KEY (subject_question) REFERENCES questions(id),
  FOREIGN KEY (parent_reply) REFERENCES replies(id),
  FOREIGN KEY (reply_author_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Brian', 'Gersonian'),
  ('Kevin', 'JKBradley'),
  ('John', 'Doe'),
  ('Jane', 'Smith'),
  ('Brad', 'Jackman'),
  ('Dillon', 'Draper'),
  ('Carson', 'Judge'),
  ('Robert', 'Rodriguez');

INSERT INTO
  questions (title, body, author_id)
VALUES
  ('Ruby', 'What is a method?', 1),
  ('SQL', 'What is a query?', 2),
  ('Dogs', 'Do they know their names?', 4),
  ('Cats', 'Do cats eat Oreos?', 1),
  ('App Academy', 'Will we all be millionaires?', 8);

INSERT INTO
  question_follows (user_id, question_id)
VALUES
  (1, 2),
  (4, 1),
  (4, 2),
  (7, 4),
  (5, 3);

INSERT INTO
  replies (subject_question, parent_reply, reply_author_id, body)
VALUES
  (4, 0, 2, 'Cats love Oreos!'),
  (3, 0, 1, 'Dogs know their name and your name'),
  (3, 2, 7, 'Actually Dogs do not know your name'),
  (5, 0, 2, 'Hell Yes!'),
  (3, 2, 1, 'Dogs are dumb');

INSERT INTO
  question_likes (user_id, question_id)
VALUES
  (1, 3),
  (2, 1),
  (1, 5),
  (4, 4),
  (5, 3);
