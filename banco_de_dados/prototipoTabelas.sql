-- Criando o banco de dados da Observer
create database observer;

-- Utilizando o banco de dados
use observer;

-- Essa tabela armazenará informações sobre os clientes que utilizam o sistema de monitoramento.
create table tb_clientes (
	idCliente int primary key auto_increment,  -- Identificador único do cliente (chave primária).
    email varchar(100) not null unique,        -- E-mail do cliente para contato.
    telefone varchar(15) not null,             -- Telefone do cliente.
    empresa varchar(100) not null,             -- Nome da empresa do cliente (se aplicável).
    statusCad varchar(7)                       -- Status do cliente (ativo ou inativo).
    constraint chkCad 						   -- Constraint que faz a checagem.
    check (statusCad in ('Ativo', 'Inativo')),
    cnpj varchar(20) not null unique           -- Número do CNPJ da empresa
);

-- Inserindo dados na tabela clientes
insert into tb_clientes (email, telefone, empresa, statusCad, cnpj) values
('melfexltda@example.com','11948557823','MelfexLtda','Ativo','12.345.678/0001-90'),
('sptech@sptech.school','11944568482','Sptech School','Inativo','23.456.789/0001-01'),
('itaucorp@example.com','8895415486','Itau','Ativo','34.567.890/0001-12'),
('beyondyourdreams@example.com','22954791567','Ifood','Ativo','45.678.901/0001-23');

-- Verificando dados na tabela clientes
select * from tb_clientes;

-- Select concatenando com a mensagem "Seja bem-vindo" na empresa com id = 4
select concat('Seja bem-vindo ', empresa) as Mensagem from tb_clientes where idCliente = 4;

-- Select mostrando os dados da empresa com id = 3
select concat('E-mail: ', email, '\nTelefone: ', telefone, '\nEmpresa: ',empresa, '\nCNPJ: ', cnpj) as dadosCadastro from tb_clientes where idCliente = 3;

update tb_clientes set cnpj = ''
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
    nomeSensor varchar(50) not null,          -- Nome ou identificação do sensor (ex: "Sensor 1").
    localizacao varchar(100) not null,        -- Local onde o sensor está instalado (ex: "Sala de Servidores 1").
    dataInstalacao date,                      -- Data e hora da instalação do sensor.
    statusSensor varchar(10)                  -- Status do sensor (ativo, inativo ou em manutenção).
    constraint chkStatusSensor   			  -- Constraint que faz a checagem.
    check (statusSensor in ('Ativo', 'Inativo', 'Manutenção'))
);

-- Inserindo dados na tabela sensores
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

-- Verificando dados na tabela sensores
select * from tb_sensores;

-- Select utilizando operador Like
select * from tb_sensores where localizacao like 'Rack 1%';

select concat('O ', nomeSensor, ' está como ', statusSensor, '\nA instalação desse sensor foi no ', dataInstalacao) as Status_sensor
from tb_sensores where statusSensor = 'Ativo' and dataInstalacao < '2026-01-01 12:00:00';

-- Essa tabela armazenará as leituras de temperatura e umidade coletadas pelos sensores.
create table tb_leituras (
	idLeitura int primary key auto_increment, 
    sensorLeitura varchar(50),                
    temperatura decimal(10,2),                        
    umidade decimal(10,2),                            
    dataLeitura datetime                      
);

-- Inserindo dados na tabela de leituras
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

-- Verificados os dados da tabela
select * from tb_leituras;

-- Select utilizando Concat
select concat('O ', sensorleitura, ' marcou que a temperatura está em:',temperatura, 'ºC e a umidade está em:',umidade,'%. Nesse horário: ', dataLeitura) as Dado_leitura 
from tb_leituras where sensorLeitura like '%1';

-- Essa tabela pode ser útil para armazenar alertas gerados quando a temperatura ou umidade ultrapassam limites pré-definidos.
create table tb_alertas (
	idAlerta int primary key auto_increment,  -- Identificador único do alerta (chave primária).
    sensorAlerta varchar(50),                 -- Campo referenciando o nome do sensor que gerou o alerta.
    tipoAlerta varchar(11)                    -- Tipo de alerta (temperatura ou umidade).
    constraint chkAlerta                      -- Constraint que faz a checagem.
    check (tipoAlerta in ('Temperatura', 'Umidade')), 
	valor decimal(10,2),                      -- Valor que gerou o alerta.
    dataAlerta datetime,                      -- Data e hora do alerta.
    statusAlerta varchar(9)                   -- Status do alerta.
    constraint chkStatusAlerta                -- Constraint que faz a checagem.
    check (statusAlerta in ('Resolvido', 'Pendente'))
); 

-- Inserindo dados na tabela alertas
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

-- Verificando os dados da tabela
select * from tb_alertas;

-- Select utilizando Concat com a mensagem Alerta
select concat('O ', sensorAlerta01, ' passou a ', tipoAlerta,' e registrou o valor de ', valor,' nesse horário ', dataAlerta, '. \nO status do problema está ', statusalerta) as Alerta 
from tb_alertas where statusAlerta = 'Pendente';