class Cita
    attr_reader :fecha, :hora, :doctor, :paciente, :especialidad

    def initialize(fecha, hora, doctor, paciente, especialidad)
        @fecha = fecha
        @hora = hora
        @doctor = doctor
        @paciente = paciente
    end

    def calcularPrecio
    end

    def calcularDescuentoSeguro
       case paciente.tipoSeguro
       when 0
        0
       when 1
        0.3
       when 2
        0.5
       end 
    end
end