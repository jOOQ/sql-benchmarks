# Using surrogate keys in relationship tables on clustered index tables

Clustered index tables are useful for fast data retrieval by primary key lookups, which can be done in `O(log(N))` with the clustered index instead of `O(log(N))` + `O(1)` with a heap table.

The price we're paying for this is slower data retrieval by secondary key lookups, which is now `O(log(N))` (index lookup) + `O(M * log(N))` (data lookup) instead of, still `O(log(N))` + `O(M)`.

In the above example:

- N = Size of the table
- M = Number of the searched rows

The price can be very high when a lot of data is searched in a clustered index. Here's how different RDBMS default to using clustered vs non-clustered indexes:

- MySQL's InnoDB only offers clustered indexes.
- MySQL's MyISAM only offers heap tables.
- SQL Server offers both and defaults to clustered indexes
- Oracle offers both and defaults to heap tables
- PostgreSQL offers both and defaults to heap tables

The full article can be read here: https://blog.jooq.org/2019/03/26/the-cost-of-useless-surrogate-keys-in-relationship-tables/