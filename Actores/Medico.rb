class Medico
    attr_reader :dni, :cmp, :nombreCompleto, :especialidad, :experiencia, :edad, :sueldoBase

    def initialize(dni, cmp, nombreCompleto, especialidad, experiencia, edad, sueldoBase)
        @dni = dni
        @cmp = cmp
        @nombreCompleto = nombreCompleto
        @especialidad = especialidad
        @experiencia = experiencia
        @edad = edad
        @sueldoBase = sueldoBase
    end

    def validarEdad
        if edad < 18
            raise "Edad no permitida"
        end

        return true
    end

    def calcularSueldo
        sueldoBase + (sueldoBase * calcularBono)
    end

    def calcularBono
        (experiencia * 1.00) / 100
    end

    def obtenerEspecialidad
        case especialidad
        when 1
            "Medicina general"
        when 2
            "Traumatología"
        when 3
            "Cardiología"
        end
     end
end