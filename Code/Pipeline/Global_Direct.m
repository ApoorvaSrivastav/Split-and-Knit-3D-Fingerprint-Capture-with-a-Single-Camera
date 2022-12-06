function Global_Direct(num,type,path)
if type ==1
    folder = 'White';
end
part = 'E.';
test_size = size(imread(strcat(path,folder,'/',part,'0.jpg')));%[1024,512,3]; %size should be multiple of 2^encoder depth
%disp(test_size);
%test_size = size(imread(strcat(path,folder,'/raw_',part,'.0.jpg')));
load('model_72.mat');
lgraph = layerGraph(net);
lgraph = removeLayers(lgraph,{'ImageInputLayer'});
lgraph = lgraph.addLayers(imageInputLayer(test_size,'Name','ImageInputLayer','Normalization','none'));
lgraph = lgraph.connectLayers('ImageInputLayer','Encoder-Stage-1-Conv-1');
newnet = assembleNetwork(lgraph);

D = strcat(path,folder,'/');
f = strcat(part,num,'.jpg');
dsTestX = datastore_create(D,f);
%dsTestX = datastore_create(strcat(D,part,'_',num,'.jpg'));
%load('new_net.mat','Layers');
 ypred = predict(newnet,dsTestX);
 A={ypred(:,:,:,1)};
 A=cell2mat(A);
 imwrite(uint8(A),strcat(path,folder,'/F.',num,'.jpg'));
end