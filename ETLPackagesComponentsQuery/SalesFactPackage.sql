
-- SalesFactData Component
select co.customer_id as customer_SK , ol.book_id as book_SK , co.shipping_method_id as shipping_SK ,FORMAT (co.order_date, 'yyyy-MM-dd') as date_SK , ol.price as price , sm.cost as costShipping
from cust_order as co left outer join order_line as ol
on co.order_id = ol.order_id
left outer join shipping_method as sm
on co.shipping_method_id = sm.method_id
