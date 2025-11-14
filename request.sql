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
    id,
    first_name,
    last_name
from
    Employee
where
    id_team = null;

-- 2: Afficher l’id, first_name, last_name des employés qui n’ont jamais pris de congé de 
-- leur vie.
select
    e.id,
    e.first_name,
    e.last_name
from
    Employee e
where
    not exists(
        select
            *
        from
            Leave l
        where
            l.id_employee = e.id
    );

-- 3: Afficher les congés de tel sorte qu’on voie l’id du congé, le début du congé, la fin du
-- congé, le nom & prénom de l’employé qui prend congé et le nom de son équipe.
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

-- 4: Affichez par le nombre d’employés par contract_type, vous devez afficher le type de
-- contrat, et le nombre d’employés associés.
select
    e.contract_type,
    count(*) as employee_total
from
    Employee e
group by
    contract_type;