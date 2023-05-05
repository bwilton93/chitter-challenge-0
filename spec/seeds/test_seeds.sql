DROP TABLE IF EXISTS peeps, users;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  display_name text,
  username text,
  password text,
  email text
);

CREATE TABLE peeps (
  id SERIAL PRIMARY KEY,
  content text,
  date date,
  time time,
  author_id int,
    constraint fk_author foreign key(author_id)
    references users(id)
    on delete cascade
);

TRUNCATE TABLE peeps, users RESTART IDENTITY;

INSERT INTO users (display_name, username, password, email) VALUES
('User 1', 'user1', 'fake_password', 'fake_email@email.com'),
('User 2', 'user2', 'fake_password2', 'fake_email2@email.com');

INSERT INTO peeps (content, date, time, author_id) VALUES
('This is a peep', '2023-01-03', '09:11', '1'),
('This is another peep', '2023-05-03', '12:11', '2'),
('This is yet another peep', '2023-05-04', '17:11', '2');
