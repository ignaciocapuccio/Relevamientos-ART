# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Active Admin Users
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

# Zones
west_zone = Zone.create!(name: 'Oeste')
north_zone = Zone.create!(name: 'Norte')

# Users
admin_user = User.create!(email: 'juan_perez@example.com', password: '12345678', password_confirmation: '12345678',
                          name: 'Juan', last_name: 'Perez', role: :admin, address: 'Av del Libertador 6363, Buenos Aires')
backoffice_user = User.create!(email: 'jose_gomez@example.com', password: '12345678', password_confirmation: '12345678',
                               name: 'Jose', last_name: 'Perez', role: :backoffice, address: 'Av del Libertador 6363, Buenos Aires')
preventor_user = User.create!(email: 'pedro_gonzalez@example.com', password: '12345678', password_confirmation: '12345678',
                              name: 'Pedro', last_name: 'Gonzalez', role: :preventor, address: 'San Nicolás 771, Buenos Aires', zone: west_zone)
another_preventor_user = User.create!(email: 'luis_rodriguez@example.com', password: '12345678', password_confirmation: '12345678',
                                      name: 'Luis', last_name: 'Rodriguez', role: :preventor, address: 'Av del Libertador 6363, Buenos Aires', zone: north_zone)

# Institutions
institution = Institution.create!(name: 'YPF', street: 'Boyacá', city: 'Buenos Aires',
                                  province: 'Buenos Aires', number: 379, surface: 120, workers_count: 123,
                                  institutions_count: 1, activity: 'Estación de Servicio', contract: 'Pepelui',
                                  postal_code: '1406', cuit: '30-12345678-2', phone_number: 45543212, zone: west_zone, address: 'Av del Libertador 6363, Buenos Aires', latitude:123.123, longitude: 123.12345)
another_institution = Institution.create!(name: 'Shell', street: 'Neuquén', city: 'Buenos Aires',province: 'Buenos Aires',
                                          number: 2329, surface: 100, workers_count: 123, institutions_count: 1,
                                          activity: 'Estación de Servicio', contract: 'Luzbelito', postal_code: '1426',
                                          cuit: '30-12345678-4', phone_number: 45443212, zone: north_zone, address: 'Av del Libertador 6363, Buenos Aires', latitude:123.123, longitude: 123.12345)

# Visits
## Visits and tasks CAP
assigned_visit_cap = Visit.create!(institution: institution, user: preventor_user, status: :assigned, priority: 9,
                                   to_visit_on: Date.today, external_id: 4)
pending_visit_cap = Visit.create!(institution: institution, status: :pending, priority: 8 , external_id: 13)
assigned_visit_cap_2 = Visit.create!(institution: institution, user: preventor_user, status: :assigned, priority: 9,
                                     to_visit_on: Date.today , external_id: 5)

completed_cap_task = Task.create!(task_type: :cap, status: :pending, visit: assigned_visit_cap )
cap_result = CapResult.create!(task: completed_cap_task, url_cloud: 'http://www.pdf995.com/samples/pdf.pdf', course_name: 'Optimización de Salidas de emergencia', contents: 'Salidas de emergencia', methodology: "agile")
Attendee.create!(name:'Julian', last_name:'Alvarez', cuil:'23-12345621-6', sector: 'Seguridad e higiene', cap_result: cap_result)
completed_cap_task.complete(DateTime.yesterday)

completed_cap_task_2 = Task.create!(task_type: :cap, status: :pending, visit: assigned_visit_cap_2 )
cap_result_2 = CapResult.create!(task: completed_cap_task_2, url_cloud: 'http://www.pdf995.com/samples/pdf.pdf', course_name: 'Como aprobar proyecto?', contents: 'Salidas de emergencia', methodology: "agile" )
Attendee.create!(name:'Tomas', last_name:'Capuccio', cuil:'23-123235621-6', sector: '5to año utn frba', cap_result: cap_result_2)
completed_cap_task_2.complete(DateTime.yesterday)

Task.create!(task_type: :cap, status: :pending, visit: pending_visit_cap )

## Visits and tasks RAR
assigned_visit_rar = Visit.create!(institution: institution, user: preventor_user, status: :assigned, priority: 20,
                                   to_visit_on: Date.today, external_id: 6)
pending_visit_rar = Visit.create!(institution: institution, status: :pending, priority: 8, external_id: 7)
assigned_visit_rar_2 = Visit.create!(institution: institution, user: preventor_user, status: :assigned, priority: 9,
                                     to_visit_on: Date.today, external_id: 8)

