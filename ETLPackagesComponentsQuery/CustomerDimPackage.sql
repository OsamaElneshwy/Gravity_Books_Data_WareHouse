
-- CustomerDimData Component
select c.customer_id as customer_BK,CONCAT(c.first_name,' ',c.last_name)as customer_name,city,country_name as country
from customer as c left outer join customer_address as ca
on c.customer_id = ca.customer_id
left outer join address as a
on ca.address_id = a.address_id
left outer join country as co
on a.country_id = co.country_id







