require 'singleton'
require './Actores/Administrador'
require './Controladores/Controlador'
require './Vistas/Vista'
require './Pruebas/Test'

#Programa
puts "Iniciando programa..."

vista = Vista.new
admin = Administrador.instance
controlador = Controlador.new(vista, admin)

pruebas = Test.new(controlador)
pruebas.iniciar

seleccion = 0

while(seleccion != 99)
    if seleccion != 0
        system('cls')
    end
    puts "Opciones:"
    puts "1. Registrar un paciente"
    puts "2. Registrar un médico"
    puts "3. Registrar una cita"
    puts "4. Listar todos los pacientes"
    puts "5. Listar paciente con más citas"
    puts "6. Listar paciente con mayor pago"
    puts "7. Listar al médico menor y mayor"
    puts "8. Listar al médico mejor pagado"
    puts "9. Listar médicos según especialidad"
    puts
    puts "99. Salir"
    print "Ingrese la opción deseada: "

    seleccion = gets.chomp.to_i

    case seleccion
    when 1
        print "Ingrese número de documento: "
        documento = gets.chomp
        print "Ingrese nombre: "
        nombre = gets.chomp
        print "Ingrese la edad: "
        edad = gets.chomp.to_i
        print "Ingrese tipo de seguro (0:Sin seguro, 1:Seguro Nacional, 2:Seguro Particular): "
        seguro = gets.chomp.to_i

        controlador.registrar("p", documento, nombre, edad, seguro)

        system('pause')
    when 2
        print "Ingrese número de documento: "
        documento = gets.chomp
        print "Ingrese CMP: "
        cmp = gets.chomp.to_i
        print "Ingrese nombre: "
        nombre = gets.chomp
        print "Ingrese especialidad (1:Medicina General, 2:Traumatología, 3:Cardiología): "
        especialidad = gets.chomp.to_i
        print "Ingrese años de experiencia: "
        experiencia = gets.chomp.to_i
        print "Ingrese edad: "
        edad = gets.chomp.to_i
        print "Ingrese sueldo base: "
        sueldo = gets.chomp.to_f

        controlador.registrar("m", documento, cmp, nombre, especialidad, experiencia, edad, sueldo)
        system('pause')
    when 3
        controlador.mostrarListadoPacientes
        controlador.mostrarListadoMedicos

        puts ""
        puts "-----Registro de una cita-----"

        print "Ingrese DNI de paciente: "
        dniPaciente = gets.chomp
        print "Ingrese DNI de médico: "
        dniMedico = gets.chomp

        medico = controlador.obtener("m", dniMedico)
        paciente = controlador.obtener("p", dniPaciente)

        print "Ingrese fecha: "
        fecha = gets.chomp
        print "Ingrese hora: "
        hora = gets.chomp
        print "Ingrese modalidad (1:Presencial, 2:Virtual): "
        modalidad = gets.chomp.to_i

        if(modalidad == 1)
            print "Ingrese sede: "
            sede = gets.chomp

            controlador.registrar("cp", fecha, hora, medico, paciente, medico.especialidad, sede)
        elsif(modalidad == 2)
            print "Ingrese plataforma: "
            plataforma = gets.chomp
            print "Ingrese correo electrónico: "
            correo = gets.chomp

            controlador.registrar("cv", fecha, hora, medico, paciente, medico.especialidad, plataforma, correo)
        end
        
        system('pause')
    when 4
        controlador.mostrarListadoPacientes
        system('pause')
    when 5
        controlador.mostrarPacienteMasCitas
        system('pause')
    when 6
        controlador.mostrarPacienteMayorPago
        system('pause')
    when 7
        controlador.mostrarMedicoMenor
        controlador.mostrarMedicoMayor
        system('pause')
    when 8
        controlador.mostrarMedicoMejorPagado
        system('pause')
    when 9
        puts "Seleccione una especialidad:"
        puts "1. Medicina General"
        puts "2. Traumatología"
        puts "3. Cardiología"
        print "Ingrese la opción deseada: "

        especialidad = gets.chomp.to_i

        case especialidad
        when 1
            puts "Medicina General:"
            controlador.mostrarMedicosEspecialidad(especialidad)
            system('pause')
        when 2
            puts "Traumatología:"
            controlador.mostrarMedicosEspecialidad(especialidad)
            system('pause')
        when 3
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

=begin
-	El sistema debe tener un menú de ejecución de las opciones de funcionalidad que se plantee para el control adecuado. HECHO
-	El sistema debe contemplar funcionalidades la de control y cálculos. HECHO
-	Presentar el diagrama de clases UML de la solución propuesta. HECHO A MEDIAS
-	El sistema debe aplicar una programación orientada a objetos que evidencie el uso de los conceptos asociados a clase, relaciones entre clases, herencia, polimorfismo. HECHO
-	El sistema debe estar desarrollado utilizando el patrón MVC como arquitectura y el patrón Factory de creación de objetos. HECHO
-	Aplicar pruebas o demos a los métodos de negocio o comportamiento de las clases HECHO
-	Controlar con excepciones todos los ingresos de datos. POR HACER
=end