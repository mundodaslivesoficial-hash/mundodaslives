-- ════════════════════════════════════════════
-- Tabela: habilitacoes (TikTok Shop onboarding)
-- ════════════════════════════════════════════
create table if not exists habilitacoes (
  id uuid primary key default gen_random_uuid(),

  -- Bloco 1: Empresa
  nome_empresa         text not null,
  cnpj                 text not null,
  data_constituicao    date not null,
  endereco_comercial   text not null,
  cnpj_doc_path        text,

  -- Bloco 1: Representante
  nome_representante    text not null,
  data_nascimento       date not null,
  nacionalidade         text not null,
  endereco_residencial  text not null,
  comp_residencia_path  text,

  -- Bloco 2: Loja
  inscricao_estadual   text not null,
  certificado_path     text,
  senha_certificado    text,

  -- Bloco 3: Produtos (JSON array)
  produtos             jsonb,

  -- Controle interno
  status               text default 'pendente',
  created_at           timestamptz default now()
);

alter table habilitacoes enable row level security;

-- Visitantes podem inserir (formulário público)
create policy "habilitacoes_anon_insert" on habilitacoes
  for insert to anon with check (true);

-- Apenas usuários autenticados leem
create policy "habilitacoes_auth_read" on habilitacoes
  for select to authenticated using (true);

-- ════════════════════════════════════════════
-- Storage: bucket privado para os arquivos
-- ════════════════════════════════════════════
insert into storage.buckets (id, name, public)
values ('habilitacoes', 'habilitacoes', false)
on conflict do nothing;

-- Visitantes podem fazer upload
create policy "habilitacoes_anon_upload" on storage.objects
  for insert to anon
  with check (bucket_id = 'habilitacoes');

-- Apenas autenticados leem os arquivos
create policy "habilitacoes_auth_read_files" on storage.objects
  for select to authenticated
  using (bucket_id = 'habilitacoes');
