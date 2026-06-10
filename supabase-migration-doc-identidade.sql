-- ════════════════════════════════════════════
-- Migração: campos de documento de identidade
-- Rodar apenas uma vez no Supabase SQL Editor
-- ════════════════════════════════════════════

alter table habilitacoes add column if not exists doc_frente_path      text;
alter table habilitacoes add column if not exists selfie_titular_path  text;
alter table habilitacoes add column if not exists selfie_com_doc_path  text;
