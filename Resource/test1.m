% test script
%% Create Figure Container
figure(1);
% clf;
hold on;
axis equal;
xlabel("x");
ylabel("y");
zlabel("z");

%% Model Setting
ModelProperty.Body.Size       = [15; 15; 15];
ModelProperty.Body.Color      = "#d5d7db";
ModelProperty.Body.ColorAlpha = 0.7;

ModelProperty.Sailboard(1).Size           = [30; 9; 0.2];
ModelProperty.Sailboard(1).AssemblyMatrix = angle2dcm(deg2rad(90), deg2rad(0), deg2rad(0), "ZYX")';
ModelProperty.Sailboard(1).Color          = ["w"; "#3e53a4"];
ModelProperty.Sailboard(1).ColorAlpha     = [1; 1];

ModelProperty.Sailboard(2).Size           = [30; 9; 0.2];
ModelProperty.Sailboard(2).AssemblyMatrix = angle2dcm(deg2rad(180), deg2rad(0), deg2rad(0), "ZYX")';
ModelProperty.Sailboard(2).Color          = ["w"; "#3e53a4"];
ModelProperty.Sailboard(2).ColorAlpha     = [1; 1];

ModelProperty.Sailboard(3).Size           = [30; 9; 0.2];
ModelProperty.Sailboard(3).AssemblyMatrix = angle2dcm(deg2rad(0), deg2rad(0), deg2rad(0), "ZYX")';
ModelProperty.Sailboard(3).Color          = ["w"; "#3e53a4"];
ModelProperty.Sailboard(3).ColorAlpha     = [1; 1];

ModelProperty.Sensor.FieldAngle     = 30;
ModelProperty.Sensor.Length         = 30;
ModelProperty.Sensor.AssemblyMatrix = angle2dcm(deg2rad(-90), deg2rad(0), deg2rad(0), "ZYX")';
ModelProperty.Sensor.Color          = "#d4ecfa";
ModelProperty.Sensor.ColorAlpha     = 0.6;

%% Draw Satellite Model
model = modelSatellite("Position", [20; 20; 10], ...
                       "Attitude", angle2dcm(deg2rad(45), deg2rad(45), deg2rad(45), "ZYX")', ...
                       "ModelProperty", ModelProperty);
model.draw();

handleAxe = gca;
handleAxe.FontName = "Consolas";
handleFig = gcf;
handleFig.Renderer = "OpenGL";

az = -45; % -30
el = 45; %  30
view([az,el])                 % set the viewing angle
