drop table if exists parent_1;
drop table if exists parent_2;
drop table if exists child_surrogate;
drop table if exists child_natural;

create table parent_1 (id int not null primary key);
create table parent_2 (id int not null primary key);

create table child_surrogate (
  id int auto_increment, 
  parent_1_id int not null references parent_1, 
  parent_2_id int not null references parent_2, 
  payload_1 int, 
  payload_2 int, 
  primary key (id), 
  unique (parent_1_id, parent_2_id)
) -- ENGINE = MyISAM
;

create table child_natural (
  parent_1_id int not null references parent_1, 
  parent_2_id int not null references parent_2, 
  payload_1 int, 
  payload_2 int, 
  primary key (parent_1_id, parent_2_id)
) -- ENGINE = MyISAM
;


insert into parent_1 (id)
with recursive t as (
  select 1 v
  union all
  select v + 1 from t where v < 10000
)
select v
from t;

insert into parent_2 (id)
with recursive t as (
  select 1 v
  union all
  select v + 1 from t where v < 100
)
select v
from t;

insert into child_surrogate (parent_1_id, parent_2_id, payload_1, payload_2)
select p1.id, p2.id, 1, 1
from parent_1 as p1, parent_2 as p2;


insert into child_natural (parent_1_id, parent_2_id, payload_1, payload_2)
select p1.id, p2.id, 1, 1
from parent_1 as p1, parent_2 as p2;