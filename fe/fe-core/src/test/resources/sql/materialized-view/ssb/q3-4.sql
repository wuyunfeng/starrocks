[sql]
SELECT
  c_city,
  s_city,
  d_year,
  SUM(lo_revenue) AS revenue
FROM 
  customer,
  lineorder,
  supplier,
  dates
WHERE 
  lo_custkey = c_custkey
  AND lo_suppkey = s_suppkey
  AND lo_orderdate = d_datekey
  AND (c_city='UNITED KI1'
    OR c_city='UNITED KI5')
  AND (s_city='UNITED KI1'
    OR s_city='UNITED KI5')
  AND d_yearmonth = 'Dec1997'
GROUP BY 
  c_city,
  s_city,
  d_year
ORDER BY 
  d_year ASC, 
  revenue DESC;
[result]
TOP-N (order by [[37: d_year ASC NULLS FIRST, 50: sum DESC NULLS LAST]])
    TOP-N (order by [[37: d_year ASC NULLS FIRST, 50: sum DESC NULLS LAST]])
        AGGREGATE ([GLOBAL] aggregate [{50: sum=sum(50: sum)}] group by [[4: c_city, 29: s_city, 37: d_year]] having [null]
            EXCHANGE SHUFFLE[4, 29, 37]
                AGGREGATE ([LOCAL] aggregate [{50: sum=sum(21: lo_revenue)}] group by [[4: c_city, 29: s_city, 37: d_year]] having [null]
                    SCAN (columns[63: LO_REVENUE, 70: C_CITY, 77: S_CITY, 92: d_year, 94: d_yearmonth] predicate[94: d_yearmonth = Dec1997 AND 70: C_CITY IN (UNITED KI1, UNITED KI5) AND 77: S_CITY IN (UNITED KI1, UNITED KI5)])
[end]
