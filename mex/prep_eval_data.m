function [ svs_feats, svs_beta, kernerl_sigma, xs_feats ] = prep_eval_data( x_ind )
% prep_data_eval
% prepare data fot struct svm eval function, mex c funciton
%
% INPUT:
%   x_ind  - frame index to prepare x data
%
% OUTPUT:
%   svs_feats - features of support vectors
%   svs_betas - beta of support vectors
%   kernerl_sigma - sigma for kernerl function
%   xs_feats - features of x_ind frame's examples
%
% Sloan Qin, 2017
% 

% declare global variables
global st_svm; 
global total_data;

svs = cell2mat(st_svm.supportVectors);
svs_beta = [svs(:).b]';

svs_x_ind = [svs(:).x_ind]';
svs_y_ind = [svs(:).y_ind]';
feats_dimension = size(total_data{1,1,1,1}, 3);
svs_feats = zeros(feats_dimension, size(svs_x_ind, 1));

for i=1:size(svs_x_ind, 1)
    svs_feats(:,i) = total_data{1,1,1,svs_x_ind(i,1)}(1,1,:,svs_y_ind(i,1));
end

kernerl_sigma = st_svm.kernerl_m_sigma;

xs_feats = squeeze(total_data{1,1,1,x_ind});

% must be double data kind
svs_feats = double(svs_feats);
svs_beta = double(svs_beta);
kernerl_sigma = double(kernerl_sigma);
xs_feats = double(xs_feats);

end

