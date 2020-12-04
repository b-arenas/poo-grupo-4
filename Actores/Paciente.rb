class Paciente
    attr_accessor :dni, :nombreCompleto, :edad, :tipoSeguro, :cantidadCitas, :montoPago

    def initialize(dni, nombreCompleto, edad, tipoSeguro)
        @dni = dni
        @nombreCompleto = nombreCompleto
        @edad = edad
        @tipoSeguro = tipoSeguro
    end

    def validarEdad
        if edad < 0
            raise "Edad no permitida"
        end

        return true
    end

    def obtenerTipoSeguro
        case tipoSeguro
        when 0
            "Sin seguro"
        when 1
            "Seguro estatal"
        when 2
            "Seguro privado"
        end
     end
end