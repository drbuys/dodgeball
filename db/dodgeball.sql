DROP TABLE matches;
DROP TABLE teams;
-- DROP TABLE match;
-- DROP TABLE team;

CREATE TABLE teams (
  id SERIAL4 primary key,
  name VARCHAR(255),
  location VARCHAR(255)
);

CREATE TABLE matches (
  id SERIAL4 primary key,
  home_id INT4 references teams(id),
  away_id INT4 references teams(id),
  homescore INT4,
  awayscore INT4,
);
