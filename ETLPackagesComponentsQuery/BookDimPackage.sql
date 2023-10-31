
-- BookDimData Component
select b.book_id as book_BK,b.title,bl.language_name as language,p.publisher_name as publisher,a.author_name as author
from book as b left outer join book_language as bl
on b.language_id = bl.language_id
left outer join publisher as p
on b.publisher_id = p.publisher_id
left outer join book_author as ba
on b.book_id = ba.book_id
left outer join author as a
on ba.author_id = a.author_id