-- Additive migration. No existing data or functions are removed.
-- Run once in the existing project's Supabase SQL Editor.
begin;
create or replace function public.sidequest_save_queued_log(p_date date,p_data jsonb,p_revision integer,p_queued_at timestamptz) returns jsonb
language plpgsql security definer set search_path='' as $$
declare who uuid:=auth.uid(); local_today date:=(clock_timestamp() at time zone 'Australia/Melbourne')::date; old_data jsonb; old_revision integer; saved_revision integer;
begin
 if who is null then raise sqlstate 'PT401' using message='Sign in to sync.'; end if;
 if p_date is null or p_date>=local_today or p_date<local_today-7 or p_queued_at is null or (p_queued_at at time zone 'Australia/Melbourne')::date<>p_date or p_queued_at>clock_timestamp() then raise sqlstate 'PT403' using message='This queued log is outside the seven-day late-sync window. Device copy kept.'; end if;
 if p_revision is null or p_revision<0 or p_data is null or jsonb_typeof(p_data)<>'object' or octet_length(p_data::text)>30000 then raise sqlstate 'PT400' using message='Invalid log.'; end if;
 -- Serialize late writes for this account/date, including first inserts.
 perform pg_advisory_xact_lock(hashtextextended(who::text||':'||p_date::text,0));
 select data,revision into old_data,old_revision from public.sidequest_daily_logs where user_id=who and date=p_date for update;
 if old_data is not null then
  if old_revision<>p_revision then raise sqlstate 'PT409' using message='Cloud and queued copies differ. Resolve the conflict; both copies are kept.'; end if;
  if exists(select 1 from jsonb_array_elements(coalesce(old_data->'sessions','[]'::jsonb)) s where not exists(select 1 from jsonb_array_elements(coalesce(p_data->'sessions','[]'::jsonb)) n where n->>'id'=s->>'id')) or exists(select 1 from jsonb_array_elements(coalesce(old_data#>'{adventure,rewards}','[]'::jsonb)) r where not exists(select 1 from jsonb_array_elements(coalesce(p_data#>'{adventure,rewards}','[]'::jsonb)) n where n->>'id'=r->>'id')) or exists(select 1 from jsonb_array_elements(coalesce(old_data->'restProtocols','[]'::jsonb)) r where not exists(select 1 from jsonb_array_elements(coalesce(p_data->'restProtocols','[]'::jsonb)) n where n->>'id'=r->>'id')) then raise sqlstate 'PT409' using message='Merge retained sessions, rewards and rest history before late syncing.'; end if;
  update public.sidequest_daily_logs set data=p_data,revision=revision+1,updated_at=clock_timestamp() where user_id=who and date=p_date returning revision into saved_revision;
 else
  if p_revision<>0 then raise sqlstate 'PT409' using message='Queued revision does not match the cloud.'; end if;
  insert into public.sidequest_daily_logs(user_id,date,data) values(who,p_date,p_data) returning revision into saved_revision;
 end if;
 return jsonb_build_object('entry',jsonb_build_object('date',p_date,'data',p_data,'revision',saved_revision),'serverNow',clock_timestamp());
end; $$;
revoke all on function public.sidequest_save_queued_log(date,jsonb,integer,timestamptz) from public,anon;
grant execute on function public.sidequest_save_queued_log(date,jsonb,integer,timestamptz) to authenticated;
commit;
