-- buy buy buy
-- create a trigger that decreases quantity of items
CREATE TRIGGER purchase_trigger
AFTER INSERT ON orders
FOR EACH ROW
UPDATE items SET quantity = quantity - NEW.number WHERE name = NEW.item_name;
