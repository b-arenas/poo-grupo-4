class Test
    attr_reader :controlador

    def initialize(controlador)
        @controlador = controlador
    end

    def iniciar
        #Pruebas
        controlador.registrar("p", "11111111", "Bryan Adams", 26, 0)
        controlador.registrar("p", "22222222", "Axel Rose", 23, 1)
        controlador.registrar("p", "33333333", "Alejandro Sanz", 30, 2)
        controlador.registrar("p", "44444444", "Janis Joplin", 40, 0)

        controlador.registrar("m", "55555555", 12345, "Dr. House", 1, 20, 50, 10000)
        controlador.registrar("m", "66666666", 54321, "Dr. Strange", 2, 5, 32, 7500)

        bryan = controlador.obtener("p", "11111111")
        alejandro = controlador.obtener("p", "33333333")
        house = controlador.obtener("m", "55555555")
        strange = controlador.obtener("m", "66666666")

        controlador.registrar("cp", "30/11/2020", "12:00", strange, bryan, "Lima Centro")
        controlador.registrar("cv", "02/12/2020", "15:00", house, alejandro, "Google Meet", "asanz@gmail.com")

        controlador.mostrarListadoPacientes
        controlador.mostrarPacienteMasCitas
        controlador.mostrarPacienteMayorPago
        controlador.mostrarMedicoMenor
        controlador.mostrarMedicoMayor
        controlador.mostrarMedicoMejorPagado
        controlador.mostrarMedicosEspecialidad(1)
        controlador.mostrarMedicosEspecialidad(2)
    end

    
end