-- optimize search and score
-- create index on table names on first letter of name and score
CREATE INDEX idx_name_first_score ON names(name(1), score);
