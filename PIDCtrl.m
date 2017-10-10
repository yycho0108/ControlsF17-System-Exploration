classdef PIDCtrl < handle
    properties
        k_p;
        k_i;
        k_d;
        e_prv;
        e_acc;
        t_prv;
    end
    methods
        function obj = PIDCtrl(k_p, k_i, k_d)
            obj.k_p = k_p;
            obj.k_i = k_i;
            obj.k_d = k_d;
            obj.e_prv = 0.0;
            obj.e_acc = 0.0;
            obj.t_prv = 0.0;
        end
        function u = control(obj, t, e)
            dt = (t - obj.t_prv);
            
            % compute output
            e_d = 0.0;
            if dt > 0
                e_d = (e - obj.e_prv) / dt;
            end
            e_i = obj.e_acc;
            e_p = e;
            u = obj.k_p*e_p + obj.k_i*e_i + obj.k_d*e_d;
            
            % update states
            obj.e_prv = e;
            obj.e_acc = obj.e_acc + e * dt;
            obj.t_prv = t;
        end
    end
        
end