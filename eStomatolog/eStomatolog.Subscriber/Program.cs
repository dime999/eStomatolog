// See https://aka.ms/new-console-template for more information
using RabbitMQ.Client.Events;
using RabbitMQ.Client;
using System.Text;
using EasyNetQ;
using eStomatologModel;

Console.WriteLine("Hello, World!");


//var factory = new ConnectionFactory
//{
//    Uri = new Uri("amqp://test:test123@localhost:15672/#/") 
//};

//using var connection = factory.CreateConnection();
//using var channel = connection.CreateModel();

//channel.QueueDeclare(queue: "reservation_added",
//                     durable:false,
//                     exclusive:false,
//                     autoDelete:false,
//                     arguments:null);



//Console.WriteLine(" [*] Waiting for messages.");


//var consumer = new EventingBasicConsumer(channel);
//consumer.Received += (model, ea) =>
//{
//    var body = ea.Body.ToArray();
//    var message = Encoding.UTF8.GetString(body);
//    Console.WriteLine($" [x] Received {message}");
//};
//channel.BasicConsume(queue: "reservation_added",
//                     autoAck: true,
//                     consumer: consumer);

//Console.WriteLine(" Press [enter] to exit.");
//Console.ReadLine();

using (var bus = RabbitHutch.CreateBus("host=localhost"))
{
    bus.PubSub.Subscribe<Rezervacija>("test", HandleTextMessage);
    Console.WriteLine("Listening for messages. Hit <return> to quit.");
    Console.ReadLine();
}

static void HandleTextMessage(Rezervacija entity)
{
    Console.ForegroundColor = ConsoleColor.Red;
    Console.WriteLine("Got message: {0}", entity.DoktorId);
    Console.ResetColor();
}