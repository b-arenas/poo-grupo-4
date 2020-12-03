require './Utilitarios/Factory'

class Controlador
    attr_reader :vista, :modelo

    def initialize(vista, modelo)
        @vista = vista
        @modelo = modelo
    end

    def registrar(tipo, *arg)
        dni = nil
        
        case tipo
        when "p"
            if (modelo.obtener(tipo, dni) != nil)
                vista.dniRepetido
                return
            end
        when "m"
            if (modelo.obtener(tipo, dni) != nil)
                vista.dniRepetido
                return
            end
        end
        
      begin
            objeto = Factory.generarObjeto(tipo,*arg)
            modelo.registrar(tipo, objeto)      
            vista.mostrar(tipo)
      rescue Exception => e
         vista.mostrarExcepcion(e.message)
      end
    end

    def obtener(tipo, dni)
        modelo.obtener(tipo, dni)
    end

    def mostrarListadoPacientes
        arreglo = modelo.arregloPacientes
        vista.mostrarListadoPacientes(arreglo)
    end

    def mostrarListadoMedicos
        arreglo = modelo.arregloMedicos
        vista.mostrarListadoMedicos(arreglo)
    end

    def mostrarPacienteMasCitas
        paciente = modelo.obtenerPacienteMasCitas
        vista.mostrarPacienteMasCitas(paciente)
    end

    def mostrarPacienteMayorPago
        paciente = modelo.obtenerPacienteMayorPago
        vista.mostrarPacienteMayorPago(paciente)
    end

    def mostrarMedicoMayor
        medico = modelo.obtenerMedicoMayor
        vista.mostrarMedicoMayor(medico)
    end

    def mostrarMedicoMenor
        medico = modelo.obtenerMedicoMenor
        vista.mostrarMedicoMenor(medico)
    end

    def mostrarMedicoMejorPagado
        medico = modelo.obtenerMedicoMejorPagado
        vista.mostrarMedico(medico)
    end

    def mostrarMedicosEspecialidad(especialidad)
        arreglo = modelo.obtenerMedicosEspecialidad(especialidad)
        vista.mostrarListadoMedicosEspecialidad(arreglo)
    end
end