CREATE PROCEDURE orders_data(productid INT, quantity INT)
LANGUAGE plpgsql
AS $$
DECLARE 
totalcost decimal(10,2);
currentQty INT;
product RECORD;
orderID INT;
BEGIN
   IF productid NOT IN (SELECT product_id FROM products WHERE product_id = productid) THEN
       RAISE EXCEPTION 'Product Not Avaialable In Store';
	   
   ELSIF quantity >  (SELECT stock FROM products WHERE product_id = productid) THEN
       RAISE EXCEPTION 'Stock not available';
   END IF;
	   
   FOR product IN ( SELECT product_id, product_name, price, stock FROM products WHERE product_id = productid)
   LOOP
   totalcost := product.price * quantity;
   currentQty := product.stock - quantity;
   
   INSERT INTO orders(totalcost) VALUES (totalcost) RETURNING order_id into orderID ;
   
   UPDATE products
   SET stock = currentQty
   WHERE product_id = productid;
   
   
   INSERT INTO orderdetails(order_id, product_id, quantity)
   VALUES ( orderID ,product.product_id, quantity);
   END LOOP;
END $$;

CALL orders_data(1,500)