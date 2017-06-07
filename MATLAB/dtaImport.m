function B = dtaImport(fullFileName)

fID = fopen(fullFileName);
A = textscan(fID,'%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s','delimiter',char(9));
fclose(fID);
B = A{1,1};

s = size(A);

for i=2:s(2)
    B = cat(2,B,A{1,i});
end