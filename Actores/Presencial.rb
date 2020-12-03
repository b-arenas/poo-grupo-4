require './Actores/Cita'

class Presencial < Cita
    attr_reader :sede

    def initialize(fecha, hora, doctor, paciente, especialidad, sede)
        super(fecha, hora, doctor, paciente, especialidad)
        @sede = sede
    end

    def calcularPrecio
        100 * (1 - calcularDescuentoSeguro)
    end
end