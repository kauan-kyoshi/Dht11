create database observer;

use observer;

-- Essa tabela armazenará informações sobre os clientes que utilizam o sistema de monitoramento.
create table tb_clientes (
	idCliente int primary key auto_increment, -- Identificador único do cliente (chave primária).
    nome varchar(100), 						  -- Nome completo do cliente.
    email varchar(100) not null unique,               -- E-mail do cliente para contato.
    telefone varchar(15) not null,             -- Telefone do cliente.
    empresa varchar(100) not null,                     -- Nome da empresa do cliente (se aplicável).
    statusCad varchar(7)                      -- Status do cliente (ativo ou inativo).
    constraint chkCad 						  -- Constraint que faz a checagem.
    check (statusCad in ('Ativo', 'Inativo')),
    cnpj varchar(20)
);

insert into tb_clientes(nome,email,telefone,empresa,statusCad,cnpj) values
('Felipe','melfexltda@example.com','11948557823','MelfexLtda','Ativo','5165161-6412'),
('Vivian','sptech@sptech.school','11944568482','Sptech School','Inativo','4851-1551-1561'),
('Maurício','itaucorp@example.com','8895415486','Itau','Ativo','263253-12376'),
('Marcela','beyondyourdreams@example.com','22954791567','ifood','Ativo','456448-54851');

select * from tb_clientes;

select concat('Seja bem-vindo ', empresa) as sejabemvindo from tb_clientes where idCliente = 4; -- select bemvindo