completed_rar_task = Task.create!(task_type: :rar, status: :pending, visit: assigned_visit_rar )
rar_result = RarResult.create!(task: completed_rar_task, url_cloud: 'http://www.pdf995.com/samples/pdf.pdf')
Worker.create!(name:'Julian', last_name:'Alvarez', cuil:'23-12345621-6', sector: 'Seguridad e higiene', rar_result: rar_result)
completed_rar_task.complete(DateTime.yesterday)

completed_rar_task_2 = Task.create!(task_type: :rar, status: :pending, visit: assigned_visit_rar_2 )
rar_result_2 = RarResult.create!(task: completed_rar_task_2, url_cloud: 'http://www.pdf995.com/samples/pdf.pdf')
worker_1 = Worker.create!(name:'Tomas', last_name:'Capuccio', cuil:'23-123235621-6', sector: 'minero', rar_result: rar_result_2)
Risk.create!(description:'derrumbe', worker: worker_1)
completed_rar_task_2.complete(DateTime.yesterday)
Task.create!(task_type: :rar, status: :pending, visit: pending_visit_rar )

pending_rar_task = Task.create!(task_type: :rar, status: :pending, visit: assigned_visit_rar_2 )

## Visits and Tasks rgrl
assigned_visit_rgrl = Visit.create!(institution: institution, user: preventor_user, status: :assigned, priority: 20,
                                   to_visit_on: Date.today, external_id: 9)
assigned_visit_rgrl_2 = Visit.create!(institution: institution, user: preventor_user, status: :assigned, priority: 9,
                                     to_visit_on: Date.today, external_id: 10)
pending_visit_rgrl = Visit.create!(institution: institution, status: :pending, priority: 8, external_id: 11)

completed_rgrl_task = Task.create!(task_type: :rgrl, status: :pending, visit: assigned_visit_rgrl )
rgrl_result = RgrlResult.create!(task: completed_rgrl_task, url_cloud: 'http://www.pdf995.com/samples/pdf.pdf')
Question.create!(description:'Quien soy', answer:'El Junior de la muelte', category: 'Maniiiel', rgrl_result: rgrl_result)

completed_rgrl_task.complete(DateTime.yesterday)

completed_rgrl_task_2 = Task.create!(task_type: :rgrl, status: :pending, visit: assigned_visit_rgrl_2 )
rgrl_result_2 = RgrlResult.create!(task: completed_rgrl_task_2, url_cloud: 'http://www.pdf995.com/samples/pdf.pdf')
Question.create!(description:'quien es el mas poronga en este conventillo del orto', answer:'yo soy el mas poronga', category: 'okupas', rgrl_result: rgrl_result_2)
completed_rgrl_task_2.complete(DateTime.yesterday)
Task.create!(task_type: :rgrl, status: :pending, visit: pending_visit_rgrl )
Task.create!(task_type: :cap, status: :pending, visit: pending_visit_rgrl )

completed_visit_rgrl = Visit.create!(institution: institution, user: preventor_user, status: :completed, priority: 4,
                                to_visit_on: Date.yesterday, completed_at: Date.yesterday, external_id: 12)

completed_rgrl_task2 = Task.create!(task_type: :rgrl, status: :pending, visit: completed_visit_rgrl )
rgrl_result2 = RgrlResult.create!(task: completed_rgrl_task2, url_cloud: 'http://www.pdf995.com/samples/pdf.pdf' )
Question.create!(description:'Quien soy', answer:'El Junior de la muelte', category: 'Maniiiel', rgrl_result: rgrl_result2)
completed_rgrl_task2.complete(DateTime.yesterday)

VisitNoise.create!(visit:completed_visit_rgrl, description: 'Sala de máquinas', decibels: 95.123456)
VisitNoise.create!(visit:completed_visit_rgrl, description: 'Comedor', decibels: 69.789)
VisitImage.create!(visit:completed_visit_rgrl, url_image: 'http://www.hotelroomsearch.net/im/hotels/gr/fabrica-11.jpg')
VisitImage.create!(visit:completed_visit_rgrl, url_image: 'https://upload.wikimedia.org/wikipedia/commons/7/71/Wolfsburg_VW-Werk.jpg')
VisitImage.create!(visit:completed_visit_rgrl, url_image: 'https://upload.wikimedia.org/wikipedia/commons/9/97/Interior_de_una_F%C3%A1brica_de_Calzado_mecanizada.JPG')
VisitImage.create!(visit:completed_visit_rgrl, url_image: 'https://www.diariomotor.com/imagenes/2016/03/fabrica-bugatti-abandonada-25.jpg')
