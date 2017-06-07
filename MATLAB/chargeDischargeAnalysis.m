%%
%Charge Discharge analysis Potentiostat
%Gamry Interface5000
%Carlos Eugenio 17-Nov-2016
clear all

%open sample dir
path = uigetdir('C:\Users\Public\Documents\My Gamry Data','Open sample folder');

if path==0  %user pressed cancel on dir window
    return
end

D = dir(path);
if length(D) == 4 %wrong folder
    path = [path '\' 'CHARGE_DISCHARGE']; %change it to the right one
    D = dir(path);
end
splitPath = strsplit(path,'\');
samplename = splitPath(end);

%files in dir


if length(D) == 4
   return
end
%%
%which curve to use
curve = 'curve1'; %fixed for Charge/Discharge

%waitbar
h = waitbar(0,['0 files loaded of ' num2str(length(D)-2)],'Name','Loading Files',...
            'CreateCancelBtn',...
            'setappdata(gcbf,''canceling'',1)');
setappdata(h,'canceling',0)
canceled = 0;

for i = 3:length(D)  % empieza en 3 porque 1 y 2 son . y .. respectivamente
    if getappdata(h,'canceling')
        canceled = 1;
        break
    end
    
    A = dtaImport(fullfile(path, D(i).name)); %importar datos en bruto
    data = retriveData(A,'T','Vf','Im');    %obtener datos
    settings = retriveSettings(A,'STARTTIMEOFFSET');   %obtener configuraciòn
    %save data
    DATA.(['sample' num2str(i-2)]).data = data; 
    DATA.(['sample' num2str(i-2)]).settings = settings;
    
    waitbar((i-2)/(length(D)-2),h,sprintf(['%i files loaded of ' num2str(length(D)-2)],(i-2)))
end

delete(h)
if canceled==1
    return
end

%%
%masa de electrodos combinados (active material mass)
input = inputdlg('Ingrese masa combinada de los electrodos [mg]','Masa'); %miligramos
m = str2double(input{1}) / 1000; %mg to g
%%
%plots

figure
hold on
fnames = fieldnames(DATA);  %sample names
cc = hsv(length(fnames));   %color scheme
dat = [];

%another waitbar
h2 = waitbar(0,['0 % completed'],'Name','Calculating capacitance',...
            'CreateCancelBtn',...
            'setappdata(gcbf,''canceling'',1)');
setappdata(h2,'canceling',0)
canceled = 0;
%concadenar datos [T Vf Im]
j = 1;
for i=1:length(fnames) %number of samples
    if getappdata(h2,'canceling')
        canceled = 1;
        break
    end
    
    dat = cat(1,dat,[DATA.(fnames{i}).data.T.curve3(1:end-1)' + ...
                     DATA.(fnames{i}).settings.STARTTIMEOFFSET ...
                     DATA.(fnames{i}).data.Vf.(curve)'...
                     DATA.(fnames{i}).data.Im.(curve)']);
    if DATA.(fnames{i}).data.Im.(curve)(1) > 0
        %C = integral(from(t0 to t1) i(t) dt) / (v1 - v0)
    C(j,:) = [trapz(DATA.(fnames{i}).data.T.curve3(1:end-1),...
             DATA.(fnames{i}).data.Im.(curve)) /...
             (DATA.(fnames{i}).data.Vf.(curve)(end) - DATA.(fnames{i}).data.Vf.(curve)(1)),...
              DATA.(fnames{i}).settings.STARTTIMEOFFSET];
            j = j + 1;
    Rs(j) = (DATA.(fnames{i}).data.Vf.(curve)(end) - DATA.(fnames{i}).data.Vf.(curve)(1)) / ...
        DATA.(fnames{i}).data.Im.(curve)(1);
    end
    waitbar(i/length(fnames),h2,sprintf(['Calculating... %i %% completed' ],round(i/length(fnames)*100)))
end
delete(h2)
if canceled==1
    return
end
%ordena los datos en el tiempo
[~, index] = sort( dat(:, 1) );
dat = dat(index, :);
%ordena los datos por numero de ciclo
[~, index] = sort( C(:, 2) );
C = C(index, :) / m;
% C = C(C>0);

%plot y-y (voltaje-corriente)
[AX, H1, H2] = plotyy(dat(:,1),dat(:,2),dat(:,1),dat(:,3)*1000,'plot');
%set settings
set(get(AX(1),'Title'),'String','Charge Dischage Cycle')
set(get(AX(1),'XLabel'),'String','Time [s]')
set(get(AX(1),'YLabel'),'String','Voltage [V]')
set(get(AX(2),'YLabel'),'String','Current [mA]')
set(H1,'LineStyle','-','Marker','.')
set(H2,'LineStyle','--','Marker','.')

figure, plot(C(10:end,1))
figure, plot(Rs(10:end))