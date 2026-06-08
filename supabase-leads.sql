-- Tabela de leads do site Mundo das Lives
create table if not exists leads (
  id uuid primary key default gen_random_uuid(),
  nome text not null,
  whatsapp text not null,
  email text not null,
  empresa text,
  mensagem text,
  created_at timestamptz default now()
);

-- Habilita RLS
alter table leads enable row level security;

-- Permite insert anônimo (visitantes do site)
create policy "Allow anon insert" on leads
  for insert to anon with check (true);

-- Permite leitura apenas para usuários autenticados (você no dashboard)
create policy "Allow authenticated read" on leads
  for select to authenticated using (true);
