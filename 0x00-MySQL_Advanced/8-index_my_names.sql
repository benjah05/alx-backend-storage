-- optimize simple search
-- create index on names and the first letter of name
CREATE INDEX idx_name_first ON names(name(1));
