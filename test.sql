select * from (
select a1.a ,
  a1.b ,a1.c , a1.d , a1.e , a1.f , ( select 1 a , 2b , case when 1=1 then 2 when 0=2 then 3 else 1 end from dual ) from a a1 LEFT JOIN b b1 on b1.a
                                                                                            =a1.a RIGHT JOIN c c1 on c1.a = b1.a UNION select null a2 , null b2 , null c2 from dual
where 1=1 and 2=2 or 3=3
union all select case when 1=1 then 2 when 0=2 then 3 else 1 end from dual where 1=1 and 0 between 1 and to_date(1, 'y' )
or 0=0 ) group by a order by 1
;
