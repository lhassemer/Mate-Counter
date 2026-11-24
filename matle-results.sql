create table if not exists public.matle_results (
  player_id uuid not null references public.players(id) on delete cascade,
  game_date date not null,
  moves integer not null check (moves > 0),
  played_at timestamptz not null default now(),
  primary key (player_id, game_date)
);

alter table public.matle_results enable row level security;

drop policy if exists matle_results_read_all on public.matle_results;
create policy matle_results_read_all
  on public.matle_results
  for select
  to anon, authenticated
  using (true);

drop policy if exists matle_results_insert_all on public.matle_results;
create policy matle_results_insert_all
  on public.matle_results
  for insert
  to anon, authenticated
  with check (true);

grant usage on schema public to anon, authenticated;
grant select, insert on public.matle_results to anon, authenticated;
