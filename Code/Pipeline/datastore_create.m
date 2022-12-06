% D is the path to the directory containing the images
% Example: D = 'C:\Users\Asus\Image-Image Regression\train_data\testx';
% ext is the file extension....Example '*.jpg'
function ds = datastore_create(D,ext)
%disp(fullfile(D, ext));
S = dir(fullfile(D, ext));
N = natsortfiles({S.name});
%disp(N);
F = cellfun(@(n)fullfile(D,n),N,'uni',0);
%disp(F);
ds = imageDatastore(cellstr(F));
end

