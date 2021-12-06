% 绘制地球模型的问题已经解决
% 需要预先设定视角,才能模拟出勾边效果.
% 使用相同方法,可以重制重心符号.

clf
[x,y,z] = sphere(50);          % create a sphere 
s = surface(x,y,z);            % plot spherical surface
s.FaceColor = 'texturemap';    % use texture mapping
a = load("topo.mat", "topo");
[Xq, Yq] = meshgrid(1:0.1:360, 1:0.1:180);
a = interp2(a.topo, Xq, Yq, 'makima');
aa = nan(size(a, 1), size(a, 2), 3);
for i = 1 : size(a, 1)
    for j = 1 : size(a, 2)
        if a(i, j) < 0
            aa(i, j, :) = [117,168,179]/255;
        else
            aa(i, j, :) = [192,235,117]/255;
        end
    end
end
% a(a<0) = -2;
% a(a>=0) = 2;
s.CData = aa;                   % set color data to topographic data
% s.CDataMapping = "direct";
s.EdgeColor = 'none';          % remove edges
s.FaceAlpha = 1;

% axis square off                % set axis to square and remove axis
axis equal
az = -15; % -30
el = 15; %  30
view([az,el])                 % set the viewing angle

ha = gcf;
ha.Position = [300, 100, 500, 500];
hold on;

cir_angle = (0 : 0.01 : 2.1 * pi)';
cir = 1.01 * [cos(cir_angle), 0*cir_angle, sin(cir_angle)];
% plot3(cir(:, 1), cir(:, 2), cir(:, 3), 'LineWidth', 1, 'Color', 'r');
matRot = angle2dcm(deg2rad(az), deg2rad(0), deg2rad(-el), "ZYX");
cir_ = (matRot' * cir')';
plot3(cir_(:, 1), cir_(:, 2), cir_(:, 3), 'LineWidth', 1.5, 'Color', 'k');
% annotation("ellipse", [0.255, 0.255, 0.525, 0.525], 'LineWidth', 1);
xlabel("x");
ylabel("y");
zlabel("z");
