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
ModelProperty_A.Body.Size       = [15; 15; 15];
ModelProperty_A.Body.Color      = "#d5d7db";
ModelProperty_A.Body.ColorAlpha = 0.7;
ModelProperty_A.Body.LineWidth  = 2;

ModelProperty_A.Sailboard(1).Size           = [30; 9; 0.2];
ModelProperty_A.Sailboard(1).AssemblyMatrix = angle2dcm(deg2rad(0), deg2rad(0), deg2rad(0), "ZYX")';
ModelProperty_A.Sailboard(1).Color          = ["w"; "#3e53a4"];
ModelProperty_A.Sailboard(1).ColorAlpha     = [1; 1];
ModelProperty_A.Sailboard(1).LineWidth      = 2;

ModelProperty_A.Sailboard(2).Size           = [30; 9; 0.2];
ModelProperty_A.Sailboard(2).AssemblyMatrix = angle2dcm(deg2rad(180), deg2rad(0), deg2rad(0), "ZYX")';
ModelProperty_A.Sailboard(2).Color          = ["w"; "#3e53a4"];
ModelProperty_A.Sailboard(2).ColorAlpha     = [1; 1];
ModelProperty_A.Sailboard(2).LineWidth      = 2;

ModelProperty_A.Sensor.FieldAngle     = 45;
ModelProperty_A.Sensor.Length         = 50;
ModelProperty_A.Sensor.AssemblyMatrix = angle2dcm(deg2rad(-90), deg2rad(0), deg2rad(0), "ZYX")';
ModelProperty_A.Sensor.Color          = "#d4ecfa";
ModelProperty_A.Sensor.ColorAlpha     = 0.6;
ModelProperty_A.Sensor.LineWidth      = 2;

ModelProperty_B.Body.Size       = [30; 30; 30];
ModelProperty_B.Body.Color      = "#f1e6cf";
ModelProperty_B.Body.ColorAlpha = 0.7;
ModelProperty_B.Body.LineWidth  = 2;

ModelProperty_B.Sailboard(1).Size           = [50; 20; 0.2];
ModelProperty_B.Sailboard(1).AssemblyMatrix = angle2dcm(deg2rad(90), deg2rad(0), deg2rad(0), "ZYX")';
ModelProperty_B.Sailboard(1).Color          = ["w"; "#84ac3f"];
ModelProperty_B.Sailboard(1).ColorAlpha     = [1; 1];
ModelProperty_B.Sailboard(1).LineWidth      = 2;

ModelProperty_B.Sailboard(2).Size           = [50; 20; 0.2];
ModelProperty_B.Sailboard(2).AssemblyMatrix = angle2dcm(deg2rad(180), deg2rad(0), deg2rad(0), "ZYX")';
ModelProperty_B.Sailboard(2).Color          = ["w"; "#84ac3f"];
ModelProperty_B.Sailboard(2).ColorAlpha     = [1; 1];
ModelProperty_B.Sailboard(2).LineWidth      = 2;

ModelProperty_B.Sailboard(3).Size           = [50; 20; 0.2];
ModelProperty_B.Sailboard(3).AssemblyMatrix = angle2dcm(deg2rad(0), deg2rad(0), deg2rad(0), "ZYX")';
ModelProperty_B.Sailboard(3).Color          = ["w"; "#84ac3f"];
ModelProperty_B.Sailboard(3).ColorAlpha     = [1; 1];
ModelProperty_B.Sailboard(3).LineWidth      = 2;

ModelProperty_B.Sailboard(4).Size           = [50; 20; 0.2];
ModelProperty_B.Sailboard(4).AssemblyMatrix = angle2dcm(deg2rad(0), deg2rad(90), deg2rad(0), "ZYX")';
ModelProperty_B.Sailboard(4).Color          = ["w"; "#84ac3f"];
ModelProperty_B.Sailboard(4).ColorAlpha     = [1; 1];
ModelProperty_B.Sailboard(4).LineWidth      = 2;

ModelProperty_B.Sailboard(5).Size           = [50; 20; 0.2];
ModelProperty_B.Sailboard(5).AssemblyMatrix = angle2dcm(deg2rad(0), deg2rad(-90), deg2rad(0), "ZYX")';
ModelProperty_B.Sailboard(5).Color          = ["w"; "#84ac3f"];
ModelProperty_B.Sailboard(5).ColorAlpha     = [1; 1];
ModelProperty_B.Sailboard(5).LineWidth      = 2;

ModelProperty_B.Sensor.FieldAngle     = 30;
ModelProperty_B.Sensor.Length         = 300;
ModelProperty_B.Sensor.AssemblyMatrix = angle2dcm(deg2rad(-90), deg2rad(0), deg2rad(0), "ZYX")';
ModelProperty_B.Sensor.Color          = "#efa2a6";
ModelProperty_B.Sensor.ColorAlpha     = 0.6;
ModelProperty_B.Sensor.LineWidth      = 2;

%% Simulation data
SeriesPosition_A = [0,   0,   0;
                    50,  50,  50;
                    121, 155, 80;
                    200, 200, 200;
                    0,   250, 100];
% rotation angle definition: ZYX
SeriesAttitude_A = [0,  0,  0;
                    45, 45, 95;
                    15, 90, 60;
                    0,  90, 0 ;
                    60,  0,  -60];
SeriesPosition_B = [0, -40, 0];
SeriesAttitude_B = [180, 0, 0];

%% Create Satellite Model Object
satellite_A = satellite("Name", "A", ...
                        "ModelProperty",  ModelProperty_A, ...
                        "SeriesPosition", SeriesPosition_A, ...
                        "SeriesAttitude", SeriesAttitude_A);
satellite_B = satellite("Name", "B", ...
                        "ModelProperty",  ModelProperty_B, ...
                        "SeriesPosition", SeriesPosition_B, ...
                        "SeriesAttitude", SeriesAttitude_B);

%% Draw Scenario
satellite_A.draw();
satellite_B.draw();

%% Draw Linkage Between Satellites
for i = 1 : satellite_A.NumMember
    plot3([SeriesPosition_A(i, 1); SeriesPosition_B(1, 1)], ...
          [SeriesPosition_A(i, 2); SeriesPosition_B(1, 2)], ...
          [SeriesPosition_A(i, 3); SeriesPosition_B(1, 3)], ...
          "LineWidth", 1, "Color", "#a1a1a1", "LineStyle", ":");
end
