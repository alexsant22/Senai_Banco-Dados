-- 1. criar o banco de dados e a tabela tarefas
create database if not exists gerenciador_tarefas;
use gerenciador_tarefas;

create table if not exists tarefas (
    id int auto_increment primary key,
    descricao varchar(255) not null,
    status varchar(50) not null
);

-- 2. inserir 5 registros com status 'pendente'
insert into tarefas (descricao, status) values 
('revisar documentação do sistema', 'pendente'),
('atualizar módulo de segurança', 'pendente'),
('otimizar performance do banco', 'pendente'),
('gerar relatório de métricas', 'pendente'),
('realizar backup dos dados', 'pendente');

-- ativar o agendador de eventos se necessário
set global event_scheduler = on;

-- 3. evento recorrente para mudar para 'em andamento' a cada 5 minutos
delimiter //
create event if not exists atualizar_para_em_andamento
on schedule every 5 minute
starts current_timestamp
do
begin
    update tarefas set status = 'em andamento' where status = 'pendente';
    select concat('tarefas atualizadas para em andamento em: ', now()) as mensagem;
end //
delimiter ;

-- 4. evento único para mudar para 'finalizado' após 15 minutos
delimiter //
create event if not exists finalizar_tarefas
on schedule at current_timestamp + interval 15 minute
do
begin
    update tarefas set status = 'finalizado' where status = 'em andamento';
    select concat('tarefas finalizadas em: ', now()) as mensagem;
end //
delimiter ;

-- 5. comandos para visualização dos eventos
show events from gerenciador_tarefas;

-- para visualizar detalhes específicos
show create event atualizar_para_em_andamento;
show create event finalizar_tarefas;

-- comandos para exclusão (opcional)
-- drop event if exists atualizar_para_em_andamento;
-- drop event if exists finalizar_tarefas;

-- respostas às perguntas:

-- 1. se o event_scheduler estiver desativado, os eventos agendados não serão executados.
--    solução: set global event_scheduler = on;

-- 2. eventos são úteis em sistemas reais para:
--    - automatizar tarefas recorrentes (backups, relatórios)
--    - executar manutenções programadas
--    - atualizar status de processos
--    - limpeza automática de dados temporários

-- 3. diferença entre eventos:
--    - único: executa uma vez em momento específico (usando at)
--    - recorrente: executa repetidamente em intervalos regulares (usando every)