create table if not exists public.tasks (
  id uuid primary key default gen_random_uuid(),
  title text not null check (char_length(trim(title)) between 1 and 80),
  description text not null default '' check (char_length(description) <= 240),
  status text not null default 'Pendiente'
    check (status in ('Pendiente', 'En progreso', 'Completada')),
  responsible_id uuid not null references auth.users(id) on delete cascade,
  created_by uuid not null references auth.users(id) on delete cascade,
  created_at timestamptz not null default now()
);

create index if not exists tasks_responsible_created_at_idx
  on public.tasks (responsible_id, created_at desc);

alter table public.tasks enable row level security;

drop policy if exists "Users read their tasks" on public.tasks;
create policy "Users read their tasks"
  on public.tasks for select to authenticated
  using (auth.uid() = responsible_id or auth.uid() = created_by);

drop policy if exists "Users create their tasks" on public.tasks;
create policy "Users create their tasks"
  on public.tasks for insert to authenticated
  with check (auth.uid() = responsible_id and auth.uid() = created_by);

drop policy if exists "Users update their tasks" on public.tasks;
create policy "Users update their tasks"
  on public.tasks for update to authenticated
  using (auth.uid() = responsible_id or auth.uid() = created_by)
  with check (auth.uid() = responsible_id or auth.uid() = created_by);

drop policy if exists "Users delete their tasks" on public.tasks;
create policy "Users delete their tasks"
  on public.tasks for delete to authenticated
  using (auth.uid() = responsible_id or auth.uid() = created_by);
