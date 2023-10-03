using System;
using RabbitMQ.Client;
using System.Text;
using EasyNetQ;
using eStomatologServices.Interfejsi;

namespace eStomatologServices.Servisi
{
    public class MessageProducer : IMessageProducer
    {
        private readonly string _host = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "localhost";
        private readonly string _username = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "guest";
        private readonly string _password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "guest";
        private readonly string _virtualhost = Environment.GetEnvironmentVariable("RABBITMQ_VIRTUALHOST") ?? "/";

        public void SendingMessage(string message)
        {
            try
            {
                var factory = new ConnectionFactory
                {
                    HostName = _host,
                    UserName = _username,
                    Password = _password,
                    VirtualHost = _virtualhost,
                };

                using var connection = factory.CreateConnection();
                using var channel = connection.CreateModel();

                channel.QueueDeclare(queue: "trip_notifications",
                                     durable: true,
                                     exclusive: true
                                  );


                var body = Encoding.UTF8.GetBytes(message);

                channel.BasicPublish(exchange: string.Empty,
                                     routingKey: "trip_added",
                                     basicProperties: null,
                                     body: body);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"An error occurred while sending message to RabbitMQ: {ex.Message}");

            }
        }
        public void SendingObject<T>(T obj)
        {
            var host = _host;
            var username = _username;
            var password = _password;
            var virtualhost = _virtualhost;

            using var bus = RabbitHutch.CreateBus($"host={host};virtualHost={virtualhost};username={username};password={password}");

            bus.PubSub.Publish(obj);
        }
    }
}

