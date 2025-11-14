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
    id_team int references Team(id)
);

create table Leave(
    id serial primary key,
    "start_date" date not null,
    end_date date not null,
    id_employee int references Employee(id)
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

-- 1: Afficher l’id, first_name, last_name des employés qui n’ont pas d’équipe.
select
    (id, first_name, last_name)
from
    Employee
where
    id_team = null;
