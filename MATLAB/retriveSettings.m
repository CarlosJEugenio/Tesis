function A = retriveSettings(B,varargin)
%B = datos en bruto
%args = 'SCANRATE', 'VLIMIT1', 'VLIMIT2', etc

% nargin

for i=1:nargin-1
    
    [a,b] = find(strcmp(B,varargin{i}));
    
    for j=1:length(a)
        
        
        strCell = B(a(j),b+2);
        
        for k=1:length(strCell)
            Data(k) = str2double(strCell(k));
        end
        Data(isnan(Data))=[];
        A.(varargin{i})= Data;
    end
end


end