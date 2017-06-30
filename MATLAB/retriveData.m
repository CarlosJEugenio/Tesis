function A = retriveData(B, varargin)
%A = datos en bruto
%args = 'Vf', 'Im', etc

% nargin

for i=1:nargin-1
    
    [a,b] = find(strcmp(B,varargin{i}));
    
    for j=1:length(a)
        
        if j==length(a)
            strCell = B(a(j):end,b(j):end);
        else
            strCell = B(a(j):a(j+1),b(j):b(j+1));
        end
        
        for k=1:length(strCell)
            Data(k) = str2double(strCell(k));
        end
        Data(isnan(Data))=[];
        A.(varargin{i}).(['curve' num2str(j)]) = Data;
    end
end

end

