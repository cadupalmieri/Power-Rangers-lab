close all;
clear all;


a = load('aparelho/liquidificador.mat') ;
b = load('aparelho/torradeira.mat') ;
c = load('aparelho/vazio.mat') ;
d = load('aparelho/liqui+torra.mat') ;
e = load('aparelho/carregador.mat') ;

a = a.log;
b = b.log;
c = c.log;
d = d.log;
e = e.log;

log = [a.' b.' c.' d.' e.'].';

amostras = 128;
entradas = log(:,1:amostras);
saidas = log(:,amostras+1:amostras+8);
