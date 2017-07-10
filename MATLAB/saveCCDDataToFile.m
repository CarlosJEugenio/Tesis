function [filenames] = saveCCDDataToFile(DATA,dirPath)

filenames = fieldnames(DATA);


mkdir(dirPath)

%save IV data
for i = 1:length(filenames)
    if strcmp(filenames{i}, 'parent')
        continue
    elseif strcmp(filenames{i}, 'mass')
        continue
    end
    
    fid = fopen([dirPath '\' filenames{i} '.txt'],'w');
    fprintf(fid, 'Voltaje\tCorriente\n');
    fprintf(fid, 'V\tA\n');
    fprintf(fid, 'Vf\t%s, SR:%0.0f mV/s\n',DATA.parent, DATA.(filenames{i}).settings.SCANRATE);
    fprintf(fid, '%f\t%f\n', cat(1,DATA.(filenames{i}).data.Vf.curve3,DATA.(filenames{i}).data.Im.curve3));
    fclose(fid);
end

%save capacitance data
fid = fopen([dirPath '\' 'capacitance.txt'],'w');
fprintf(fid, 'Scan Rate\t Capacitancia\n');
fprintf(fid, 'mV/s\t F\n');
fprintf(fid, 'Vf\t%s, Vwindow %0.1f V\n',DATA.parent,  DATA.sample1.settings.VLIMIT2-DATA.sample1.settings.VLIMIT1);

for i = 1:length(filenames)
    if strcmp(filenames{i}, 'parent')
        continue
    elseif strcmp(filenames{i}, 'mass')
        continue
    end
    
    fprintf(fid, '%f\t%f\n', cat(1,DATA.(filenames{i}).settings.SCANRATE, DATA.(filenames{i}).data.CAPACITANCE));
end
fclose(fid);

fid = fopen([dirPath '\' 'mass.txt'],'w');
fprintf(fid,'%s \n mass = %g g\n', DATA.parent, DATA.mass);
fclose(fid);

    



