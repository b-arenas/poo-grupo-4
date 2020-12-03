require './Actores/Cita'

class Virtual < Cita
    attr_reader :plataforma, :correo

    def initialize(fecha, hora, doctor, paciente, especialidad, plataforma, correo)
        super(fecha, hora, doctor, paciente, especialidad)
        @plataforma = plataforma
        @correo = correo
    end

    def calcularPrecio
        80 * (1 - calcularDescuentoSeguro)
    end
end