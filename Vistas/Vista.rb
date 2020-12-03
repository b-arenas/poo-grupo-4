class Vista
    def mostrar(tipo)
        case tipo
        when "p"
            puts "Paciente registrado"
        when "m"
            puts "Médico registrado"
        when "cp"
            puts "Cita Presencial registrada"
        when "cv"
            puts "Cita Virtual registrada"
        end
    end

    def dniRepetido
        puts "DNI ya existe"
    end

    def mostrarExcepcion(mensaje)
        puts mensaje
    end

    def mostrarListadoPacientes(pacientes)
        puts "-----Listado de Pacientes-----"
           for paciente in pacientes
                mostrarPaciente(paciente)
           end
     end

     def mostrarListadoMedicos(medicos)
        puts "-----Listado de Médicos-----"
           for medico in medicos
                mostrarMedico(medico)
           end
     end

     def mostrarPacienteMasCitas(paciente)
        puts "-----Paciente con más citas-----"
        mostrarPaciente(paciente)
     end

     def mostrarPacienteMayorPago(paciente)
        puts "-----Paciente con mayor pago-----"
        mostrarPaciente(paciente)
     end

     def mostrarMedicoMayor(medico)
        puts "-----Médico mayor-----"
        mostrarMedico(medico)
     end

     def mostrarMedicoMenor(medico)
        puts "-----Médico menor-----"
        mostrarMedico(medico)
     end

     def mostrarMedicoMejorPagado(medicos)
        puts "-----Médico mejor pagado-----"
        mostrarMedico(medico)
     end

     def mostrarListadoMedicosEspecialidad(medicos)
        puts "-----Médicos por especialidad-----"
           for medico in medicos
               mostrarMedico(medico)
           end
     end

     def mostrarPaciente(paciente)
        puts "DNI: #{paciente.dni}\tNombre: #{paciente.nombreCompleto}\tEdad: #{paciente.edad}\tTipo de seguro: #{paciente.obtenerTipoSeguro}"
     end

     def mostrarMedico(medico)
        puts "DNI: #{medico.dni}\tCMP: #{medico.cmp}\tNombre: #{medico.nombreCompleto}\tEspecialidad: #{medico.obtenerEspecialidad}\tExperiencia: #{medico.experiencia} años\tEdad: #{medico.edad}\tSueldo: #{medico.calcularSueldo}"
     end
end