close all;
clear all;


delete(instrfind)
s=serial('/dev/tty.SLAB_USBtoUART','BaudRate',230400);
s.ReadAsyncMode = 'continuous';
fopen(s); 

C = 1;
t=1;
amostras = 100;

    
   while t < amostras+1;
       fwrite(s,76,'uint16') %write data
         i=1;
       while 1
           C=fscanf(s);
           if C ~= 'F';
           c_str = regexp(C,',','split');
           data(1,i) = str2double(c_str(1))/10;
           data(2,i) = str2double(c_str(2))/10;
           data(3,i) = str2double(c_str(3))/10;
           i=i+1;
           else
               break;
           end
   end
   
frequencia = data(1,:);
tensao = data(2,:);
corrente = data(3,:).';
index = num2str(amostras);


resultado = myNeuralNetworkFunction(corrente)
equipa = '';
if resultado(8) > 0.9
    equipa = 'Nenhum';
elseif resultado(7) > 0.9
    equipa = 'Liquidificador';
elseif resultado(6) > 0.9
    equipa = 'Torradeira';
    elseif resultado(5) > 0.9
    equipa = 'Carregador';
elseif resultado(4) > 0.9
    equipa = 'Liquidificador e torradeira';
    elseif resultado(3) > 0.9
    equipa = 'Liquidificador e carregador';
        elseif resultado(2) > 0.9
    equipa = 'Torradeira e carregador';
            elseif resultado(1) > 0.9
    equipa = 'Liquidificador e torradeira e carregador';
end
fprintf('Resultado: %s \n', equipa);


t=t;
t = t + 1;
end

fclose(s);
delete(s)
clear s