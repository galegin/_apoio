create or alter view v_field as
select trim(r.rdb$relation_name) as relation_name
, trim(rf.rdb$field_name) as field_name
, trim(t.rdb$type_name) as type_name -- BLOB / DATE / INT64 / LONG / SHORT / TEXT / TIMESTAMP / VARYING
, coalesce(f.rdb$field_precision, f.rdb$character_length, f.rdb$field_length, 0) as data_length
, coalesce(f.rdb$field_scale,0) * -1 as data_scale
, coalesce(rf.rdb$null_flag,0) as null_flag
from rdb$fields f
inner join rdb$types t on (f.rdb$field_type = t.rdb$type and t.rdb$field_name = 'RDB$FIELD_TYPE')
inner join rdb$relation_fields rf on (f.rdb$field_name = rf.rdb$field_source)
inner join rdb$relations r on (rf.rdb$relation_name = r.rdb$relation_name)
where f.rdb$system_flag = 0
--and r.rdb$relation_name = '{ENT}'
order by r.rdb$relation_id, rf.rdb$field_position

<eoc>

create or alter procedure sq_field
returns (
    p_relation_name    varchar(100),
    p_field_name       varchar(4000)
)
as
    declare variable v_field_name  varchar(100);
    declare variable v_type_name   varchar(10);
    declare variable v_data_length integer;
    declare variable v_data_scale  integer;
    declare variable v_null_flag   integer;
begin
    for select distinct relation_name
    from v_field
    into :p_relation_name
    do
    begin
        p_field_name = '';
        for select field_name, type_name, data_length, data_scale, null_flag
        from v_field
        where relation_name = :p_relation_name
        into :v_field_name, :v_type_name, :v_data_length, :v_data_scale, :v_null_flag
        do
        begin
            if (p_field_name = '') then
                p_field_name = trim(v_field_name) || ' ';
            else
                p_field_name = p_field_name || ';' || trim(v_field_name) || ' ';
            
            -- BLOB / DATE / INT64 / LONG / SHORT / TEXT / TIMESTAMP / VARYING
            if (v_type_name in ('BLOB')) then
                p_field_name = p_field_name || 'B';
            else if (v_type_name in ('DATE','TIMESTAMP')) then
                p_field_name = p_field_name || 'D';
            else if (v_type_name in ('INT32')) then
                p_field_name = p_field_name || 'I';
            else if (v_type_name in ('SHORT','LONG','INT64')) then begin
                if (v_data_length > 0) then begin
                    p_field_name = p_field_name || 'N(' || v_data_length;
                    if (v_data_scale > 0) then
                        p_field_name = p_field_name || ',' || v_data_scale;
                    p_field_name = p_field_name || ')';
                end else
                    p_field_name = p_field_name || 'I';
            end else if (v_type_name in ('TEXT')) then
                p_field_name = p_field_name || 'C(' || v_data_length || ')';
            else if (v_type_name in ('VARYING')) then
                p_field_name = p_field_name || 'A(' || v_data_length || ')';
                
            if (v_null_flag = 1) then
                p_field_name = p_field_name || ' NN';
        end

        suspend;
    end
end

--select * from sq_field

<eoc>

create or alter view v_primary as
select trim(rc.rdb$constraint_name) as constraint_name
, trim(rc.rdb$relation_name) as relation_name
, trim(s.rdb$field_name) as field_name
from rdb$index_segments s
inner join rdb$indices i on i.rdb$index_name = s.rdb$index_name
inner join rdb$relation_constraints rc on (rc.rdb$index_name = s.rdb$index_name)
where rc.rdb$constraint_type = 'PRIMARY KEY'
--and i.rdb$relation_name = '{ENT}'
order by s.rdb$field_position

<eoc>

create or alter procedure sq_primary
returns (
    p_constraint_name  varchar(100),
    p_relation_name    varchar(100),
    p_field_name       varchar(1000)
)
as 
    declare variable v_field_name varchar(1000);
