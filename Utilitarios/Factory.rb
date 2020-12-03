require './Actores/Paciente'
require './Actores/Medico'
require './Actores/Presencial'
require './Actores/Virtual'

class Factory
    def self.generarObjeto(tipo, *arg)
        case tipo
        when "p"
            Paciente.new(arg[0],arg[1],arg[2],arg[3])
        when "m"
            Medico.new(arg[0],arg[1],arg[2],arg[3],arg[4],arg[5],arg[6])
        when "cp"
            Presencial.new(arg[0],arg[1],arg[2],arg[3],arg[4],arg[5])
        when "cv"
            Virtual.new(arg[0],arg[1],arg[2],arg[3],arg[4],arg[5],arg[6])
        end
    end
end