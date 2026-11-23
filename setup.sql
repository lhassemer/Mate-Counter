create table if not exists public.mate_bolivar_rewards (
  player_id uuid not null references public.players(id) on delete cascade,
  reward_date date not null,
  reward_type text not null check (reward_type in ('target', 'streak')),
  amount integer not null check (amount > 0),
  created_at timestamptz not null default now(),
  primary key (player_id, reward_date, reward_type)
);

create index if not exists mate_bolivar_rewards_player_idx
  on public.mate_bolivar_rewards(player_id, reward_date);

alter table public.mate_bolivar_rewards enable row level security;

drop policy if exists "mate_bolivar_rewards_anon_select" on public.mate_bolivar_rewards;
create policy "mate_bolivar_rewards_anon_select"
  on public.mate_bolivar_rewards for select
  to anon using (true);

drop policy if exists "mate_bolivar_rewards_anon_insert" on public.mate_bolivar_rewards;
create policy "mate_bolivar_rewards_anon_insert"
  on public.mate_bolivar_rewards for insert
  to anon with check (true);

drop policy if exists "mate_bolivar_rewards_anon_delete" on public.mate_bolivar_rewards;
create policy "mate_bolivar_rewards_anon_delete"
  on public.mate_bolivar_rewards for delete
  to anon using (true);

grant select, insert, delete on public.mate_bolivar_rewards to anon;
