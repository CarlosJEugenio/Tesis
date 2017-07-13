 function DATA = calculoC(varargin)
curDir = cd;
switch nargin
    case 1
        m = varargin{1} / 1000;
        Paths = uipickfiles('FilterSpec','H:\Tesis\My Gamry Data');
        specific_capacitance_flag = true;
    case 2
        path = varargin{2}; %#ok<NASGU>
        m = varargin{1} / 1000;
        specific_capacitance_flag = true;
    otherwise
        Paths = uipickfiles('FilterSpec','H:\Tesis\My Gamry Data');
        specific_capacitance_flag = true;
end

if isa(Paths,'numeric')
    error('No dir selected')
elseif isempty(Paths)
    error('No dir found')
end

%calculo de capacitancia basado en mediciones CV usando Potensiostato
%Gamry Interface5000

%open sample dir
for k = 1:length(Paths)
 
DATA = cell(length(Paths),1);
path = Paths{k};
splitPath = strsplit(path,'\');
samplename = splitPath(end);

%files in dir
cd(path)
D = dir('*.DTA');
if isempty(D)
    error('No .DTA files found')
end
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
    settings = retriveSettings(A,'SCANRATE','VLIMIT1','VLIMIT2');   %obtener configuraci�n
    m = retriveMass(A) / 1000;
    if isnan(m)
        m = 1 / 1000;   
        specific_capacitance_flag = false;
    end
        
    I = polyarea(data.Vf.(curve),data.Im.(curve)); %integral CV
    C = I / (2 * abs(settings.VLIMIT1 - settings.VLIMIT2) * m * ... %Capacitancia
        settings.SCANRATE / 1000); %scanrate is in mv, has to be in V
    %save data
    DATA{k}.(['sample' num2str(i)]).data = data; 
    DATA{k}.(['sample' num2str(i)]).settings = settings;
    DATA{k}.(['sample' num2str(i)]).data.CAPACITANCE = C;
    
    waitbar((i)/(length(D)),h,sprintf(['%i files loaded of ' num2str(length(D))],(i)))
end

delete(h)
if canceled==1
    return
end

%%
%plots

figure('Name',[ 'IV curves  ' samplename{1} '  ' sprintf('mass = %g g',m) ],'NumberTitle','off')
hold on
fnames = fieldnames(DATA{k});  %sample names
cc = hsv(length(fnames));   %color scheme
c = {}; %legend
capSr = []; %capacitance vs scanrate

for i=1:length(fnames) %number of samples
    plot(DATA{k}.(fnames{i}).data.Vf.(curve),...
         DATA{k}.(fnames{i}).data.Im.(curve)./m,'color',cc(i,:))
     
    c = cat(1,c,[D(i).name ' ' num2str(round(DATA{k}.(fnames{i}).settings.SCANRATE)) ' mV/s']);
    capSr = cat(1,capSr,[DATA{k}.(fnames{i}).settings.SCANRATE ...
                         DATA{k}.(fnames{i}).data.CAPACITANCE]);
end
%plots
% title([ strrep(samplename, '_', '\_') sprintf('mass = %g g',m) ] )
legend(strrep(c, '_', '\_'),'Location','SouthEast')
xlabel('Voltage [V]')
if specific_capacitance_flag
    ylabel('Current Density [A/g]')
else
    ylabel('Current [mA]');
end

figure('Name',[ 'Capacitance curves  ' samplename{1} '  ' sprintf('mass = %g g',m) ],'NumberTitle','off')
hold on
for i=1:length(fnames)
    plot(capSr(i,1),capSr(i,2),'*','color',cc(i,:))
end
legend(strrep(c, '_', '\_'),'Location','NorthEast')
% title([ strrep(samplename, '_', '\_') sprintf('mass = %g g',m) ] )
xlabel('Scan Rate [mV/s]')
if specific_capacitance_flag
    ylabel('Specific capacitance [F/g]')
else
    ylabel('Capacitance [mF]');
end

DATA{k}.parent = splitPath{end};
DATA{k}.mass = m;
saveCVDataToFile(DATA{k},[path '/' 'raw']);

end
cd(curDir)