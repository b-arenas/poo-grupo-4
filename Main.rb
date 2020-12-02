require 'singleton'

class Paciente
    attr_accessor :dni, :nombreCompleto, :edad, :tipoSeguro, :cantidadCitas, :montoPago

    def initialize(dni, nombreCompleto, edad, tipoSeguro)
        @dni = dni
        @nombreCompleto = nombreCompleto
        @edad = edad
        @tipoSeguro = tipoSeguro
        @cantidadCitas = 0
        @montoPago = 0
    end

    def validarEdad
        if edad < 0
            raise "Edad no permitida"
        end

        return true
    end
end

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
end

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
            arregloPacientes.push(objeto)
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
               puts "#{paciente.dni}   #{paciente.nombreCompleto} #{paciente.edad} #{paciente.tipoSeguro}"
           end
     end

     def mostrarPacienteMasCitas(paciente)
        puts "-----Paciente con más citas-----"
        puts "#{paciente.dni}   #{paciente.nombreCompleto} #{paciente.edad} #{paciente.tipoSeguro} #{paciente.cantidadCitas}"
     end

     def mostrarPacienteMayorPago
        puts "-----Paciente con mayor pago-----"
        puts "#{paciente.dni}   #{paciente.nombreCompleto} #{paciente.edad} #{paciente.tipoSeguro} #{paciente.montoPago}"
     end

     def mostrarMedicoMayor(medico)
        puts "-----Médico mayor-----"
        mostrarMedico(medico)
     end

     def mostrarMedicoMenor(medico)
        puts "-----Médico menor-----"
        mostrarMedico(medico)
     end

     def mostrarMedico(medico)
        puts "#{medico.dni}   #{medico.nombreCompleto} #{medico.edad}"
     end

     def mostrarMedicoMejorPagado
        puts "-----Médico mejor pagado-----"
           for paciente in pacientes
               puts "#{participante.nombre}   #{participante.dni} #{participante.calcularPuntaje}"
           end
     end

     def mostrarListadoMedicosEspecialidad(medicos)
        puts "-----Médicos por especialidad-----"
           for medico in medicos
               mostrarMedico(medico)
           end
     end
end

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

#Programa
puts "Iniciando programa..."
=begin
vista = Vista.new
adm = Administrador.instance
controlador = Controlador.new(vista, adm)

seleccion = 0

while(seleccion != 99)
    system('cls')
    puts "Opciones:"
    puts "1. Registrar un paciente" #Hecho
    puts "2. Registrar un médico" #Hecho
    puts "3. Registrar una cita" #Hecho
    puts "4. Listar todos los pacientes" #Hecho
    puts "5. Listar paciente con más citas" #Hecho
    puts "6. Listar paciente con mayor pago" #Hecho
    puts "7. Listar al médico menor y mayor" #Hecho
    puts "8. Listar al médico mejor pagado" #Hecho
    puts "9. Listar médicos según especialidad" #Hecho
    puts
    puts "99. Salir"
    print "Ingrese la opción deseada: "

    seleccion = gets.chomp.to_i

    case seleccion
    when 1
        controlador.registrar("p", "12345678", "Bryan Arenas", 26, 1)
        system('pause')
    when 2
        controlador.registrar("m", "87654321", 12345, "Carlos Orihuela", 1, 10, 45, 8000)
        system('pause')
    when 3
        print "Ingrese DNI de paciente: "
        dniPaciente = gets.chomp
        print "Ingrese DNI de médico: "
        dniMedico = gets.chomp
        medico = controlador.obtener("m", dniMedico)
        paciente = controlador.obtener("p", dniPaciente)
        controlador.registrar("cp", "30/11/2020", "12:00", medico, paciente, 1, "Lima Centro")
        controlador.registrar("cv", "05/12/2020", "15:00", medico, paciente, 1, "Google Meet", "bryanarenas@gmail.com")
        system('pause')
    when 4
        puts "Listado de todos los pacientes:"
        controlador.mostrarListadoPacientes
        system('pause')
    when 5
        puts "Paciente con más citas:"
        controlador.mostrarPacienteMasCitas
        system('pause')
    when 6
        puts "Paciente con mayor pago:"
        controlador.mostrarPacienteMayorPago
        system('pause')
    when 7
        puts "Médico menor:"
        controlador.mostrarMedicoMenor
        puts "Médico mayor:"
        controlador.mostrarMedicoMayor
        system('pause')
    when 8
        puts "Médico mejor pagado:"
        controlador.mostrarMedicoMejorPagado
        system('pause')
    when 9
        puts "Seleccione una especialidad:"
        puts "1. Medicina General"
        puts "2. Cardiología"
        print "Ingrese la opción deseada: "

        especialidad = gets.chomp.to_i

        case especialidad
        when 1
            puts "Medicina General:"
            controlador.mostrarMedicosEspecialidad(especialidad)
            system('pause')
        when 2
            puts "Cardiología:"
            controlador.mostrarMedicosEspecialidad(especialidad)
            system('pause')
        else
            puts "Opción incorrecta:"
            system('pause')
        end
    when 99
    else
        puts "Opción incorrecta"
        system('pause')
    end 
end
=end

#Pruebas
vista = Vista.new
adm = Administrador.instance
controlador = Controlador.new(vista, adm)

controlador.registrar("p", "12345678", "Bryan Arenas", 26, 1)
controlador.registrar("m", "87654321", 12345, "Carlos Orihuela", 1, 10, 45, 8000)
medico = controlador.obtener("m", "87654321")
paciente = controlador.obtener("p", "12345678")
controlador.registrar("cp", "30/11/2020", "12:00", medico, paciente, 1, "Lima Centro")
controlador.registrar("cv", "05/12/2020", "15:00", medico, paciente, 1, "Google Meet", "bryanarenas@gmail.com")
controlador.mostrarListadoPacientes
controlador.mostrarPacienteMasCitas
controlador.mostrarPacienteMayorPago
controlador.mostrarMedicoMenor
controlador.mostrarMedicoMayor
controlador.mostrarMedicoMejorPagado
controlador.mostrarMedicosEspecialidad(1)
controlador.mostrarMedicosEspecialidad(2)

=begin
-	El sistema debe tener un menú de ejecución de las opciones de funcionalidad que se plantee para el control adecuado. HECHO
-	El sistema debe contemplar funcionalidades la de control y cálculos. HECHO
-	Presentar el diagrama de clases UML de la solución propuesta. HECHO A MEDIAS
-	El sistema debe aplicar una programación orientada a objetos que evidencie el uso de los conceptos asociados a clase, relaciones entre clases, herencia, polimorfismo. HECHO
-	El sistema debe estar desarrollado utilizando el patrón MVC como arquitectura y el patrón Factory de creación de objetos. HECHO
-	Aplicar pruebas o demos a los métodos de negocio o comportamiento de las clases HECHO
-	Controlar con excepciones todos los ingresos de datos. POR HACER
=end