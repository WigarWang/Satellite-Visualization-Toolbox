classdef modelSatellite    
    properties(Access = private)
        Body            (1, 1)      body            
        Sailboard                   sailboard
        Sensor                      sensor

        Position        (3, 1)      double
        Attitude        (3, 3)      double
    end
    
    methods(Access = public)
        % constructor function
        function obj = modelSatellite(varargin)
            len = length(varargin);
            ModelProperty = [];
            for i = 1 : len
                if isstring(varargin{i})
                    switch varargin{i}
                        case "ModelProperty"
                            ModelProperty = varargin{i + 1};
                        case "Position"
                            obj.Position = varargin{i + 1};
                        case "Attitude"
                            obj.Attitude = varargin{i + 1};
                    end
                end                
            end
            
            % construct sub objects
            obj.Body = body("Position",   obj.Position, ...
                            "Attitude",   obj.Attitude, ...
                            "Size",       ModelProperty.Body.Size, ...
                            "Color",      ModelProperty.Body.Color, ...
                            "ColorAlpha", ModelProperty.Body.ColorAlpha);
            for i = 1 : length(ModelProperty.Sailboard)
                obj.Sailboard(i) = sailboard("Position",       [(ModelProperty.Sailboard(i).Size(1) + ModelProperty.Body.Size(1)) / 2; 0; 0], ...
                                             "AssemblyMatrix", ModelProperty.Sailboard(i).AssemblyMatrix, ...
                                             "Size",           ModelProperty.Sailboard(i).Size, ...
                                             "Color",          ModelProperty.Sailboard(i).Color, ...
                                             "ColorAlpha",     ModelProperty.Sailboard(i).ColorAlpha, ...
                                             "ReferenceObj",   obj.Body);
            end            
            for i = 1 : length(ModelProperty.Sensor)
                obj.Sensor = sensor("Position",       obj.Position, ...
                                    "AssemblyMatrix", ModelProperty.Sensor(i).AssemblyMatrix, ...
                                    "FieldAngle",     ModelProperty.Sensor(i).FieldAngle, ...
                                    "Length",         ModelProperty.Sensor(i).Length ,...
                                    "Color",          ModelProperty.Sensor(i).Color, ...
                                    "ColorAlpha",     ModelProperty.Sensor(i).ColorAlpha, ...
                                    "ReferenceObj",   obj.Body);
            end
        end

        function draw(obj)
            obj.Body.draw();
            for i = 1 : length(obj.Sailboard)
                obj.Sailboard(i).draw();
            end
            for i = 1 : length(obj.Sensor)
                obj.Sensor(i).draw();
            end
        end
    end
end

