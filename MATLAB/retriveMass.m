function mass = retriveMass(A)
%A = datos en bruto
a = regexp(A,'.*(?=m)','match');
a = a(~cellfun('isempty',a));
mass = str2double(a{1});

end