begin
    for select distinct constraint_name, relation_name
    from v_primary
    into :p_constraint_name, :p_relation_name
    do
    begin
        p_field_name = '';
        for select field_name
        from v_primary
        where constraint_name = :p_constraint_name
        into :v_field_name
        do
        begin
            if (p_field_name = '') then
                p_field_name = trim(:v_field_name);
            else
                p_field_name = p_field_name || ',' || trim(:v_field_name);
        end
        suspend;
    end
end

--select * from sq_primary

<eoc>

create or alter view v_constraint as
select rc.rdb$constraint_name as constraint_name
, trim(i2.rdb$relation_name) || '_' || trim(i.rdb$relation_name) as constraint_corr
, i.rdb$relation_name as relation_name
, s.rdb$field_name as field_name
--, i.rdb$description as description
--, rc.rdb$deferrable as is_deferrable
--, rc.rdb$initially_deferred as is_deferred
--, refc.rdb$update_rule as on_update
--, refc.rdb$delete_rule as on_delete
--, refc.rdb$match_option as match_type
, i2.rdb$relation_name as references_table
, s2.rdb$field_name as references_field
--, (s.rdb$field_position + 1) as field_position
from rdb$index_segments s
left join rdb$indices i on i.rdb$index_name = s.rdb$index_name
left join rdb$relation_constraints rc on rc.rdb$index_name = s.rdb$index_name
left join rdb$ref_constraints refc on rc.rdb$constraint_name = refc.rdb$constraint_name
left join rdb$relation_constraints rc2 on rc2.rdb$constraint_name = refc.rdb$const_name_uq
left join rdb$indices i2 on i2.rdb$index_name = rc2.rdb$index_name
left join rdb$index_segments s2 on i2.rdb$index_name = s2.rdb$index_name and s.rdb$field_position = s2.rdb$field_position
where rc.rdb$constraint_type = 'FOREIGN KEY'
order by rc.rdb$constraint_name
, s.rdb$field_position

<eoc>

create or alter procedure sq_constraint
returns (
    p_constraint_name  varchar(100),
    p_constraint_corr  varchar(100),
    p_relation_name    varchar(100),
    p_field_name       varchar(1000),
    p_references_table varchar(100),
    p_references_field varchar(1000)
)
as 
    declare variable v_field_name varchar(1000);
    declare variable v_references_field varchar(1000);
begin
    for select distinct constraint_name, constraint_corr, relation_name, references_table 
    from v_constraint
    into :p_constraint_name, :p_constraint_corr, :p_relation_name, :p_references_table
    do
    begin
        p_field_name = '';
        p_references_field = '';
        for select field_name, references_field
        from v_constraint
        where constraint_name = :p_constraint_name
        into :v_field_name, :v_references_field
        do
        begin
            if (p_field_name = '') then
                p_field_name = trim(:v_field_name);
            else
                p_field_name = p_field_name || ',' || trim(:v_field_name);
            if (p_references_field = '') then
                p_references_field = trim(:v_references_field);
            else
                p_references_field = p_references_field || ',' || trim(:v_references_field);
        end
        suspend;
    end
end

--select * from sq_constraint

<eof>

/*
alter table fcc_tpmanutusu 
add constraint fcc_tpmanut_fcc_tpmanutusu 
foreign key (tp_manutencao) 
references fcc_tpmanut (tp_manutencao);
*/

/*
select 'alter table ' || trim(p_relation_name) ||
' add constraint ' || trim(p_constraint_corr) ||
' foreign key (' || trim(p_field_name) ||
') references ' || trim(p_references_table) ||
'(' || trim(p_references_field) || ');'
from sq_constraint
order by p_constraint_corr
*/

/*
select distinct 'alter table ' || p_relation_name ||
' drop constraint ' || trim(constraint_name) || ';' 
from v_constraint
order by constraint_corr
*/