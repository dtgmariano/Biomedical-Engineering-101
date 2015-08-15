% Read .PLG file extension
function dados = funcReadPLG(Nomearq)
%Nomearq = input('Nome completo do Arquivo: ','s');
fid = fopen(Nomearq);
[cab,count] = fread(fid,1024,'uchar');
qtdcn = cab(4);
TxAms = cab(11)*256+cab(10);
NomeCan = [];
TipoCan = [];
for k = [1:qtdcn]
    [cabcn,count] = fread(fid,512,'*char');
    NomeCan = [NomeCan;[cabcn(12),cabcn(13),cabcn(14),cabcn(15),cabcn(16)]];
    TipoDesteCan = [];
    for l = [1:25]
        TipoDesteCan = [TipoDesteCan,cabcn(l+41)];
    end
    TipoCan = [TipoCan;TipoDesteCan];
        
end
%[dados,count] = fread(fid,inf,'*int16');% ATENCAO :  ESCOLHI COLOCAR OS DADOS EM UMA MATRIZ DE INTEIROS DE 16 BITS P/ ECONOMIZAR ESPAÇO
[dados,count] = fread(fid,inf,'int16');% ATENCAO :  ESCOLHI COLOCAR OS DADOS EM UMA MATRIZ DE DOUBLES PORQUE NAO PRECISO ECONOMIZAR ESPAÇO
qtdamos = count / qtdcn; % preciso saber para dar o reshape
dados = reshape(dados,qtdcn,qtdamos);
fclose(fid);