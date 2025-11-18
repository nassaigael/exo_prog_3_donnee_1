create table Team(
    id serial primary key,
    name varchar(50) not null
);

create table Employee(
    id serial primary key,
    first_name varchar(100) not null,
    last_name varchar(100) not null,
    contract_type varchar(50) not null,
    salary int not null,
    id_team int not null references Team(id)
);

create table Leave(
    id serial primary key,
    "start_date" date not null,
    end_date date not null,
    id_employee int not null references Employee(id)
);

insert into
    Team
values
    (default, 'Crokodil'),
    (default, 'Clan_Modeste'),
    (default, 'Squad_Six');

insert into
    Employee
values
    (
        default,
        'Ramahandrisoa',
        'Gael',
        'full_time',
        1000000,
        1
    ),
    (
        default,
        'Ravelojaona',
        'Christain',
        'long_terme',
        200000,
        2
    ),
    (
        default,
        'Ratiandraibe',
        'David',
        'court_terme',
        30000,
        3
    );


insert into
    Leave
values
    (default, '2025-01-31', '2025-05-31', 2),
    (default, '2025-04-02', '2025-06-30', 3);

select
    id,
    first_name,
    last_name
from
    Employee
where
    id_team is null;


select
    e.id,
    e.first_name,
    e.last_name
from
    Employee e
where
    not exists(
        select
            l.id,
            l.start_date,
            l.end_date,
            l.id_employee
        from
            Leave l
        where
            l.id_employee = e.id
    );


select
    l.id,
    l.start_date,
    l.end_date,
    e.first_name,
    e.last_name,
    t.name
from
    Employee e
    inner join Leave l on e.id = l.id_employee
    inner join Team t on t.id = e.id_team;


select
    e.contract_type,
    count(contract_type) as employee_total
from
    Employee e
group by
    contract_type;


select
    count(distinct l.id_employee) as employee_total
from
    Leave l
where
    CURRENT_DATE between start_date
    and end_date;


select
    e.id,
    e.first_name,
    e.last_name,
    t.name
from
    Employee e
    inner join Leave l on e.id = l.id_employee
    inner join Team t on t.id = e.id_team
where
    CURRENT_DATE between start_date
    and end_date
group by
    e.id,
    e.first_name,
    e.last_name,
    t.name;