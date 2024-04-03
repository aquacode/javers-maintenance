delete from jv_commit_property where commit_fk in (select commit_pk from jv_commit where commit_date < 'date_delete_from');
delete from jv_snapshot where commit_fk in (select commit_pk from jv_commit where commit_date < 'date_delete_from');
delete from jv_commit where commit_date < 'date_delete_from';
delete from jv_global_id where owner_id_fk is not null and not exists (select 1 from jv_snapshot where global_id_fk = global_id_pk);
delete from jv_global_id where not exists (select 1 from jv_snapshot where global_id_fk = global_id_pk);
