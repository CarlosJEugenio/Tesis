function DATA = calculoC(varargin)

switch nargin
    case 1
        m = varargin{1} / 1000;
        path = uigetdir('C:\Users\Public\Documents\My Gamry Data','Open sample folder');
        specific_capacitance_flag = true;
    case 2
        path = varargin{2};
        m = varargin{1} / 1000;
        specific_capacitance_flag = true;
    otherwise
        path = uigetdir('C:\Users\Public\Documents\My Gamry Data','Open sample folder');
        specific_capacitance_flag = false;
        m = 1 / 1000;
end
        

%calculo de capacitancia basado en mediciones CV usando Potensiostato
%Gamry Interface5000

%open sample dir

splitPath = strsplit(path,'\');
samplename = splitPath(end);

%files in dir
cd(path)
D = dir('*.DTA');
%%
%masa de electrodos combinados (active material mass)
% if specific_capacitance_flag
%     input = inputdlg('Ingrese masa combinada de los electrodos [mg]','Masa'); %miligramos
%     m = str2double(input{1}) / 1000; %mg to g
% else
%     m = 1/1000;
% end
%%

%waitbar
h = waitbar(0,['0 files loaded of ' num2str(length(D)-2)],'Name','Loading Files',...
            'CreateCancelBtn',...
            'setappdata(gcbf,''canceling'',1)');
setappdata(h,'canceling',0)
canceled = 0;

%which curve to use
curve = 'curve3';

for i = 1:length(D)  % empieza en 3 porque 1 y 2 son . y .. respectivamente
    if getappdata(h,'canceling')
        canceled = 1;
        break
    end
    
    A = dtaImport(fullfile(path, D(i).name)); %importar datos en bruto
    data = retriveData(A,'Vf','Im');    %obtener datos
    settings = retriveSettings(A,'SCANRATE','VLIMIT1','VLIMIT2');   %obtener configuraciòn
    
    I = trapz(data.Vf.(curve),data.Im.(curve)); %integral CV
    C = I / (2 * abs(settings.VLIMIT1 - settings.VLIMIT2) * m * ... %Capacitancia
        settings.SCANRATE / 1000); %scanrate is in mv, has to be in V
    %save data
    DATA.(['sample' num2str(i)]).data = data; 
    DATA.(['sample' num2str(i)]).settings = settings;
    DATA.(['sample' num2str(i)]).data.CAPACITANCE = C;
    
    waitbar((i)/(length(D)),h,sprintf(['%i files loaded of ' num2str(length(D))],(i)))
end

delete(h)
if canceled==1
    return
end

%%
%plots

figure
hold on
fnames = fieldnames(DATA);  %sample names
cc = hsv(length(fnames));   %color scheme
c = {}; %legend
capSr = []; %capacitance vs scanrate

for i=1:length(fnames) %number of samples
    plot(DATA.(fnames{i}).data.Vf.(curve),...
         DATA.(fnames{i}).data.Im.(curve)./m,'color',cc(i,:))
     
    c = cat(1,c,[D(i).name ' ' num2str(round(DATA.(fnames{i}).settings.SCANRATE)) ' mV/s']);
    capSr = cat(1,capSr,[DATA.(fnames{i}).settings.SCANRATE ...
                         DATA.(fnames{i}).data.CAPACITANCE]);
end
%plots
title(strrep(samplename, '_', '\_'))
legend(c,'Location','NorthWest')
xlabel('Voltage [V]')
if specific_capacitance_flag
    ylabel('Current Density [A/g]')
else
    ylabel('Current [mA]');
end

figure
hold on
for i=1:length(fnames)
    plot(capSr(i,1),capSr(i,2),'*','color',cc(i,:))
end
legend(c,'Location','NorthWest')
title(strrep(samplename, '_', '\_'))
xlabel('Scan Rate [mV/s]')
if specific_capacitance_flag
    ylabel('Specific capacitance [F/g]')
else
    ylabel('Capacitance [mF]');
end

DATA.parent = splitPath{end};
saveCVDataToFile(DATA,[path '\' 'raw']);