select concat('Seus dados cadastrados são esses:
Nome:', nome,' email: ', email,' telefone:', telefone,' empresa',empresa,' cnpj: ', cnpj) as dadoscadastro from tb_clientes where idCliente = 3;

update tb_clientes set nome = ''
	where idCliente = 0;
update tb_clientes set email = ''
	where idCliente = 0;
update tb_clientes set telefone = ''
	where idCliente = 0;
update tb_clientes set empresa = ''
	where idCliente = 0;
    



-- Essa tabela armazenará informações sobre os sensores (DHT11, etc) que estão coletando dados de temperatura e umidade.
create table tb_sensores (
	idSensor int primary key auto_increment,  -- Identificador único do cliente (chave primária).
    nomeSensor varchar(50) not null,                   -- Nome ou identificação do sensor (ex: "Sensor 1").
    localizacao varchar(100) not null,                 -- Local onde o sensor está instalado (ex: "Sala de Servidores 1").
    dataInstalacao date,                  -- Data e hora da instalação do sensor.
    statusSensor varchar(10)                  -- Status do sensor (ativo, inativo ou em manutenção).
    constraint chkStatusSensor   			  -- Constraint que faz a checagem.
    check (statusSensor in ('Ativo', 'Inativo', 'Manutenção'))
);

insert into tb_sensores(nomeSensor,localizacao,dataInstalacao,statusSensor) values
('Sensor 1', 'Rack 1 Sensor 1', '2025-03-01', 'Ativo'),
('Sensor 2', 'Rack 1 Sensor 2', '2025-03-02', 'Inativo'),
('Sensor 3', 'Rack 1 Sensor 3', '2025-03-03', 'Manutenção'),
('Sensor 4', 'Rack 1 Sensor 4', '2025-03-04', 'Ativo'),
('Sensor 5', 'Rack 1 Sensor 5', '2025-03-05', 'Ativo'),
('Sensor 6', 'Rack 1 Sensor 6', '2025-03-06', 'Manutenção'),
('Sensor 7', 'Rack 2 Sensor 1', '2025-03-07', 'Inativo'),
('Sensor 8', 'Rack 2 Sensor 2', '2025-03-08', 'Ativo'),
('Sensor 9', 'Rack 2 Sensor 3', '2025-03-09', 'Ativo'),
('Sensor 10', 'Rack 2 Sensor 4', '2025-03-10', 'Inativo');

select * from tb_sensores;

select * from tb_sensores where localizacao like 'Rack 3%';

select concat('Seu ',nomeSensor,' que está localizado no ', localizacao,' está em ',statusSensor, ',a data de instalação desse sensor foi no ', dataInstalacao) as Status_sensor
from tb_sensores where statusSensor = 'Ativo' and dataInstalacao < '2026-01-01 12:00:00';
-- Essa tabela armazenará as leituras de temperatura e umidade coletadas pelos sensores.
create table tb_leituras (
	idLeitura int primary key auto_increment, 
    sensorLeitura varchar(50),                
    temperatura decimal(10,2),                        
    umidade decimal(10,2),                            
    dataLeitura datetime                      
);

INSERT INTO tb_leituras (sensorLeitura, temperatura, umidade, dataLeitura) VALUES
('Sensor 1', 22.5, 60.0, '2025-03-01 08:30:00'),
('Sensor 2', 23.0, 62.0, '2025-03-02 09:00:00'),
('Sensor 3', 21.8, 58.5, '2025-03-03 10:15:00'),
('Sensor 4', 24.0, 65.0, '2025-03-04 11:45:00'),
('Sensor 5', 25.3, 63.2, '2025-03-05 12:00:00'),
('Sensor 6', 20.7, 55.8, '2025-03-06 14:30:00'),
('Sensor 7', 22.0, 60.5, '2025-03-07 15:45:00'),
('Sensor 8', 23.5, 64.0, '2025-03-08 16:00:00'),
('Sensor 9', 24.2, 61.7, '2025-03-09 17:10:00'),
('Sensor 10', 19.8, 59.0, '2025-03-10 18:00:00');

select * from tb_leituras;

select concat('O ', sensorleitura, ' marcou que a temperatura está em:',temperatura, 'ºC e a umidade está em:',umidade,'%. Nesse horário: ', dataLeitura) as dadoleitura 
from tb_leituras where sensorLeitura like '%1';
-- Essa tabela pode ser útil para armazenar alertas gerados quando a temperatura ou umidade ultrapassam limites pré-definidos.
create table tb_alertas (
	idAlerta int primary key auto_increment,  -- Identificador único do alerta (chave primária).
    sensorAlerta01 varchar(50),               -- Campo referenciando o nome do sensor que gerou o alerta.
    tipoAlerta varchar(11)                    -- Tipo de alerta (temperatura ou umidade).
    constraint chkAlerta                      -- Constraint que faz a checagem.
    check (tipoAlerta in ('Temperatura', 'Umidade')), 
	valor decimal(10,2),                              -- Valor que gerou o alerta.
    dataAlerta datetime,                      -- Data e hora do alerta.
    statusAlerta varchar(9)                   -- Status do alerta.
    constraint chkStatusAlerta                -- Constraint que faz a checagem.
    check (statusAlerta in ('Resolvido', 'Pendente'))
); 

INSERT INTO tb_alertas (sensorAlerta01, tipoAlerta, valor, dataAlerta, statusAlerta) VALUES
('Sensor 1', 'Temperatura', 55.3, '2025-03-01 09:00:00', 'Pendente'),
('Sensor 2', 'Umidade', 75.0, '2025-03-02 10:15:00', 'Resolvido'),
('Sensor 3', 'Temperatura', 60.2, '2025-03-03 11:00:00', 'Pendente'),
('Sensor 4', 'Temperatura', 52.8, '2025-03-04 12:30:00', 'Resolvido'),
('Sensor 5', 'Umidade', 85.4, '2025-03-05 14:00:00', 'Pendente'),
('Sensor 6', 'Temperatura', 53.5, '2025-03-06 15:45:00', 'Pendente'),
('Sensor 7', 'Umidade', 68.3, '2025-03-07 16:20:00', 'Resolvido'),
('Sensor 8', 'Temperatura', 58.1, '2025-03-08 17:10:00', 'Pendente'),
('Sensor 9', 'Umidade', 80.5, '2025-03-09 18:00:00', 'Resolvido'),
('Sensor 10', 'Temperatura', 51.7, '2025-03-10 19:30:00', 'Pendente');

select * from tb_alertas;

select concat('O ', sensorAlerta01, ' passou ',tipoAlerta,' e registrou o valor de ',valor,' nesse horário ',dataAlerta, '.e o status do problema:', statusalerta) as alerta 
from tb_alertas where statusAlerta = 'Pendente';

