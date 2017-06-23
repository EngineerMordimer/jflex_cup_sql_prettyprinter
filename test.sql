select a1.a ,
  a1.b ,a1.c , a1.d , a1.e , a1.f , ( select 1 a , 2b from dual ) from a a1 LEFT JOIN b b1 on b1.a
                                                                                            =a1.a RIGHT JOIN c c1 on c1.a = b1.a UNION select null a2 , null b2 , null c2 from dual
where 1=1 and 2=2 or 3=3 ;
