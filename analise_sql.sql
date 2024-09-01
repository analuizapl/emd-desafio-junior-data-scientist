#1
SELECT COUNT(*) as total_chamados
FROM `datario.adm_central_atendimento_1746.chamado`
WHERE DATE(data_inicio) = '2023-04-01';
#2
SELECT tipo,
COUNT(id_chamado) AS quantidade_chamados
FROM datario.adm_central_atendimento_1746.chamado
WHERE DATE(data_inicio) = '2023-04-01'
GROUP BY tipo
ORDER BY quantidade_chamados DESC;
#3
SELECT bairros.nome,
COUNT(chamados.id_chamado) AS quantidade_chamados
FROM datario.adm_central_atendimento_1746.chamado chamados
left join datario.dados_mestres.bairro bairros on bairros.id_bairro = chamados.id_bairro
WHERE DATE(chamados.data_inicio) = '2023-04-01'
GROUP BY bairros.nome
ORDER BY quantidade_chamados DESC;
#4
SELECT bairros.subprefeitura,
COUNT(chamados.id_chamado) AS quantidade_chamados
FROM datario.adm_central_atendimento_1746.chamado chamados
left join datario.dados_mestres.bairro bairros on bairros.id_bairro = chamados.id_bairro
WHERE DATE(chamados.data_inicio) = '2023-04-01'
GROUP BY bairros.subprefeitura
ORDER BY quantidade_chamados DESC;
#5
SELECT chamados.id_chamado
FROM datario.adm_central_atendimento_1746.chamado chamados
left join datario.dados_mestres.bairro bairros on bairros.id_bairro = chamados.id_bairro
WHERE DATE(chamados.data_inicio) = '2023-04-01'
    AND (bairros.id_bairro IS NULL
    OR bairros.subprefeitura IS NULL)
GROUP BY chamados.id_chamado;
#6
SELECT COUNT(*) as total_chamados
FROM datario.adm_central_atendimento_1746.chamado
WHERE subtipo = 'Perturbação do sossego' AND DATE(data_inicio) between '2022-01-01' AND '2023-12-31';
#7
SELECT COUNT(*) AS total_chamados
FROM datario.adm_central_atendimento_1746.chamado c
JOIN datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos e ON DATE(c.data_inicio) BETWEEN e.data_inicial AND e.data_final
WHERE 
    c.subtipo = 'Perturbação do sossego'
    AND e.evento IN ('Reveillon', 'Carnaval', 'Rock in Rio');
#8
SELECT COUNT(*) AS total_chamados,
    e.evento
FROM datario.adm_central_atendimento_1746.chamado c
JOIN datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos e ON DATE(c.data_inicio) BETWEEN e.data_inicial AND e.data_final
WHERE c.subtipo = 'Perturbação do sossego'
GROUP BY e.evento;
#9
SELECT e.evento,
    round(COUNT(c.id_chamado) / DATE_DIFF(e.data_final, e.data_inicial, DAY),2) AS media_diaria_chamados
FROM datario.adm_central_atendimento_1746.chamado c
JOIN datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos e ON DATE(c.data_inicio) BETWEEN e.data_inicial AND e.data_final
WHERE c.subtipo = 'Perturbação do sossego'AND e.evento IN ('Reveillon', 'Carnaval', 'Rock in Rio')
GROUP BY e.evento, e.data_inicial, e.data_final
ORDER BY media_diaria_chamados DESC;
