class Administrador
    include Singleton
    attr_reader :arregloPacientes, :arregloMedicos, :arregloCitas

    def initialize
        @arregloPacientes = []
        @arregloMedicos = []
        @arregloCitas = []
    end

    def registrar(tipo, objeto)
        case tipo
        when "p"
            if objeto.validarEdad
                arregloPacientes.push(objeto)
            end
        when "m"
            arregloMedicos.push(objeto)
        when "cp"
            arregloCitas.push(objeto)
        when "cv"
            arregloCitas.push(objeto)
        end
    end

    def obtener(tipo, dni)
        lista = nil

        case tipo
        when "p"
            lista = arregloPacientes
        when "m"
            lista = arregloMedicos
        end

        for objeto in lista
            if objeto.dni == dni
                return objeto
            end
        end

        return nil
    end

    def obtenerPacienteMasCitas
        pacienteMasCitas = nil;
        mayorCitas = 0

        for paciente in arregloPacientes
            paciente.cantidadCitas = 0
            for cita in arregloCitas
                if cita.paciente.dni == paciente.dni
                    paciente.cantidadCitas += 1
                end
            end

            if paciente.cantidadCitas > mayorCitas
                mayorCitas = paciente.cantidadCitas
                pacienteMasCitas = paciente
            end
        end

        return pacienteMasCitas
    end

    def obtenerPacienteMayorPago
        pacienteMayorPago = nil;
        mayorPago = 0

        for paciente in arregloPacientes
            paciente.montoPago = 0
            for cita in arregloCitas
                if cita.paciente.dni == paciente.dni
                    paciente.montoPago += cita.calcularPrecio
                end
            end

            if paciente.montoPago > mayorPago
                mayorPago = paciente.montoPago
                pacienteMayorPago = paciente
            end
        end

        return pacienteMayorPago
    end

    def obtenerMedicoMayor
        medicoMayor = nil;
        edadMasAlta = 0

        for medico in arregloMedicos
            if medico.edad > edadMasAlta
                edadMasAlta = medico.edad
                medicoMayor = medico
            end
        end

        return medicoMayor
    end

    def obtenerMedicoMenor
        medicoMenor = nil;
        edadMasBaja = 0

        for medico in arregloMedicos
            
            if(edadMasBaja == 0)
                edadMasBaja = medico.edad
            end

            if medico.edad < edadMasBaja
                edadMasBaja = medico.edad
                medicoMenor = medico
            end
        end

        return medicoMenor
    end

    def obtenerMedicoMejorPagado
        medicoMejorPagado = nil;
        mayorPago = 0

        for medico in arregloMedicos
            if medico.calcularSueldo > mayorPago
                mayorPago = medico.calcularSueldo
                medicoMejorPagado = medico
            end
        end

        return medicoMejorPagado
    end

    def obtenerMedicosEspecialidad(especialidad)
        medicos = []

        for medico in arregloMedicos
            if(medico.especialidad == especialidad)
                medicos.push(medico)
            end
        end

        return medicos
    end

end